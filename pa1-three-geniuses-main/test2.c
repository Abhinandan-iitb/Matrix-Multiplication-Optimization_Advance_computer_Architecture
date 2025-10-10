#include<stdio.h>
#include<stdlib.h>         // for malloc, free, atoi
int main(int argc, char **argv){
    if ( argc <= 1 ) {
		printf("Usage: %s <matrix_dimension>\n", argv[0]);
		return 0;
	}
    int size=atoi(argv[1]);
    double * A = (double *)malloc(size * size * sizeof(double));
    double * B = (double *)malloc(size * size * sizeof(double));
    double * C = (double *)calloc(size * size, sizeof(double));
    int x=1;
    for(int i=0;i<size;i++){
        for(int j=0;j<size;j++){
            A[i*size+j] = x;
            B[i*size+j] = x;
            x++;
            C[i*size+j] = 0.0;
        }
    }
    for(int i=0;i<size;i++){
        for(int j=0;j<size;j++){
            for(int k=0;k<size;k++){
                C[i*size+j] += A[i*size+k] * B[k*size+j];
            }
        }
    }

    // for (int i = 0; i < size; i++) {
	// 	for (int j = 0; j < size; j++) {
	// 		double temp=A[i*size+j];
	// 		for (int k = 0; k < size; k++) {
	// 			C[i*size + k] += temp * B[j*size + k];
	// 		}
	// 	}
	// }
    return 0;
}