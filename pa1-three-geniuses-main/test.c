#include<stdio.h>
#include<stdlib.h>         // for malloc, free, atoi
void initialize_matrix(double *mat,int rows,int cols) {
    int x = 1;
    for(int i = 0; i < rows; i++) {
        for(int j = 0; j < 2 * cols; j++) {
            mat[i*rows+j] = x++;
        }
    }
}
void initialize_result_matrix(double *mat,int rows,int cols) {
    for(int i = 0; i < rows; i++) {
        for(int j = 0; j < cols; j++) {
            mat[i*rows+j] = 0.0;
        }
    }
}
int main(int argc, char **argv) {
    if ( argc <= 3 ) {
        printf("Usage: %s <matrix_dimension>\n", argv[0]);
        return 0;
    }
    int l=atoi(argv[1]);
    int m=atoi(argv[2]);
    int r=atoi(argv[3]);
    double *A = (double *)malloc(l*m * sizeof(double));
    double *B = (double *)malloc(m*r * sizeof(double));
    double *C = (double *)calloc(l*r, sizeof(double));
    initialize_matrix(A, l,m);
    initialize_matrix(B, m, r);
    initialize_result_matrix(C, l,r);
    for(int i=0;i<l;i++){
        for(int j=0;j<r;j++){
            for(int k=0;k<m;k++){
                C[i*r+j] += A[i*m+k] * B[k*r+j];
            }
        }
    }
    for(int i=0;i<l;i++){
        for(int j=0;j<r;j++){
            printf("%lf ", C[i*r+j]);
            C[i*r+j] = 0.0;
        }
        printf("\n");
    }
    printf("My method Optimized\n");
    // for (int i = 0; i < l; i++) {
	// 	for (int j = 0; j < m; j++) {
	// 		double temp=A[i*m+j];
	// 		for (int k = 0; k < r; k++) {
	// 			C[i*r + k] += temp * B[j*r + k];
	// 		}
	// 	}
	// }
    int size=l;
    for(int x=0;x<size;x+=8){
        for(int y=0;y<size;y+=8){
            for(int z=0;z<size;z+=8){
                for(int i=x;i<x+8 && i<size;i++){
                    for(int j=y;j<y+8 && j<size;j++){
                        for(int k=z;k<z+8 && k<size;k++){
                            C[i*size + j] += A[i*size+k]  * B[k*size + j];
                        }
                    }
                }
            }
        }
    }
    for(int i=0;i<l;i++){
        for(int j=0;j<r;j++){
            printf("%lf ", C[i*r+j]);
        }
        printf("\n");
    }
    return 0;
}