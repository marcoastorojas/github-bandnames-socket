import 'dart:convert';

class Band {
  String id;
  String name;
  int votes;

  static List<Band> getBandsOfListOfMapsinString(String str) {
    List<dynamic> listOfMaps = jsonDecode(str);
    return listOfMaps.map((map) => Band.fromMap(map)).toList();
  }

  Band({required this.id, required this.name, required this.votes});

  factory Band.fromMap(Map obj) =>
      Band(id: obj['id'], name: obj['name'], votes: obj['votes']);
}
