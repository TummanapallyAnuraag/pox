void dijkstra(int G[MAX][MAX],int n,int startnode, int nhop[MAX]){

    int cost[MAX][MAX],distance[MAX], pred[MAX];
    int visited[MAX],count,mindistance,nextnode,i,j, temp;

    for(i=0;i<n;i++)
        for(j=0;j<n;j++)
            if(G[i][j]==0)
                cost[i][j]=INF;
            else
                cost[i][j]=G[i][j];

    //initialize pred[],distance[] and visited[], nhop
    for(i=0;i<n;i++){
        distance[i]=cost[startnode][i];
        pred[i]=startnode;
        nhop[i] = i;
        visited[i]=0;
    }

    distance[startnode]=0;
    visited[startnode]=1;
    count=1;

    while(count<n-1)
    {
        mindistance=INF;

        //nextnode gives the node at minimum distance
        for(i=0;i<n;i++)
            if(distance[i]<mindistance&&!visited[i])
            {
                mindistance=distance[i];
                nextnode=i;
            }

            //check if a better path exists through nextnode
            visited[nextnode]=1;
            for(i=0;i<n;i++)
                if(!visited[i])
                    if(mindistance+cost[nextnode][i]<distance[i])
                    {
                        distance[i]=mindistance+cost[nextnode][i];
                        pred[i]=nextnode;
                    }
        count++;
    }

    //print the path and distance of each node
    for(i=0;i<n;i++){
        // if(i!=startnode){
        //     // if(pred[i] == startnode){
        //     //     pred[i] = i;
        //     // }
		// 	// printf("NextHop[%d]: %d", i, pred[i]);
        //
        //     // printf("Distance of node-%d = %d",i,distance[i]);
        //     // printf("\nPath : %d",i);
        //
        //     j=i;
        //     do{
        //         j=pred[j];
        //         pred[i] = j;
        //         // printf("<-%d",j);
        //     }while(j!=startnode);
		// 	printf("\n");
        //
    	// }
        temp = i;
        while(pred[temp] != startnode){
            temp = pred[temp];
        }
        nhop[i] = temp;
	}
}
