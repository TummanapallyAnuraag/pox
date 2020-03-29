/* SPDX-License-Identifier: GPL-2.0 */
#include <linux/bpf.h>
#include "bpf_helpers.h"
#include "bpf_endian.h"
#include "common_kern_user.h" /* defines: struct datarec; */
#include "../includes/common/parsing_helpers.h"
#include "../includes/common/rewrite_helpers.h"

/* cat /sys/kernel/debug/tracing/trace_pipe */
#define bpf_printk(fmt, ...)                                    \
({                                                              \
	char ____fmt[] = fmt;                                   \
	bpf_trace_printk(____fmt, sizeof(____fmt),              \
                         ##__VA_ARGS__);                        \
})

#define BPF_MAX_MARK    512
#define PIN_NONE        0
#define PIN_OBJECT_NS   1
#define PIN_GLOBAL_NS   2
#define BPF_ANY         0

struct bpf_map_def SEC("maps") counter = {
	.type        = BPF_MAP_TYPE_ARRAY,
	.key_size    = sizeof(int),
	.value_size  = sizeof(int),
	// .map_flags   = BPF_F_NO_PREALLOC,
	.max_entries = 10,
};

struct bpf_map_def SEC("maps") tx_port = {
	.type = BPF_MAP_TYPE_DEVMAP,
	.key_size = sizeof(int),
	.value_size = sizeof(int),
	.max_entries = 10,
};

struct bpf_map_def SEC("maps") sw_nics = {
	.type = BPF_MAP_TYPE_ARRAY,
	.key_size = sizeof(int),	// iface number.
	.value_size = 6,	// dev mac address
	.max_entries = 10,
};

struct lpm_val {
	__u8 dst_mac[6];
	__u8 out_of_port;	// output openflow port 
};


struct bpf_map_def SEC("maps") routes = {
	.type		= BPF_MAP_TYPE_LPM_TRIE,
	.key_size	= 8,
	.value_size	= sizeof(struct lpm_val),
	.map_flags	= BPF_F_NO_PREALLOC,
	.max_entries = BPF_MAX_MARK,
};


SEC("xdp_pass")
int  xdp_pass_func(struct xdp_md *ctx)
{
	void *data = (void *)(long)ctx->data;
	void *data_end = (void *)(long)ctx->data_end;
	struct ethhdr *eth = data;

	/* Check if Data size is atleast as big as standard Ethernet Header */
	if (data + sizeof(struct ethhdr) > data_end)
		return XDP_PASS;

	/* Update Counter for each packet recieved */
    int int_key = 0;
    int *int_val;
    int_val = bpf_map_lookup_elem(&counter, &int_key);
    if(int_val){
        (*int_val)++;
	}

	/* All Non-IP Packets go through normal system functionality */
	if (eth->h_proto != __constant_htons(ETH_P_IP))
	return XDP_PASS;

    struct iphdr   *ip   = (data + sizeof(struct ethhdr));
	/* Check if Data size is atleast as big as standard IP Header */
	if(ip + sizeof(struct iphdr) > data_end)
		return XDP_PASS;

	__u32 dst_ip = ip->daddr;

	union {
		__u32 b32[2];
		__u8 b8[8];
	} key4;
    struct lpm_val *val = NULL;

	key4.b32[0] = 32;
	key4.b8[4] = dst_ip & 0xff;
	key4.b8[5] = (dst_ip >> 8) & 0xff;
	key4.b8[6] = (dst_ip >> 16) & 0xff;
	key4.b8[7] = (dst_ip >> 24) & 0xff;

	// search the LPM_TRIE
    val = bpf_map_lookup_elem(&routes, &key4);
    if(val){
		bpf_printk("TRIE hit!, output=%d\n", val->out_of_port);
		int ifaceno = 3;
		__u8 *srcmac_addr;
		srcmac_addr = bpf_map_lookup_elem(&sw_nics, &ifaceno);
		if(srcmac_addr){
			char buffer[30];
			int run = 0;
			/*
			Unroll the loop, and convert MAC address from array to string:
			https://stackoverflow.com/questions/56107380/is-loops-allowed-in-ebpf-kernel-program
			PS: sprintf couldn't be used in kernel..so this work around
			 */
			#pragma clang loop unroll(full)
			for(int p = 0; p < 6; p++){
				if( (srcmac_addr[p]>>4) > 9  ){
					buffer[run] = (srcmac_addr[p]>>4) - 10 + 'A';
				}else{
					buffer[run] = (srcmac_addr[p]>>4) + '0';
				}
				run++;
				if( (srcmac_addr[p]&0x0f) > 9  ){
					buffer[run] = (srcmac_addr[p]&0x0f) - 10 + 'A';
				}else{
					buffer[run] = (srcmac_addr[p]&0x0f) + '0';
				}
				if(p != 5){
					run++;
					buffer[run] = ':';
				}
				run++;
			}
			buffer[run] = 0;
			bpf_printk("Iface MAC Addr: %s\n", buffer);
		}
	}else{
		bpf_printk("TRIE miss for..\n");
		bpf_printk("%d\n", key4.b8[4]);
	    bpf_printk("%d\n", key4.b8[5]);
	    bpf_printk("%d\n", key4.b8[6]);
	    bpf_printk("%d\n", key4.b8[7]);
	}

	/*
	2: enp2s0
	3: enp2s1
	4: enp0s31f6
	send all packets to enp2s1
	MAC of enp0s31f6 - e0 : d5 : 5e : 46 : 58 : 88
	*/
	// __u8 dst[6], src[6];
	// src[0] = 0xe0; dst[0] = 0x0c;
	// src[1] = 0xd5; dst[1] = 0x54;
	// src[2] = 0x5e; dst[2] = 0xa5;
	// src[3] = 0x46; dst[3] = 0x16;
	// src[4] = 0x58; dst[4] = 0xcf;
	// src[5] = 0x88; dst[5] = 0x27;

	// __builtin_memcpy(eth->h_source, src, ETH_ALEN);
	// __builtin_memcpy(eth->h_dest, dst, ETH_ALEN);

	// return bpf_redirect_map(&tx_port, 3, 0);
	return XDP_PASS;
}

char _license[] SEC("license") = "GPL";
