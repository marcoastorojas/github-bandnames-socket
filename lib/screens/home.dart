import 'package:flutter/material.dart';
import '../models/band.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Band> bandas = [
    Band(id: '1', name: 'banda 1', votes: 120),
    Band(id: '2', name: 'benda 2', votes: 12),
    Band(id: '3', name: 'binda 3', votes: 434),
    Band(id: '4', name: 'bonda 4', votes: 84),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BandNames'),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => _bandTile(bandas[index]),
        itemCount: bandas.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewBand(),
        elevation: 1,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _bandTile(Band banda) {
    return Dismissible(
      key: Key(banda.id),
      direction: DismissDirection.startToEnd,
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

  void _addNewBand() {
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
                  _addBandToList(textController.text);
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

  void _addBandToList(String name) {
    if (name.length > 1) {
      setState(() {
        bandas.add(Band(id: DateTime.now().toString(), name: name, votes: 0));
      });

      Navigator.pop(context);
    }
  }
}
