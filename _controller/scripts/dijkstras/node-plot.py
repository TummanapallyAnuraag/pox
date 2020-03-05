import networkx as nx
import os
import matplotlib.pyplot as plt

NEIGH_DATA_FLDR = "../lsdb-client/data/"

# some good colors:
#3081B9 blue
#FF7F0E orange
#2CA02C green
#D62728 red

all_files = os.listdir(NEIGH_DATA_FLDR)
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
    fp = open(NEIGH_DATA_FLDR+file, "r")
    for line in fp:
        line = line.strip()
        edge = (src, line)
        G.add_edge(*edge)



pos = nx.spring_layout(G)
nx.draw_networkx_nodes(G, pos, node_size=800, alpha=0.5, node_color='#FF7F0E' ,edgecolors='#D62728', linewidths=2.0)
nx.draw_networkx_edges(G, pos, width=1.5, alpha=0.8, edge_color='#3081B9', style='dashdot')

# for k in pos:
#     pos[k][1] = pos[k][1] - 0.05;

nx.draw_networkx_labels(G, pos, labels, font_size=12, font_weight='bold', font_family='monospace')
#nx.draw(G, pos, with_labels=True, node_size=500, font_size=10)

x_values, y_values = zip(*pos.values())
x_max = max(x_values)
x_min = min(x_values)
x_margin = (x_max - x_min) * 0.25

plt.xlim(x_min - x_margin, x_max + x_margin)
y_max = max(y_values)
y_min = min(y_values)
y_margin = (y_max - y_min) * 0.25
plt.ylim(y_min - y_margin, y_max + y_margin)

plt.axis('off')
plt.savefig('topo.png')
# plt.show()
plt.close()
