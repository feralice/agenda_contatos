import 'package:flutter/material.dart';
import 'package:agenda_contatos/demonstracao.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Local Database',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Demo(),
    );
  }
}
