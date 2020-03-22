#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <getopt.h>

#include <locale.h>
#include <unistd.h>
#include <time.h>

#include <bpf/bpf.h>
/* Lesson#1: this prog does not need to #include <bpf/libbpf.h> as it only uses
 * the simple bpf-syscall wrappers, defined in libbpf #include<bpf/bpf.h>
 */

#include <net/if.h>
#include <linux/if_link.h> /* depend on kernel-headers installed */

#include "../includes/common/common_params.h"
#include "../includes/common/common_user_bpf_xdp.h"
#include "common_kern_user.h"
#include "bpf_util.h" /* bpf_num_possible_cpus */

const char *pin_dir =  "/sys/fs/bpf/ovs-router";

int main(int argc, char **argv){
	struct bpf_map_info info = { 0 };
	int map_fd = open_bpf_map_file(pin_dir, "counter", &info);
	if (map_fd < 0)
		return EXIT_FAIL_BPF;
	printf("%d\n", map_fd);
	int key = 0, val = 0;
	bpf_map_update_elem(map_fd, &key, &val, 0);

	return 0;
}
