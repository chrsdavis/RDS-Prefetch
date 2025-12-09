#include <stdio.h>
#include <stdlib.h>

#define MAX_NEIGHBORS 4

typedef struct GraphNode {
    int value;
    int numNeighbors;
    struct GraphNode *neighbors[MAX_NEIGHBORS];
} GraphNode;

GraphNode* createNode(int value) {
    GraphNode *node = (GraphNode*)malloc(sizeof(GraphNode));
    node->value = value;
    node->numNeighbors = 0;
    for (int i = 0; i < MAX_NEIGHBORS; i++) {
        node->neighbors[i] = NULL;
    }
    return node;
}

void addEdge(GraphNode *from, GraphNode *to) {
    if (from->numNeighbors < MAX_NEIGHBORS) {
        from->neighbors[from->numNeighbors++] = to;
    }
}

GraphNode* createGraph(int numNodes) {
    GraphNode **nodes = (GraphNode**)malloc(numNodes * sizeof(GraphNode*));
    
    for (int i = 0; i < numNodes; i++) {
        nodes[i] = createNode(i);
    }
    
    for (int i = 0; i < numNodes - 1; i++) {
        addEdge(nodes[i], nodes[i + 1]);
        if (i > 0) addEdge(nodes[i], nodes[i - 1]);
        if (i + 2 < numNodes) addEdge(nodes[i], nodes[i + 2]);
        if (i + 3 < numNodes) addEdge(nodes[i], nodes[i + 3]);
    }
    
    GraphNode *root = nodes[0];
    free(nodes);
    return root;
}

long long traverseGraph(GraphNode *start, int depth, int *visited, int maxNode) {
    if (!start || depth <= 0) return 0;
    
    long long sum = start->value;
    
    for (int i = 0; i < start->numNeighbors; i++) {
        GraphNode *neighbor = start->neighbors[i];
        if (neighbor && neighbor->value < maxNode) {
            sum += traverseGraph(neighbor, depth - 1, visited, maxNode);
        }
    }
    
    return sum;
}

int main(int argc, char *argv[]) {
    int numNodes = 1000;
    int iterations = 100;
    
    if (argc > 1) numNodes = atoi(argv[1]);
    
    printf("Creating graph with %d nodes\n", numNodes);
    GraphNode *graph = createGraph(numNodes);
    
    printf("Traversing graph %d times\n", iterations);
    long long totalSum = 0;
    int *visited = (int*)calloc(numNodes, sizeof(int));
    
    for (int iter = 0; iter < iterations; iter++) {
        totalSum += traverseGraph(graph, 3, visited, numNodes);
    }
    
    printf("Total sum : %lld\n", totalSum);
    
    free(visited);
    return 0;
}
