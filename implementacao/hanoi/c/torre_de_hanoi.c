#include <stdio.h>

int num_movimento;

void hanoi (int qtd_discos, int col_A, int col_B, int col_C) {
  if (qtd_discos > 0) {
    hanoi (qtd_discos - 1, col_A, col_C, col_B);
    printf ("%d) %c --> %c\n", ++num_movimento, 64 + col_A, 64 + col_C);
    hanoi (qtd_discos - 1, col_B, col_A, col_C);
  }
}

int main (int *argc, char **argv) {
  int n_discos;
  char exec_novamente;
    
  do {

      num_movimento = 0;
    
      printf ("Informe o número de discos: ");
      scanf ("%d", &n_discos);
      
      hanoi (n_discos, 1, 2, 3);

      printf("Executar novamente? (s/n) ");
      scanf (" %c", &exec_novamente);
  } while (exec_novamente != 'n');
  return 0;
}
