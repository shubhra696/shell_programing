#include <stdio.h>
#include <pthread.h>
#include <semaphore.h>
#include <unistd.h>

#define N 5  // Number of philosophers

sem_t forks[N];
pthread_t philosophers[N];

void *philosopher(void *arg) {
    int id = *(int *)arg;
    int left = id;
    int right = (id + 1) % N;

    printf("Philosopher %d is thinking\n", id);
    sleep(1);

    sem_wait(&forks[left]);
    sem_wait(&forks[right]);

    printf("Philosopher %d is eating\n", id);
    sleep(2);

    sem_post(&forks[left]);
    sem_post(&forks[right]);

    printf("Philosopher %d finished eating\n", id);

    return NULL;
}

int main() {
    int i, ids[N];

    // Initialize semaphores
    for (i = 0; i < N; i++) {
        sem_init(&forks[i], 0, 1);
        ids[i] = i;
    }

    // Create threads
    for (i = 0; i < N; i++) {
        pthread_create(&philosophers[i], NULL, philosopher, &ids[i]);
    }

    // Wait for all threads to finish
    for (i = 0; i < N; i++) {
        pthread_join(philosophers[i], NULL);
    }

    // Destroy semaphores
    for (i = 0; i < N; i++) {
        sem_destroy(&forks[i]);
    }

    return 0;
}
