#include <stdio.h>
#include <stdlib.h>

typedef struct TreeNode {
    int value;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

TreeNode* createNode(int nodeValue) {
    TreeNode *newNode = (TreeNode*)malloc(sizeof(TreeNode));
    newNode->value = nodeValue;
    newNode->left = NULL;
    newNode->right = NULL;
    return newNode;
}

TreeNode* insertNode(TreeNode *treeRoot, int nodeValue) {
    if (treeRoot == NULL) {
        return createNode(nodeValue);
    }
    
    if (nodeValue < treeRoot->value) {
        treeRoot->left = insertNode(treeRoot->left, nodeValue);
    } else {
        treeRoot->right = insertNode(treeRoot->right, nodeValue);
    }
    
    return treeRoot;
}

int preorderSum(TreeNode *treeRoot) {
    if (treeRoot == NULL) {
        return 0;
    }
    
    int sum = treeRoot->value;
    sum += preorderSum(treeRoot->left);
    sum += preorderSum(treeRoot->right);
    
    return sum;
}

void freeTree(TreeNode *treeRoot) {
    if (treeRoot == NULL) {
        return;
    }
    
    freeTree(treeRoot->left);
    freeTree(treeRoot->right);
    free(treeRoot);
}

int main(int argc, char *argv[]) {
    TreeNode *treeRoot = NULL;
    int numNodes = 1000;
    
    if (argc > 1) {
        numNodes = atoi(argv[1]);
    }
    
    printf("Creating binary search tree with %d nodes\n", numNodes);
    
    for (int i = 0; i < numNodes; i++) {
        treeRoot = insertNode(treeRoot, (i * 17 + 13) % 1000);
    }
    
    printf("Computing sum with preorder traversal\n");
    int sum = preorderSum(treeRoot);
    
    printf("Sum : %d\n", sum);
    
    freeTree(treeRoot);
    
    return 0;
}