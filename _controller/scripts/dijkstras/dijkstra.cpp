// #include <arpa/inet.h>
// #include <netinet/in.h>
// #include <stdio.h>
// #include <stdlib.h>
// #include <string.h>
#include <dirent.h>
#include <bits/stdc++.h>

using namespace std;

#define INF 9999
#define MAX 10
#define M 15
#define N 150
#define NEIGH_DATA_FLDR "../lsdb-client/data"
#define OUTPUT_FLDR "routes"

#include "helpers.h"

int main(int argc, char* argv[]){
    struct dirent *de;
    string str;
    char buf[512];
    DIR *dr = opendir(NEIGH_DATA_FLDR);
    FILE *fp;
    int G[MAX][MAX], node_count = 0, src_node, dst_node, nhop[MAX];
    map<string, int> node_num;
    map<int, string> node_ip_str;

    bool debug = false;
    if(argc > 1){
        if(strcmp(argv[1], "-d") == 0){
            debug = true;
        }
    }else{
        printf("USAGE: ./dijkstra [-d (debug)]\n");
    }

    if(dr == NULL){
        printf("ERROR: opening directory");
        return 0;
    }
    while( (de = readdir(dr)) != NULL ){
        if( strstr(de->d_name, ".txt") ){
            str.assign(de->d_name, 0, strrchr(de->d_name, '.') - de->d_name);
            node_num[str] = node_count;
            node_ip_str[node_count] = str;
            node_count++;
            debug && printf("%s :\t %d\n", str.c_str(), node_num[str]);
        }
    }
    closedir(dr);
    for(int i = 0; i < node_count; i++){
        for(int j = 0; j < node_count; j++){
            G[i][j] = 0;
        }
    }
    dr = opendir(NEIGH_DATA_FLDR);
    while( (de = readdir(dr)) != NULL ){
        if( strstr(de->d_name, ".txt") ){
            sprintf(buf, "%s/%s",NEIGH_DATA_FLDR, de->d_name);
            fp = fopen(buf, "r");
            if(fp){
                str.assign(de->d_name, 0, strrchr(de->d_name, '.') - de->d_name);
                src_node = node_num[str];
                debug && printf("\n%s", de->d_name);
                while(fp && fgets(buf, sizeof(buf), fp)){
                    buf[strlen(buf)-1] = 0;
                    debug && printf("\n%s", buf);
                    str.assign(buf);
                    dst_node = node_num[str];
                    G[src_node][dst_node] = 1;
                    G[dst_node][src_node] = 1;
                }
                debug && printf("\n");
            }
            fclose(fp);
        }
    }
    for(int start = 0; start < node_count; start++){
        dijkstra(G, node_count, start, nhop);
        sprintf(buf, "%s/%s.txt", OUTPUT_FLDR, node_ip_str[start].c_str());
        fp = fopen(buf, "w");
        debug && printf("\nsrc: %s\n", node_ip_str[start].c_str());
        for(int node = 0; node < node_count; node++){
            fprintf(fp, "%s,%s\n", node_ip_str[node].c_str(), node_ip_str[nhop[node] ].c_str());
            debug && printf("%s,%s\n", node_ip_str[node].c_str(), node_ip_str[nhop[node] ].c_str());
        }
        fclose(fp);
    }
    closedir(dr);
    return 0;
}
