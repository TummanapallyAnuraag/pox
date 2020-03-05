import networkx as nx
import os
import matplotlib.pyplot as plt

all_files = os.listdir("data/")
G = nx.Graph()
labels = {}
node_count = 0;

for file in all_files:
    nname = file[:-4]
    labels[nname] = nname
    node_count = node_count + 1
    G.add_node(nname)

for file in all_files:
    src = file[:-4]
    fp = open("data/"+file, "r")
    for line in fp:
        line = line.strip()
        edge = (src, line)
        G.add_edge(*edge)



pos = nx.spring_layout(G)
nx.draw_networkx_nodes(G, pos, node_size=500, alpha=0.8)
nx.draw_networkx_edges(G, pos, width=1.0, alpha=0.5)
nx.draw_networkx_labels(G, pos, labels, font_size=10)

#for p in pos:
#    pos[p][1] = pos[p][1] - 0.1

#nx.draw_networkx_labels(G, pos, labels, font_size=10)

#nx.draw(G, pos, with_labels=True, node_size=500, font_size=10)
plt.axis('off')
plt.savefig('topo.png')
#plt.show()
plt.close()
