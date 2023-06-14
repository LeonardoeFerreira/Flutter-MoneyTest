// Importações necessárias
import 'package:finacash/Helper/Movimentacoes_helper.dart'; // Importa a classe MovimentacoesHelper
import 'package:finacash/Widgets/TimeLineItem.dart'; // Importa a classe TimeLineItem
import 'package:flutter/material.dart'; // Importa o pacote de widgets do Flutter

// Classe ReceitasResumo, um StatefulWidget
class ReceitasResumo extends StatefulWidget {
  @override
  _ReceitasResumoState createState() => _ReceitasResumoState();
}

// Estado da classe ReceitasResumo
class _ReceitasResumoState extends State<ReceitasResumo> {
  MovimentacoesHelper movimentacoesHelper = MovimentacoesHelper(); // Instância da classe MovimentacoesHelper
  List<Movimentacoes> listmovimentacoes = List(); // Lista de movimentações

  // Função para obter todas as movimentações do tipo 'r' (receitas)
  _allMovPorTipo() {
    movimentacoesHelper.getAllMovimentacoesPorTipo("r").then((list) {
      setState(() {
        listmovimentacoes = list; // Atualiza a lista de movimentações
      });
      print("All Mov: $listmovimentacoes"); // Imprime a lista de movimentações
    });
  }

  @override
  void initState() {
    super.initState();
    _allMovPorTipo(); // Chama a função para obter todas as movimentações do tipo 'r' ao iniciar o estado
  }
  
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width; // Obtém a largura da tela
    double height = MediaQuery.of(context).size.height; // Obtém a altura da tela

    return Scaffold(
      backgroundColor: Colors.green.withOpacity(0.8), // Define a cor de fundo do Scaffold como verde com opacidade 0.8
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(), // Define a física do scroll como ClampingScrollPhysics
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Título "Receitas"
            Padding(
              padding: EdgeInsets.only(left: width * 0.05, top: width * 0.2),
              child: Text(
                "Receitas",
                style: TextStyle(
                  color: Colors.white, // Define a cor do texto como branco
                  fontWeight: FontWeight.bold,
                  fontSize: width * 0.08, // Define o tamanho da fonte com base na largura da tela
                ),
              ),
            ),
            // Lista de movimentações
            Padding(
              padding: EdgeInsets.only(left: width * 0.03, top: width * 0.08),
              child: SizedBox(
                width: width,
                height: height * 0.74,
                child: ListView.builder(
                  itemCount: listmovimentacoes.length, // Define o número de itens na lista como o tamanho da lista de movimentações
                  itemBuilder: (context, index) {
                    List movReverse = listmovimentacoes.reversed.toList(); // Inverte a ordem da lista de movimentações
                    Movimentacoes mov = movReverse[index]; // Obtém a movimentação atual

                    // Verifica se a movimentação atual é a última da lista
                    if (movReverse[index] == movReverse.last) {
                      // Retorna um TimeLineItem com isLast definido como true
                     
                      return TimeLineItem(
                        mov: mov,
                        colorItem: Colors.green[900],
                        isLast: true,
                      );
                    } else {
                      // Caso contrário, retorna um TimeLineItem com isLast definido como false
                      return TimeLineItem(
                        mov: mov,
                        colorItem: Colors.green[900],
                        isLast: false,
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
