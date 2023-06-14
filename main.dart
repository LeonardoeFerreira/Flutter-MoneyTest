import 'package:finacash/screen/InicialPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';

main() {
  // Inicializa as configurações de formatação de data e hora para o aplicativo
  initializeDateFormatting().then((_){
    // Inicia a execução do aplicativo Flutter
    runApp(MaterialApp(
      // Define a página inicial do aplicativo como InicialPage()
      home: InicialPage(),
      // Remove o banner de depuração no canto superior direito da tela do aplicativo
      debugShowCheckedModeBanner: false,
    ));
  });
}
