
class Tarefa{
  Tarefa({required this.titulo, required this.realizado});

  String titulo;
  bool realizado;

  static Map<String, dynamic> paraJson (Tarefa tarefa){
    /*Map<String, dynamic> listaJson ={};
    listaJson["titulo"]=tarefa.titulo;
    listaJson["realizado"]=tarefa.realizado;*/
    return {
      "titulo": tarefa.titulo,
      "realizado": tarefa.realizado
    };
  }

  static Tarefa deJson (Map<String, dynamic> json){
    return Tarefa(titulo: json["titulo"], realizado: json["realizado"]);
  }
}