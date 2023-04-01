import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mi_segunda_aplicacion/models/get_band_response.dart';

class BandaProvider with ChangeNotifier {
  List<Banda> bandas = [];
  BandaProvider() {
    getAllBands();
  }

  getAllBands() async {
    var response = await http.get(Uri.http('localhost:3000', '/ver-bandas'));
    BandaResponse respuesta = BandaResponse.fromRawJson(response.body);
    if (respuesta.ok) {
      bandas = respuesta.bandas;
      notifyListeners();
    }
  }

  addBand(Banda newBand) {
    bandas.add(newBand);
    notifyListeners();
  }

  removeBand(String id) {
    bandas = bandas.where((element) => element.id != id).toList();
    notifyListeners();
  }
}
