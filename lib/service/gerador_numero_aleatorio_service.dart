import 'dart:math';

class GeradorNumeroAleatorioSerrvice{
    static int geraValorAleatorio(int maximo) {
    Random numeroAleatorio = Random();
    return numeroAleatorio.nextInt(1000);
  }
}