// ignore_for_file: file_namess

import 'package:flutter/material.dart';
import 'package:telalogin/pages/dados_cadastrais.dart';
import 'package:telalogin/pages/pagina1.dart';
import 'package:telalogin/pages/pagina2.dart';
import 'package:telalogin/pages/pagina3.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var posisaoPag = 0;
  PageController controller = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meu App"),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: const Text("Dados cadastrais"),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DadosCadastrais(),
                      ),
                    );
                  },
                ),
                const Divider(),
                const SizedBox(height: 10),
                InkWell(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: const Text("Configurações"),
                  ),
                  onTap: () {},
                ),
                const Divider(),
                const SizedBox(height: 10),
                InkWell(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: const Text("Termos de uso e privaciade"),
                  ),
                  onTap: () {},
                ),
                const Divider(),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: controller,
              onPageChanged: (value) {
                setState(() {
                  posisaoPag = value;
                });
              },
              scrollDirection: Axis.horizontal,
              children: const [
                Pagina1(),
                Pagina2(),
                Pagina3(),
              ],
            ),
          ),
          BottomNavigationBar(
            onTap: (value) {
              controller.jumpToPage(value);
            },
            currentIndex: posisaoPag,
            items: const [
              BottomNavigationBarItem(
                label: "Home",
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                label: "Add",
                icon: Icon(Icons.add),
              ),
              BottomNavigationBarItem(
                label: "Perfil",
                icon: Icon(Icons.person),
              )
            ],
          ),
        ],
      ),
    );
  }
}
