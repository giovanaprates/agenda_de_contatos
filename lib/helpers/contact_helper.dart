import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

final String contactTable = "contactTable";
final String idColumn = "idColumn";
final String nameColumn = "nameColumn";
final String emailColumn = "imgColumn";
final String phoneColumn = "imgColumn";
final String imgColumn = "imgColumn";

class ContactHelper{
  //Essa classe irá conter apenas um objeto. Ou seja, não ela não pode ter várias instâncias
  //Por isso, será usado o padrão singleton
  //_instance é o objeto da própria classe
  static final ContactHelper _instance = ContactHelper.internal(); //var apenas uma na classe inteira, variável da clase não do objeto. Não alterável. Declarando objeto da classe dentro da classe
  
  factory ContactHelper() => _instance;
  
  ContactHelper.internal();

  Database _db;//Criando BD

  Future<Database> get db async{
    if(db != null){
      return _db;
    }
    else{
      _db = await initDb(); //Inicializa o BD
      return _db;
    }
  }

  Future<Database> initDb() async { //Inicializando o BD. Função assíncrona não ocorre instantaneamente
    final databasesPath = await getDatabasesPath(); //com o await ele espera retornar os dados antes de continuar a execução do código
    final path = join(databasesPath, "contacts.db");

    return await openDatabase(path, version:1, onCreate: (Database db, int newerVersion) async{ //Abrindo o BD.
      await db.execute(
        "CREATE TABLE $contactTable($idColumn INTEGER PRIMARY KEY, $nameColumn TEXT, $emailColumn TEXT, $phoneColumn TEXT, $imgColumn TEXT)"
      );
    });
  }

}

class Contact{ //Criando o contato
  int id;
  String name;
  String email;
  String phone;
  String img;

  Contact.fromMap(Map map){ //Pegando de um mapa e passando para o contato
    id = map[idColumn];
    name = map[nameColumn];
    email = map[emailColumn];
    phone = map[phoneColumn];
    img = map[imgColumn];
  }

  //Pegando o contato e tranformando em mapa
  Map toMap(){
    Map<String, dynamic> map = { //String tem o campo. Ex idColumn. Dynamic tem o dado. Ex id.
      nameColumn: name,
      emailColumn: email,
      phoneColumn: phone,
      imgColumn: img
    }; //Não colocamos o id porque quando formos criar um contato ele n terá o id. Quem vai dar o id é o banco de dados
    if(id != null){
      map[idColumn] = id;
    }
    return map;
  }

  @override
  String toString() { //Isso é para ler os dados do contato de uma forma legal. Quando quiser ver todas as informações do contato basta dar print(contato)
      // TODO: implement toString
      return "Contact(id: $id, name: $name, email: $email, phone: $phone, img: $img)";
    }

}