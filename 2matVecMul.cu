#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>
#include <iostream>
#include <random>

using namespace std;

const int N = 4;

__global__ void matVectMulKernel(float* d_A, float* d_B, float* d_C, int n) {
	int col = blockIdx.x * blockDim.x + threadIdx.x;
	int fil = blockIdx.y * blockDim.y + threadIdx.y;

	float sum = 0;

	for (int j = 0; j < n; j++) {
		sum += d_A[fil * N + j] * d_B[j];
	}
	d_C[fil] = sum;

}


void matVectMul(float A[][N], float B[], float C[], int n)
{
	int sizeM = n * n * sizeof(float);
	int sizeV = n * sizeof(float);
	float* d_A = 0;
	float* d_B = 0;
	float* d_C = 0;

	cudaMalloc((void**)&d_A, sizeM);
	cudaMalloc((void**)&d_B, sizeV);
	cudaMalloc((void**)&d_C, sizeV);

	cudaMemcpy(d_A, A, sizeM, cudaMemcpyHostToDevice);
	cudaMemcpy(d_B, B, sizeV, cudaMemcpyHostToDevice);

	dim3 dimGrid(1, 1, 1);
	dim3 dimBlock(n, n, 1);


	matVectMulKernel << < dimGrid, dimBlock >> > (d_A, d_B, d_C, n);

	cudaMemcpy(C, d_C, sizeV, cudaMemcpyDeviceToHost);

	cudaFree(d_A);
	cudaFree(d_B);
	cudaFree(d_C);
}


int main() {
	random_device rd;
	mt19937 gen(rd());
	uniform_int_distribution<> dist(1, 10);
	float A[N][N];
	float B[N];
	float C[N];

	for (int i = 0; i < N; i++) {
		B[i] = dist(gen);
		for (int j = 0; j < N; j++) {
			A[i][j] = dist(gen);
		}
	}

	for (int i = 0; i < N; i++) {
		for (int j = 0; j < N; j++) {
			cout << A[i][j] << " ";
		}
		cout << endl;
	}
	cout << endl;

	for (int i = 0; i < N; i++) {
		cout << B[i] << " ";
	}
	cout << endl;
	cout << endl;


	matVectMul(A, B, C, N);


	for (int i = 0; i < N; i++) {
		cout << C[i] << " ";
	}
	cout << endl;

}