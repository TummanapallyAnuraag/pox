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

/*
// Function to create routing table
// using arrays created by storeData() function
// using linked list data structure
void insert(char net[M][N], char mask[M][N],
			char gateway[M][N], char port[M][N],
			char buf[M][N])
{
	char *temp1, *temp2, *temp3, *temp4;
	struct node* new;

	for (int i = 0; i < M; i++) {

		// Initialize head of each
		// linked list with NULL.
		head[i] = NULL;
	}

	for (int i = 0; i < M; i++) {
		for (int j = 0; j < 4; j++) {

			// If head is null
			// then first create new node
			// and store network id into it.
			if (head[i] == NULL) {

				new = (struct node*)malloc(
					sizeof(struct node));
				new->data = net[i];
				new->next = NULL;
				head[i] = new;
			}

			// If head is not null
			// and value of j is 1 then create new node
			// which is pointed by head and it
			// will contain subnet mask
			else if (j == 1) {

				new->next = (struct node*)malloc(
					sizeof(struct node));
				new = new->next;
				new->data = mask[i];
				new->next = NULL;
			}

			// If head is not null and value of j is 2
			// then create new node
			// which is pointed by subnet mask
			// and it will contain gateway
			else if (j == 2) {

				new->next = (struct node*)malloc(
					sizeof(struct node));
				new = new->next;
				new->data = gateway[i];
			}

			// If head is not null and value of j is 3
			// then create new node
			// which is pointed by gateway and
			// it will contain port
			else if (j == 3) {

				new->next = (struct node*)malloc(
					sizeof(struct node));
				new = new->next;
				new->data = port[i];
			}
		}
	}

	// Perform sorting on the basis
	// of longest prefix of subnet mask
	for (int i = 0; i < M; i++) {
		for (int j = i; j < M; j++) {

			// Longest prefix has been compared
			// by using inet_addr() system call
			// which gives decimal value of an ip address.
			if (inet_addr(head[i]->next->data)
				< inet_addr(head[j]->next->data)) {

				struct node* temp = head[i];
				head[i] = head[j];
				head[j] = temp;
			}
		}
	}
}



// This function will search for gateway ip
// and port number in routing table
// through which packet has been sent
// to next node/destination
void search(FILE* fp1, FILE* fp2)
{

	char str[100];
	struct in_addr addr;
	unsigned int val;
	fprintf(fp2, "%c", ' ');

	// Read file 'input.txt' line by line
	// and perform bitwise AND between subnet mask
	// and input(destination) ip coming from file.
	while (fgets(str, sizeof(str), fp1)) {

		for (int i = 0; i < M; i++) {

			// Perform bitwise AND operation on result
			// (i.e. Decimal value of an ip address)
			// coming from inet_addr() system call
			val = inet_addr(str) & inet_addr(head[i]->next->data);
			addr.s_addr = val;
			char* str1 = inet_ntoa(addr);
			char* str2 = head[i]->data;
			int count = 0;

			// Compare the network id string with result
			// coming after performing AND operation
			// and if they are same then increment count.
			for (int i = 0; str1[i] != '\0'; i++) {

				if (str1[i] == str2[i]) {
					count++;
				}
			}

			// If count is same as the string length
			// of network id then find gateway ip
			// and port number of that respective network id
			// and write it into 'output.txt' file.
			if (count == strlen(str1)) {

				struct node* ptr = head[i]->next;
				struct node* temp = ptr->next;
				while (temp != NULL) {

					fprintf(fp2, "%s ", temp->data);
					temp = temp->next;
				}
				break;
			}
		}
	}
}


// This function fetches data from files
// and store them into different arrays
void storeData(FILE* fp, char buf[M][N])
{

	char line[200];
	int c, i = 0, j = 0;

	// Read data from the file line by line
	// and each line is stored in array separately.
        fp = fopen(filename, "r");
        if (fp == NULL){
        printf("Could not open file %s",filename);
        return 1;
        }
	while (fgets(line, sizeof(line), fp)) {
		j = 0;
		for (int l = 0; l < strlen(line); l++) {
			buf[i][j] = line[l];
			j++;
		}
		i++;
	}


}
*/
