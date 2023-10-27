import 'package:flutter/material.dart';
import 'package:telalogin/repositories/linguagem_repository.dart';
import 'package:telalogin/repositories/nivel_repository.dart';
import 'package:telalogin/shared/text_label.dart';

class DadosCadastrais extends StatefulWidget {
  const DadosCadastrais({super.key});

  @override
  State<DadosCadastrais> createState() => _DadosCadastraisState();
}

class _DadosCadastraisState extends State<DadosCadastrais> {
  var nomeController = TextEditingController(text: "");
  var dataNascimento = TextEditingController(text: "");
  DateTime? dataNascimentoVariavel;
  var nivelRepository = NivelRepository();
  var linguagensRepository = LinguagensRepository();
  double salarioEscolhido = 0;
  int tempoExperiencia = 0;
  bool salvando = false;

  var niveis = [];
  var linguagens = [];
  var linguagensSelecionadas = [];
  var nivelSelecionado = "";

  List<DropdownMenuItem<int>> returnItemns(int quantidadeMaxima) {
    var itens = <DropdownMenuItem<int>>[];
    for (var i = 0; i < quantidadeMaxima; i++) {
      itens.add(
        DropdownMenuItem(
          child: Text(i.toString()),
          value: i,
        ),
      );
    }
    return itens;
  }

  @override
  void initState() {
    niveis = nivelRepository.retornaNiveis();
    linguagens = linguagensRepository.retornaLinguagens();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus Dados"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: salvando
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  const TextLabel(texto: "Nome"),
                  TextField(
                    controller: nomeController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const TextLabel(texto: "Data de nascimento"),
                  TextField(
                    controller: dataNascimento,
                    readOnly: true,
                    onTap: () async {
                      var data = await showDatePicker(
                          context: context,
                          initialDate: DateTime(2000, 1, 1),
                          firstDate: DateTime(1900, 5, 20),
                          lastDate: DateTime(2023, 12, 23));
                      if (data != null) {
                        dataNascimento.text = data.toString();
                        dataNascimentoVariavel = data;
                      }
                    },
                  ),
                  const TextLabel(texto: "Nivel de experiência"),
                  Column(
                    children: niveis
                        .map(
                          (nivel) => RadioListTile(
                            dense: true,
                            title: Text(nivel.toString()),
                            selected: nivelSelecionado == nivel,
                            value: nivel.toString(),
                            groupValue: nivelSelecionado,
                            onChanged: (value) {
                              setState(() {
                                nivelSelecionado = value.toString();
                              });
                            },
                          ),
                        )
                        .toList(),
                  ),
                  const TextLabel(texto: "Linguagens preferidas"),
                  Column(
                    children: linguagens
                        .map(
                          (e) => CheckboxListTile(
                            dense: true,
                            title: Text(e),
                            value: linguagensSelecionadas.contains(e),
                            onChanged: (bool? value) {
                              if (value!) {
                                setState(() {
                                  linguagensSelecionadas.add(e);
                                });
                              } else {
                                setState(() {
                                  linguagensSelecionadas.remove(e);
                                });
                              }
                            },
                          ),
                        )
                        .toList(),
                  ),
                  const TextLabel(texto: "Tempo de expêriencia"),
                  DropdownButton(
                      value: tempoExperiencia,
                      isExpanded: true,
                      items: returnItemns(50),
                      onChanged: (value) {
                        setState(() {
                          tempoExperiencia = int.parse(
                            value.toString(),
                          );
                        });
                      }),
                  TextLabel(
                      texto:
                          "Pretenção salarial. R\$ ${salarioEscolhido.round().toString()}"),
                  Slider(
                      min: 0,
                      max: 100000,
                      value: salarioEscolhido,
                      onChanged: (double value) {
                        setState(() {
                          salarioEscolhido = value;
                        });
                      }),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        salvando = true;
                      });
                      if (nomeController.text.trim().length < 3) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                content: Text(
                          "O nome deve ser preenchido",
                        )));
                        return;
                      }
                      // ignore: unnecessary_null_comparison
                      if (dataNascimento == null) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                content: Center(
                          child: Text(
                            "Data de nascimento inválida",
                          ),
                        )));
                        return;
                      }
                      if (nivelSelecionado.trim() == "") {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                content: Center(
                          child: Text(
                            "Onivel deve ser selecionado",
                          ),
                        )));
                        return;
                      }
                      if (linguagensSelecionadas.isEmpty) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                content: Center(
                          child: Text(
                            "Deve ser selecionado ao menos uma linguagem",
                          ),
                        )));
                        return;
                      }
                      if (tempoExperiencia == 0) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                content: Center(
                          child: Text(
                            "Deve ter ao menos um ano de experiência em uma das linguagens",
                          ),
                        )));
                        return;
                      }
                      if (salarioEscolhido == 0) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                content: Center(
                          child: Text(
                            "A pretenção salarial deve ser maior que 0",
                          ),
                        )));
                        return;
                      }

                      setState(() {
                        salvando = true;
                      });

                      Future.delayed(const Duration(seconds: 2), () {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                content: Center(
                          child: Text(
                            "Dados salvos com sucesso",
                          ),
                        )));
                        Navigator.pop(context);
                      });
                    },
                    child: const Text("Salvar"),
                  ),
                ],
              ),
      ),
    );
  }
}
