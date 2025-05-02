#include <stdio.h>

struct Process {
    int pid, bt, ct, tat, wt;
};

int main() {
    int n;
    printf("Enter number of processes: ");
    scanf("%d", &n);

    struct Process p[n];

    for (int i = 0; i < n; i++) {
        p[i].pid = i + 1;
        printf("Enter Burst Time for P%d: ", i + 1);
        scanf("%d", &p[i].bt);
    }

    int time = 0;
    for (int i = 0; i < n; i++) {
        time += p[i].bt;
        p[i].ct = time;
        p[i].tat = p[i].ct;         // Since AT = 0
        p[i].wt = p[i].tat - p[i].bt;
    }

    printf("\nPID\tBT\tCT\tTAT\tWT\n");
    float totalTAT = 0, totalWT = 0;
    for (int i = 0; i < n; i++) {
        printf("P%d\t%d\t%d\t%d\t%d\n",
               p[i].pid, p[i].bt, p[i].ct, p[i].tat, p[i].wt);
        totalTAT += p[i].tat;
        totalWT += p[i].wt;
    }

    printf("\nAverage Turnaround Time = %.2f\n", totalTAT / n);
    printf("Average Waiting Time = %.2f\n", totalWT / n);

    return 0;
}
