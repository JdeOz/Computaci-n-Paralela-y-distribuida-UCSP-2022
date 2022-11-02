#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>
#include <iostream>
#include <random>

using namespace std;

const int N = 4;

__global__ void matAddKernel(float* d_A, float* d_B, float* d_C, int n) {
	int col = blockIdx.x * blockDim.x + threadIdx.x;
	int fil = blockIdx.y * blockDim.y + threadIdx.y;

	int indice = fil * N + col;


	if (col < N && fil < N) {
		d_C[indice] = d_A[indice] + d_B[indice];
	}
}

__global__ void matAddKernel1(float* d_A, float* d_B, float* d_C, int n) {
	int col = blockIdx.x * blockDim.x + threadIdx.x;
	int fil = blockIdx.y * blockDim.y + threadIdx.y;

	for (int i = 0; i < n; i++) {
		d_C[fil * N+i]= d_A[fil * N + i] + d_B[fil * N + i];
	}
}

__global__ void matAddKernel2(float* d_A, float* d_B, float* d_C, int n) {
	int col = blockIdx.x * blockDim.x + threadIdx.x;
	int fil = blockIdx.y * blockDim.y + threadIdx.y;

	for (int i = 0; i < n; i++) {
		d_C[i * N + col] = d_A[i * N + col] + d_B[i * N + col];
	}
}

void matAdd(float A[][N], float B[][N], float C[][N], int n)
{
	int size = n * n * sizeof(float);
	float* d_A = 0;
	float* d_B = 0;
	float* d_C = 0;

	cudaMalloc((void**)&d_A, size);
	cudaMalloc((void**)&d_B, size);
	cudaMalloc((void**)&d_C, size);

	cudaMemcpy(d_A, A, size, cudaMemcpyHostToDevice);
	cudaMemcpy(d_B, B, size, cudaMemcpyHostToDevice);

	dim3 dimGrid(1, 1, 1);
	dim3 dimBlock(n, n, 1);


	matAddKernel <<< dimGrid, dimBlock >> > (d_A, d_B, d_C, n);

	cudaMemcpy(C, d_C, size, cudaMemcpyDeviceToHost);

	cudaFree(d_A);
	cudaFree(d_B);
	cudaFree(d_C);
}


int main() {
	random_device rd;
	mt19937 gen(rd());
	uniform_real_distribution<> dist(1, 100);
	float A[N][N];
	float B[N][N];
	float C[N][N];

	for (int i = 0; i < N; i++) {
		for (int j = 0; j < N; j++) {
			A[i][j] = dist(gen);
			B[i][j] = dist(gen);
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
		for (int j = 0; j < N; j++) {
			cout << B[i][j] << " ";
		}
		cout << endl;
	}
	cout << endl;


	matAdd(A, B, C, N);


	for (int i = 0; i < N; i++) {
		for (int j = 0; j < N; j++) {
			cout << C[i][j] << " ";
		}
		cout << endl;
	}

}