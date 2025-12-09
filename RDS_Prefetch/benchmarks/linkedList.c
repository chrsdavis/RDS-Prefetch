#include <stdio.h>
#include <stdlib.h>

typedef struct Node {
    int data;
    struct Node *next;
} Node;

Node* createList(int numNodes) {
    Node *listHead = NULL;
    Node *listTail = NULL;
    
    for (int i = 0; i < numNodes; i++) {
        Node *newNode = (Node*)malloc(sizeof(Node));
        newNode->data = i;
        newNode->next = NULL;
        
        if (listHead == NULL) {
            listHead = newNode;
            listTail = newNode;
        } else {
            listTail->next = newNode;
            listTail = newNode;
        }
    }
    
    return listHead;
}

int traverseList(Node *listHead) {
    int sum = 0;
    Node *currentNode = listHead;
    
    while (currentNode != NULL) {
        sum += currentNode->data;
        currentNode = currentNode->next;
    }
    
    return sum;
}

void freeList(Node *listHead) {
    Node *currentNode = listHead;
    while (currentNode != NULL) {
        Node *nextNode = currentNode->next;
        free(currentNode);
        currentNode = nextNode;
    }
}

int main(int argc, char *argv[]) {
    int numNodes = 1000;
    
    if (argc > 1) {
        numNodes = atoi(argv[1]);
    }
    
    printf("Creating linked list with %d nodes\n", numNodes);
    Node *listHead = createList(numNodes);
    
    printf("Traversing list\n");
    int sum = traverseList(listHead);
    
    printf("Sum : %d\n", sum);
    
    freeList(listHead);
    
    return 0;
}
