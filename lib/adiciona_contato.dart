import 'package:flutter/material.dart';
import 'package:agenda_contatos/ajudador.dart';

import 'contato.dart';

class AdicionaContato extends StatefulWidget {
  AdicionaContato({Key? key, this.contato}) : super(key: key);

  final Contato? contato;

  @override
  State<AdicionaContato> createState() => _AdicionaContatoState();
}

class _AdicionaContatoState extends State<AdicionaContato> {
  final _nomeController = TextEditingController();
  final _contatoController = TextEditingController();

  @override
  void initState() {
    if (widget.contato != null) {
      _nomeController.text = widget.contato!.nome;
      _contatoController.text = widget.contato!.contato;
    }
    super.initState();
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _contatoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Contato'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(false),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildTextField(_nomeController, 'Nome'),
              SizedBox(
                height: 30,
              ),
              _buildTextField(_contatoController, 'Contato'),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (widget.contato != null) {
                    await DBHelper.atualizarContato(Contato(
                      id: widget.contato!.id,
                      nome: _nomeController.text,
                      contato: _contatoController.text,
                    ));

                    Navigator.of(context).pop(true);
                  } else {
                    await DBHelper.criarContato(Contato(
                      nome: _nomeController.text,
                      contato: _contatoController.text,
                    ));

                    Navigator.of(context).pop(true);
                  }
                },
                child: Text('Adicionar à Lista de Contatos'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextField _buildTextField(TextEditingController _controller, String hint) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        labelText: hint,
        hintText: hint,
        border: OutlineInputBorder(),
      ),
    );
  }
}
