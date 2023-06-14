import 'package:finacash/Helper/Movimentacoes_helper.dart';
import 'package:finacash/Widgets/AnimatedBottomNavBar.dart';
import 'package:finacash/Widgets/CardMovimentacoesItem.dart';
import 'package:finacash/screen/DespesasResumo.dart';
import 'package:finacash/screen/HomePage.dart';
import 'package:finacash/screen/ReceitasResumo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:table_calendar/table_calendar.dart';

class InicialPage extends StatefulWidget {
  final List<BarItem> barItems = [
    // Itens da barra de navegação inferior
    BarItem(
      text: "Despesas",
      iconData: Icons.remove_circle_outline,
      color: Colors.pinkAccent,
    ),
    BarItem(
      text: "Home",
      iconData:  Icons.home,
      color: Colors.indigo,
    ),
    BarItem(
      text: "Receitas",
      iconData: Icons.add_circle_outline,
      color: Colors.teal,
    ),
  ];

  @override
  _InicialPageState createState() => _InicialPageState();
}

class _InicialPageState extends State<InicialPage> {
  int selectedBarIndex = 1; // Índice do item selecionado na barra de navegação inferior

  @override
  Widget build(BuildContext context) {
    // Obtém as dimensões da tela
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // Define o estilo da barra de status e da barra de navegação
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      statusBarIconBrightness: Brightness.light,
    ));

    // Define as orientações de tela permitidas
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    List<Widget> telas = [
      // Telas correspondentes a cada item da barra de navegação
      DespesasResumo(),
      HomePage(),
      ReceitasResumo(),
    ];

    return Scaffold(
      body: telas[selectedBarIndex], // Exibe a tela correspondente ao item selecionado
      bottomNavigationBar: AnimatedBottomBar(
        // Barra de navegação inferior animada
        barItems: widget.barItems,
        animationDuration: const Duration(milliseconds: 150),
        barStyle: BarStyle(
          fontSize: width * 0.045,
          iconSize: width * 0.07,
        ),
        onBarTap: (index) {
          // Função chamada quando um item da barra de navegação é selecionado
          setState(() {
            selectedBarIndex = index;
          });
        },
      ),
    );
  }
}
