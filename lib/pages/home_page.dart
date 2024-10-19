import 'package:flutter/material.dart';
import 'package:lista_tarefas_2024_2/repositories/repositorio.dart';
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
  void initState() {
    Repositorio.recuperarLista().then(
      (retornoDoThen) {
        setState(() {
          tarefas = retornoDoThen;
        });
      },
    );
    super.initState();
  }

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
                      if (controllerTarefa.text != "" &&
                          controllerTarefa.text != null) {
                        Tarefa tarefa = Tarefa(
                            titulo: controllerTarefa.text, realizado: false);
                        setState(() {
                          tarefas.add(tarefa);
                        });
                        controllerTarefa.text = "";
                        Repositorio.salvarListaTarefas(tarefas);
                      }
                    },
                    icon: Icon(Icons.add)),
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
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      onDismissed: (direction) {
        Tarefa tarefaRemovida = tarefas[index];
        int indiceTarefaRemovida = index;
        setState(() {
          tarefas.removeAt(index);
        });
        Repositorio.salvarListaTarefas(tarefas);
        SnackBar snackBar = SnackBar(
          content: Text("A tarefa ${tarefaRemovida.titulo} foi removida"),
          action: SnackBarAction(
            label: "Desfazer",
            onPressed: () {
              setState(() {
                tarefas.insert(indiceTarefaRemovida, tarefaRemovida);
              });
              Repositorio.salvarListaTarefas(tarefas);
            },
          ),
        );
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      direction: DismissDirection.startToEnd,
      background: Container(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Icon(
              Icons.delete,
              color: Colors.white,
              size: 40,
            ),
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.red,
        ),
      ),
      child: CheckboxListTile(
        title: Text(tarefas[index].titulo),
        secondary:
            tarefas[index].realizado ? Icon(Icons.check) : Icon(Icons.error),
        value: tarefas[index].realizado,
        onChanged: (valorCheckebox) {
          setState(() {
            tarefas[index].realizado = valorCheckebox!;
            Repositorio.salvarListaTarefas(tarefas);
          });
        },
      ),
    );
  }
}
