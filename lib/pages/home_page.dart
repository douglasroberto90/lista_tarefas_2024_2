import 'package:flutter/material.dart';

import '../models/tarefa.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Tarefa> tarefas = [];
  TextEditingController controllerTarefa = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Lista de tarefas",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.brown,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                child: TextField(
                  controller: controllerTarefa,
                  decoration: InputDecoration(
                    label: Text("Nome da tarefa"),
                    hintText: "Digite o nome da tarefa a ser inserida",
                  ),
                ),
              )),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
                child: IconButton(
                    onPressed: () {
                      if (controllerTarefa.text != "" && controllerTarefa.text != null ){
                        Tarefa tarefa = Tarefa(titulo: controllerTarefa.text, realizado: false);
                        setState(() {
                          tarefas.add(tarefa);
                        });
                        controllerTarefa.text="";
                      }
                    },
                    icon: Icon(Icons.add)
                ),
              )
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: contruirItem,
              itemCount: tarefas.length,
            ),
          )
        ],
      ),
    );
  }

  Widget contruirItem(BuildContext context, int index) {
    return CheckboxListTile(
      title: Text(tarefas[index].titulo),
      secondary:
          tarefas[index].realizado
              ? Icon(Icons.check)
              : Icon(Icons.error),
      value: tarefas[index].realizado,
      onChanged: (valorCheckebox) {
        setState(() {
          tarefas[index].realizado=valorCheckebox!;
        });
      },
    );
  }
}
