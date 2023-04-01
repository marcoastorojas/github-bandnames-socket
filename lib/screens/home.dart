import 'package:flutter/material.dart';
import 'package:mi_segunda_aplicacion/models/get_band_response.dart';
import 'package:mi_segunda_aplicacion/providers/bandas_provider.dart';
import 'package:mi_segunda_aplicacion/providers/socket_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BandaProvider>(context);
    final socketProvider = Provider.of<SocketProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('BandNames'),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => _bandTile(provider.bandas[index]),
        itemCount: provider.bandas.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewBand(socketProvider),
        elevation: 1,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _bandTile(Banda banda) {
    final socketProvider = Provider.of<SocketProvider>(context);
    return Dismissible(
      key: Key(banda.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        socketProvider.eliminarBanda(banda.id);
      },
      background: Container(
        padding: const EdgeInsets.only(left: 10),
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'delete band',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(child: Text(banda.name.substring(0, 2))),
        title: Text(banda.name),
        trailing: Text('${banda.votes}', style: const TextStyle(fontSize: 20)),
      ),
    );
  }

  void _addNewBand(SocketProvider provider) {
    final TextEditingController textController = TextEditingController();

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('New band Name'),
            content: TextField(
              controller: textController,
            ),
            actions: <Widget>[
              MaterialButton(
                onPressed: () {
                  _addBandToList(textController.text, provider);
                },
                elevation: 5,
                textColor: Colors.blue,
                child: const Text('Add'),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Atras',
                  style: TextStyle(color: Colors.red),
                ),
              )
            ],
          );
        });
  }

  void _addBandToList(String name, SocketProvider provider) {
    if (name.length > 1) {
      provider.agregarBanda(name);
      Navigator.pop(context);
    }
  }
}
