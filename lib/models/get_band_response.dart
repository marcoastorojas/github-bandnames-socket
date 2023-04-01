import 'dart:convert';

class BandaResponse {
  BandaResponse({
    required this.ok,
    required this.bandas,
  });

  bool ok;
  List<Banda> bandas;

  factory BandaResponse.fromRawJson(String str) =>
      BandaResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BandaResponse.fromJson(Map<String, dynamic> json) => BandaResponse(
        ok: json["ok"],
        bandas: List<Banda>.from(json["bandas"].map((x) => Banda.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "bandas": List<dynamic>.from(bandas.map((x) => x.toJson())),
      };
}

class Banda {
  Banda({
    required this.id,
    required this.name,
    required this.votes,
    required this.v,
  });

  String id;
  String name;
  int votes;
  int v;

  factory Banda.fromRawJson(String str) => Banda.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Banda.fromJson(Map<String, dynamic> json) => Banda(
        id: json["_id"],
        name: json["name"],
        votes: json["votes"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "votes": votes,
        "__v": v,
      };
}
