//import 'package:sqflite/sqflite.dart';

final String idColumn = "idColumn";
final String nameColumn = "nameColumn";
final String emailColumn = "imgColumn";
final String phoneColumn = "imgColumn";
final String imgColumn = "imgColumn";

class ContactHelper{

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