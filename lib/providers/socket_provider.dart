import 'package:flutter/material.dart';
import 'package:mi_segunda_aplicacion/models/get_band_response.dart';
import 'package:mi_segunda_aplicacion/providers/bandas_provider.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketProvider with ChangeNotifier {
  late BandaProvider bandaProvider;
  late io.Socket socket;

  SocketProvider() {
    init();
  }

  void init() {
    socket = io.io('http://localhost:3000');

    socket.onConnect((_) => print('Conectado'));
    socket.onDisconnect((_) => print('Desconectado'));
    socket.on(
        'nuevo-banda', (data) => bandaProvider.addBand(Banda.fromJson(data)));
    socket.on('perro-loco', (msg) => bandaProvider.removeBand(msg));
  }

  void eliminarBanda(String id) {
    socket.emit('eliminar-banda', id);
  }

  void agregarBanda(String nombre) {
    socket.emit('agregar-banda', {'nombre': nombre});
  }

  void incrementar1voto(String id) {
    socket.emit('agregar-voto', id);
  }
}
