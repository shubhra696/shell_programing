#include <stdio.h>

int findLRU(int time[], int n) {
    int i, min = time[0], pos = 0;
    for (i = 1; i < n; ++i) {
        if (time[i] < min) {
            min = time[i];
            pos = i;
        }
    }
    return pos;
}

int main() {
    int frames, pages;

    printf("Enter number of frames: ");
    scanf("%d", &frames);

    printf("Enter number of pages: ");
    scanf("%d", &pages);

    int page[pages];
    printf("Enter page reference string: ");
    for (int i = 0; i < pages; i++) {
        scanf("%d", &page[i]);
    }

    int f[frames], time[frames], counter = 0, faults = 0;

    for (int i = 0; i < frames; i++) {
        f[i] = -1;
    }

    for (int i = 0; i < pages; i++) {
        int flag = 0;

        for (int j = 0; j < frames; j++) {
            if (f[j] == page[i]) {
                flag = 1;
                time[j] = ++counter;
                break;
            }
        }

        if (!flag) {
            int pos = findLRU(time, frames);
            f[pos] = page[i];
            time[pos] = ++counter;
            faults++;
        }
    }

    printf("Total Page Faults = %d\n", faults);

    return 0;
}
