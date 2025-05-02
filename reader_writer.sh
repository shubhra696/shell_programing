#include <stdio.h>
#include <pthread.h>
#include <semaphore.h>
#include <unistd.h>

sem_t wrt;
pthread_mutex_t mutex;
int readcount = 0;

void *reader(void *arg) {
    pthread_mutex_lock(&mutex);
    readcount++;
    if (readcount == 1)
        sem_wait(&wrt);
    pthread_mutex_unlock(&mutex);

    printf("Reader %d is reading\n", *(int *)arg);
    sleep(1);

    pthread_mutex_lock(&mutex);
    readcount--;
    if (readcount == 0)
        sem_post(&wrt);
    pthread_mutex_unlock(&mutex);

    return NULL;
}

void *writer(void *arg) {
    sem_wait(&wrt);
    printf("Writer %d is writing\n", *(int *)arg);
    sleep(1);
    sem_post(&wrt);
    return NULL;
}

int main() {
    pthread_t r[5], w[5];
    int r_ids[5], w_ids[5];

    sem_init(&wrt, 0, 1);
    pthread_mutex_init(&mutex, NULL);

    // Creating readers
    for (int i = 0; i < 5; i++) {
        r_ids[i] = i + 1;
        pthread_create(&r[i], NULL, reader, &r_ids[i]);
    }

    // Creating writers
    for (int i = 0; i < 5; i++) {
        w_ids[i] = i + 1;
        pthread_create(&w[i], NULL, writer, &w_ids[i]);
    }

    // Joining all threads
    for (int i = 0; i < 5; i++) {
        pthread_join(r[i], NULL);
        pthread_join(w[i], NULL);
    }

    sem_destroy(&wrt);
    pthread_mutex_destroy(&mutex);

    return 0;
}
