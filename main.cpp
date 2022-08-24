#include <iostream>
#include <ctime>

using namespace std;

int main() {
    //Declaraciones e inicializaciones
    double time;
    const int MAX = 1000;
    int A[MAX][MAX];
    int x[MAX];
    int y[MAX];

    for (int i = 0; i < MAX; i++) {
        for (int j = 0; j < MAX; j++) {
            A[i][j] = i + j;
        }
        x[i] = i;
        y[i] = 0;
    }

    const int tests = 500;
    double times1[tests];
    double times2[tests];
    double total1 = 0, total2 = 0;


    for (int e = 0; e < tests; e++) {
        //Assign y = 0
        for (int &i: y) {
            i = 0;
        }
        //First pair loops
        auto t0 = clock();
        for (int i = 0; i < MAX; i++) {
            for (int j = 0; j < MAX; j++) {
                y[i] = A[i][j] * x[i];
            }
        }
        auto t1 = clock();
        time = (double(t1 - t0) / CLOCKS_PER_SEC);
        times1[e] = time;

        //Assign y = 0
        for (int &i: y) {
            i = 0;
        }

        //Second pair loops
        t0 = clock();
        for (int j = 0; j < MAX; j++) {
            for (int i = 0; i < MAX; i++) {
                y[i] = A[i][j] * x[i];
            }
        }
        t1 = clock();
        time = (double(t1 - t0) / CLOCKS_PER_SEC);
        times2[e] = time;
    }


    for (int e = 0; e < tests; e++) {
        total1 += times1[e];
        total2 += times2[e];
    }
    cout << total1 / tests << " " << total2 / tests << endl;

    double dif = (total2 - total1);
    double prom = (total2 + total1)/2;
    cout << (dif/prom)*100 << endl;


}
