#include <stdio.h>
#include <stdlib.h>
#include <time.h>

typedef struct Node {
    int data;
    struct Node *next;
    struct Node *prev;
} Node;

Node* createDoublyLinkedList(int n) {
    Node *head = NULL;
    Node *current = NULL;
    
    for (int i = 0; i < n; i++) {
        Node *newNode = (Node*)malloc(sizeof(Node));
        newNode->data = i;
        newNode->next = NULL;
        newNode->prev = current;
        
        if (head == NULL) {
            head = newNode;
        } else {
            current->next = newNode;
        }
        current = newNode;
    }
    
    return head;
}

long long forwardTraversal(Node *head) {
    long long sum = 0;
    Node *current = head;
    
    while (current != NULL) {
        sum += current->data;
        for (int i = 0; i < 10; i++) {
            sum += current->data * (i + 1);
        }
        current = current->next;
    }
    
    return sum;
}

long long multiTraversal(Node *head, int iterations) {
    long long total = 0;
    for (int i = 0; i < iterations; i++) {
        total += forwardTraversal(head);
    }
    return total;
}

void freeList(Node *head) {
    Node *current = head;
    while (current != NULL) {
        Node *next = current->next;
        free(current);
        current = next;
    }
}

int main(int argc, char *argv[]) {
    int n = 10000;
    int iterations = 100;
    
    if (argc > 1) n = atoi(argv[1]);
    if (argc > 2) iterations = atoi(argv[2]);
    
    srand(time(NULL));
    
    printf("Creating doubly linked list with %d nodes\n", n);
    Node *head = createDoublyLinkedList(n);
    
    printf("Performing %d forward traversals\n", iterations);
    long long result = multiTraversal(head, iterations);
    
    printf("Result : %lld\n", result);
    
    freeList(head);
    return 0;
}