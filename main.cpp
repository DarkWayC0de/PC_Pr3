#include <iostream>
#include <cmath>

int main() {
  double error;
  std::cout << "Practica 3. PRINCIPIOS DE COMPUTADORES\n"
               "Introduzca el error maximo permitido:";
  std::cin>>error;
  double resultado(0),numerador(1),parcial;
  int contador(0);
  do{
    parcial =numerador/((2*contador) + 1);
    resultado+=parcial;
    numerador= -numerador;
    contador++;
  }while(std::abs(parcial)>error);
  std::cout <<"Serie de Leibnis: "<<resultado<<"\n"
              "Terminos calculados: "<<contador<<"\n";








  return 0;
}