#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>

#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#define SERVER_PORT 12345
#define MAX_PENDING 5
#define MAX_LINE 256
#define NEIGH_FILE "data/neighbours.txt"

int main(int argc, char * argv[]) {
    printf("USAGE: ./server [12345]\n");

    FILE *fp;
    fp = fopen(NEIGH_FILE, "r");

    struct sockaddr_in sin;
    char buf[MAX_LINE];
    int len;
    int s, new_s;
    /* build address data structure */
    bzero((char *)&sin, sizeof(sin));
    sin.sin_family = AF_INET;
    sin.sin_addr.s_addr = INADDR_ANY;
    if(argc != 2)
        sin.sin_port = htons(SERVER_PORT);
    else
        sin.sin_port = htons(atoi(argv[1]));
    /* setup passive open */
    if ((s = socket(PF_INET, SOCK_STREAM, 0)) < 0) {
        perror("socket");
        exit(1);
    }
    if ((bind(s, (struct sockaddr *)&sin, sizeof(sin))) < 0) {
        perror("bind");
        exit(1);
    }
    listen(s, MAX_PENDING);
    /* wait for connection, then receive and print text */
    while(1) {
        if ((new_s = accept(s, (struct sockaddr *)&sin, &len)) < 0){
            perror("accept");
            exit(1);
        }
        while (len = recv(new_s, buf, sizeof(buf), 0)){
            fputs(buf, stdout);
            fflush(stdout);
            if(strcmp(buf, "LSDB-REQ") == 0){
                break;
            }
        }
        printf("\nREQUEST ACCEPTED\n");
        char *line = NULL;
        size_t length = 0;
        ssize_t read;
        if(fp == NULL)
            exit(EXIT_FAILURE);

        while((read = getline(&line, &length, fp)) != -1) {
            sprintf(buf, "%s", line);
            buf[MAX_LINE-1] = '\0';
            len = strlen(buf) + 1;
            send(new_s, buf, len, 0);
        }
        fclose(fp);
        fp = fopen(NEIGH_FILE, "r");

        free(line);
        close(new_s);
    }
}
