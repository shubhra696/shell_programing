#include <stdio.h>
#include <stdbool.h>

int main() {
    int n, m;

    printf("Enter number of processes and resources: ");
    scanf("%d %d", &n, &m);

    int alloc[n][m], max[n][m], need[n][m], avail[m];

    printf("Enter Allocation Matrix:\n");
    for (int i = 0; i < n; i++)
        for (int j = 0; j < m; j++)
            scanf("%d", &alloc[i][j]);

    printf("Enter Max Matrix:\n");
    for (int i = 0; i < n; i++)
        for (int j = 0; j < m; j++) {
            scanf("%d", &max[i][j]);
            need[i][j] = max[i][j] - alloc[i][j];
        }

    printf("Enter Available Resources:\n");
    for (int i = 0; i < m; i++)
        scanf("%d", &avail[i]);

    bool finish[n];
    for (int i = 0; i < n; i++)
        finish[i] = false;

    int safeSeq[n], idx = 0;
    bool flag;

    for (int k = 0; k < n; k++) {
        for (int i = 0; i < n; i++) {
            if (!finish[i]) {
                flag = true;
                for (int j = 0; j < m; j++) {
                    if (need[i][j] > avail[j]) {
                        flag = false;
                        break;
                    }
                }

                if (flag) {
                    for (int j = 0; j < m; j++)
                        avail[j] += alloc[i][j];
                    safeSeq[idx++] = i;
                    finish[i] = true;
                }
            }
        }
    }

    bool safe = true;
    for (int i = 0; i < n; i++) {
        if (!finish[i]) {
            safe = false;
            break;
        }
    }

    if (safe) {
        printf("System is in a safe state.\nSafe sequence is: ");
        for (int i = 0; i < n; i++)
            printf("P%d ", safeSeq[i]);
        printf("\n");
    } else {
        printf("System is NOT in a safe state.\n");
    }

    return 0;
}
