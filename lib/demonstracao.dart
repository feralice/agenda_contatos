import 'package:flutter/material.dart';
import 'adiciona_contato.dart';
import 'package:agenda_contatos/contato.dart';
import 'package:agenda_contatos/ajudador.dart';

class Demo extends StatefulWidget {
  Demo({Key? key}) : super(key: key);

  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercicio Flutter'),
      ),
      body: FutureBuilder<List<Contato>>(
        future: DBHelper.lerContatos(),
        builder: (BuildContext context, AsyncSnapshot<List<Contato>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Carregando...'),
                ],
              ),
            );
          }

          return snapshot.data!.isEmpty
              ? Center(
            child: Text('Nenhum contato na lista ainda!'),
          )
              : ListView(
            children: snapshot.data!.map((contato) {
              return Center(
                child: ListTile(
                  title: Text(contato.nome),
                  subtitle: Text(contato.contato),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      await DBHelper.excluirContato(contato.id!);
                      setState(() {});
                    },
                  ),
                  onTap: () async {
                    final refresh = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => AdicionaContato(
                          contato: Contato(
                            id: contato.id,
                            nome: contato.nome,
                            contato: contato.contato,
                          ),
                        ),
                      ),
                    );

                    if (refresh) {
                      setState(() {});
                    }
                  },
                ),
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final refresh = await Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => AdicionaContato()),
          );

          if (refresh) {
            setState(() {});
          }
        },
      ),
    );
  }
}
