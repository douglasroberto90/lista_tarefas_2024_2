import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/tarefa.dart';

class Repositorio {

  static SharedPreferencesAsync _pegarPreferencias(){
    return SharedPreferencesAsync();
  }

  static Future<void> salvarListaTarefas(List<Tarefa> tarefas) async {
    final asyncPrefs = _pegarPreferencias();
    List<String> tarefasEmFormatoString = [];
    for (Tarefa task in tarefas) {
      Map<String, dynamic> json = Tarefa.paraJson(task);
      tarefasEmFormatoString.add(jsonEncode(json));
    }
    await asyncPrefs.setStringList("Lista_tarefas", tarefasEmFormatoString);
  }

  static Future<List<Tarefa>> recuperarLista() async {
    final asyncPrefs = _pegarPreferencias();
    List<Tarefa> tarefas = [];
    List<String>? tarefasEmFormatoString = await asyncPrefs.getStringList("Lista_tarefas");
    if (tarefasEmFormatoString!=null){
      for (String tarefa in tarefasEmFormatoString){
        Map<String, dynamic> json = jsonDecode(tarefa);
        tarefas.add(Tarefa.deJson(json));
      }
    }
    return tarefas;
  }
}
