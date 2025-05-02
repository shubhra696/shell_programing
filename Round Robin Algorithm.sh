#include <iostream>
#include <vector>
#include <queue>
#include <iomanip>

using namespace std;

struct Process {
    int pid;
    int burst;
    int arrival;
    int remaining;
    int waiting = 0;
    int turnaround = 0;
    int lastTime;
};

void roundRobinScheduling(vector<Process> processes, int timeQuantum) {
    queue<Process*> readyQueue;
    vector<Process> completedProcesses;
    int currentTime = 0;
    int totalProcesses = processes.size();
    int completed = 0;

    for (auto& p : processes) {
        p.remaining = p.burst;
        p.lastTime = p.arrival;
    }

    while (completed < totalProcesses) {
        for (auto& p : processes) {
            if (p.arrival == currentTime) {
                readyQueue.push(&p);
            }
        }

        if (!readyQueue.empty()) {
            Process* current = readyQueue.front();
            readyQueue.pop();

            if (current->remaining == current->burst) {
                current->waiting += currentTime - current->arrival;
            } else {
                current->waiting += currentTime - current->lastTime;
            }

            int timeSlice = min(timeQuantum, current->remaining);
            currentTime += timeSlice;
            current->remaining -= timeSlice;

            for (auto& p : processes) {
                if (p.arrival > current->lastTime && p.arrival <= currentTime) {
                    readyQueue.push(&p);
                }
            }

            if (current->remaining == 0) {
                current->turnaround = currentTime - current->arrival;
                completed++;
            } else {
                current->lastTime = currentTime;
                readyQueue.push(current);
            }
        } else {
            currentTime++;
        }
    }

    cout << left << setw(10) << "PID" << setw(10) << "Arrival" << setw(10) << "Burst"
         << setw(10) << "Waiting" << setw(12) << "Turnaround" << endl;

    float totalWaiting = 0, totalTurnaround = 0;
    for (auto& p : processes) {
        cout << left << setw(10) << p.pid << setw(10) << p.arrival << setw(10) << p.burst
             << setw(10) << p.waiting << setw(12) << p.turnaround << endl;
        totalWaiting += p.waiting;
        totalTurnaround += p.turnaround;
    }

    cout << fixed << setprecision(2);
    cout << "Average Waiting Time: " << totalWaiting / totalProcesses << endl;
    cout << "Average Turnaround Time: " << totalTurnaround / totalProcesses << endl;
}

int main() {
    vector<Process> processes = {
        {1, 10, 0}, {2, 5, 1}, {3, 8, 2}
    };

    int timeQuantum = 3;

    roundRobinScheduling(processes, timeQuantum);

    return 0;
}
