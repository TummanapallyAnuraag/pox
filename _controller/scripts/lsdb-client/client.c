#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>

#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#define SERVER_PORT 12345
#define MAX_LINE 256

int main(int argc, char * argv[]) {
    FILE *fp;
    struct hostent *hp;
    struct sockaddr_in sin;
    char *host;
    char buf[MAX_LINE];
    int s;
    int len;
    if (argc>=2) {
        host = argv[1];
    }
    else {
        fprintf(stderr, "usage: ./client host <port>\n");
        exit(1);
    }
    /* translate host name into peer's IP address */
    hp = gethostbyname(host);
    if (!hp) {
        fprintf(stderr, "unknown host: %s\n", host);
        exit(1);
    }
    /* build address data structure */
    bzero((char *)&sin, sizeof(sin));
    sin.sin_family = AF_INET;
    bcopy(hp->h_addr, (char *)&sin.sin_addr, hp->h_length);
    if(argc != 3)
        sin.sin_port = htons(SERVER_PORT);
    else
        sin.sin_port = htons(atoi(argv[2]));

    /* active open */
    if ((s = socket(PF_INET, SOCK_STREAM, 0)) < 0) {
        perror("socket");
        exit(1);
    }
    if (connect(s, (struct sockaddr *)&sin, sizeof(sin)) < 0) {
        perror("connect");
        close(s);
        exit(1);
    }
    sprintf(buf, "LSDB-REQ");
    buf[MAX_LINE-1] = '\0';
    len = strlen(buf) + 1;
    send(s, buf, len, 0);
    printf("Requesting LSDB from %s ...\n", host);
    
    /* get neighbours of the router and save to file */
    sprintf(buf, "data/%s.txt", host);
    fp = fopen(buf, "w");
    while (len = recv(s, buf, sizeof(buf), 0)){
        fputs(buf, stdout);
        fputs(buf, fp);
        fflush(stdout);
    }
    fclose(fp);
}
