#include <stdlib.h>
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netinet/tcp.h>
#include <netinet/ip.h>
#include <netpacket/packet.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <getopt.h>
#include <string.h>
#include <arpa/inet.h>
#include <stdio.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <malloc.h>
#include <net/ethernet.h>
#include <sys/ioctl.h>
#include <net/if.h>
#include <string.h>
#include <sys/types.h>
#include <time.h>

#include <signal.h>

#define ETHSIZE         14
#define IPHSIZE         20
#define TCPHSIZE        20

typedef unsigned char  BYTE;             /* 8-bit   */
typedef unsigned short BYTEx2;           /* 16-bit  */
typedef unsigned long  BYTEx4;           /* 32-bit  */

typedef uint64_t u64;
typedef uint32_t u32;
typedef uint16_t u16;

enum _Boolean_  { FALSE=0, TRUE=1 };

int create_socket(char *device){
    int sock_fd;
    struct ifreq ifr;
    struct sockaddr_ll sll;
    memset(&ifr, 0, sizeof(ifr));
    memset(&sll, 0, sizeof(sll));

    sock_fd = socket(PF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
    // sock_fd = socket(PF_PACKET, SOCK_RAW, IPPROTO_RAW);
    if(sock_fd == 0) { printf("ERR: socket creation for device: %s\n", device); return FALSE; }

    strncpy(ifr.ifr_name, device, sizeof(ifr.ifr_name));
    if(ioctl(sock_fd, SIOCGIFINDEX, &ifr) == -1) { printf(" ERR: ioctl failed for device: %s\n", device); return FALSE; }

    /*promiscous mode*/
    struct packet_mreq mreq;
    memset(&mreq,0,sizeof(mreq));
    mreq.mr_ifindex = ifr.ifr_ifindex;
    mreq.mr_type = PACKET_MR_PROMISC;
    mreq.mr_alen = 6;
    if (setsockopt(sock_fd,SOL_PACKET,PACKET_ADD_MEMBERSHIP,(void*)&mreq,(socklen_t)sizeof(mreq)) < 0){
    printf(" ERR: promiscous mode setup for device: %s\n", device); return FALSE;
    }

    sll.sll_family      = AF_PACKET;
    sll.sll_ifindex     = ifr.ifr_ifindex;
    sll.sll_protocol    = htons(ETH_P_ALL);
    if(bind(sock_fd, (struct sockaddr *) &sll, sizeof(sll)) == -1) { printf("ERR: bind failed for device: %s\n", device); return FALSE; }
    return sock_fd;
}

/* stop listening to HELLO packets after INTERVAL seconds */
#define INTERVAL 30
#define NEIGH_FILE "data/neighbours.txt"
FILE *fp;

void alarmHandler(int signo){
    printf("=== Timer expired [%d sec]! ===\n", INTERVAL);
    if(fp)
        fclose(fp);
    exit(0);
}

int main(int argc, char ** argv){
    if(argc != 2){
        printf("USAGE: sudo ./listen eno1 \n");
        return 0;
    }
    BYTE buf[300];
    memset(buf, 0, 300);

    alarm(INTERVAL);
    signal(SIGALRM, alarmHandler);

    fp = fopen(NEIGH_FILE, "w");
    int sock_fd = create_socket(argv[1]);

    if(!(sock_fd) ) { printf("no sock_fd found\n"); return -1; }
    while (read(sock_fd, buf, 300) > 0){
        if(buf[ETHSIZE-2] == 0x08 && buf[ETHSIZE-1] == 0x00){
            /* // IP v4 packet
            printf("DST: %02x:%02x:%02x:%02x:%02x:%02x\t", buf[0], buf[1], buf[2], buf[3], buf[4], buf[5] );
            printf("SRC: %02x:%02x:%02x:%02x:%02x:%02x\t", buf[0+6], buf[1+6], buf[2+6], buf[3+6], buf[4+6], buf[5+6] );
            printf("TYP: %02x%02x\n", buf[12], buf[13]);
            */
            if(buf[ETHSIZE + 9] == 0x59){
                // OSPF packet
                printf("=== OSPF Packet Rx! ===\n");
                printf("ospf msg type: %02x\n", buf[ETHSIZE + IPHSIZE + 1]);
                printf("ip-src: %d.%d.%d.%d\t", buf[ETHSIZE + 12], buf[ETHSIZE + 13], buf[ETHSIZE + 14], buf[ETHSIZE + 15]);
                printf("ip-dst: %d.%d.%d.%d\t", buf[ETHSIZE + 16], buf[ETHSIZE + 17], buf[ETHSIZE + 18], buf[ETHSIZE + 19]);
                printf("ip-proto: %02x\n\n", buf[ETHSIZE + 9]);

                fprintf(fp, "%d.%d.%d.%d\n", buf[ETHSIZE + 12], buf[ETHSIZE + 13], buf[ETHSIZE + 14], buf[ETHSIZE + 15]);
            }
        }
    }
}
