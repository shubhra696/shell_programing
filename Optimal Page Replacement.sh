#include <stdio.h>

int predict(int pages[], int n, int index, int frames[], int f) {
    int farthest = index, pos = -1;

    for (int i = 0; i < f; i++) {
        int j;
        for (j = index; j < n; j++) {
            if (frames[i] == pages[j]) {
                if (j > farthest) {
                    farthest = j;
                    pos = i;
                }
                break;
            }
        }
        // If the page is never referenced in future
        if (j == n) {
            return i;
        }
    }

    return (pos == -1) ? 0 : pos;
}

int main() {
    int frames, pages;

    printf("Enter number of frames: ");
    scanf("%d", &frames);

    printf("Enter number of pages: ");
    scanf("%d", &pages);

    int page[pages], f[frames];
    int faults = 0;

    printf("Enter page reference string: ");
    for (int i = 0; i < pages; i++) {
        scanf("%d", &page[i]);
    }

    // Initialize all frames as empty
    for (int i = 0; i < frames; i++) {
        f[i] = -1;
    }

    for (int i = 0; i < pages; i++) {
        int found = 0;

        // Check if page is already in a frame
        for (int j = 0; j < frames; j++) {
            if (f[j] == page[i]) {
                found = 1;
                break;
            }
        }

        if (!found) {
            int pos;

            if (i < frames) {
                pos = i; // Fill frames sequentially at first
            } else {
                pos = predict(page, pages, i + 1, f, frames);
            }

            f[pos] = page[i];
            faults++;
        }

        // Print current frame state
        printf("Frames after page %d: ", page[i]);
        for (int j = 0; j < frames; j++) {
            if (f[j] == -1)
                printf("- ");
            else
                printf("%d ", f[j]);
        }
        printf("\n");
    }

    printf("\nTotal page faults = %d\n", faults);

    return 0;
}
