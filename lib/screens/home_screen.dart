import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Band> bands = [
    Band(id: '1', name: 'Metallica', votes: 5),
    Band(id: '2', name: 'Queen', votes: 1),
    Band(id: '3', name: 'Héroes del Silencio', votes: 2),
    Band(id: '4', name: 'Bon Jovi', votes: 5),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Band Names', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 5,
      ),
      body: ListView.builder(
        itemCount: bands.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              //color: Colors.transparent,
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Dismissible(
                key: Key(bands[index].id),
                direction: DismissDirection.startToEnd,
                background: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Delete', style: TextStyle(color: Colors.white, fontSize: 20))
                    ),
                  ),
                ),
                onDismissed: (DismissDirection direction) {
                  setState(() {
                    bands.removeAt(index);
                  });
                },
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(bands[index].name.substring(0,2), style: const TextStyle(color: Colors.amber)),
                      backgroundColor: Colors.amber[100],
                    ),
                    title: Text(bands[index].name, style: const TextStyle(fontSize: 25),),
                    trailing: Text('${bands[index].votes}', style: const TextStyle(fontSize: 20)),
                    onTap: (){
                    },
                  ),
                ),
              ),
            );
          },
        ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: const Icon(Icons.add,),
        elevation: 10,
        onPressed: (){
          _addNewBand();
        },
      ),
    );
  }

  _addNewBand(){
    final textController = TextEditingController();
    if(Platform.isAndroid) {
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: const Text('New Band Name'),
          content: TextField(
            controller: textController,
            decoration: const InputDecoration(
              hintText: 'Band Name',
              labelText: 'Band Name',
            ),
            onChanged: (value) {},
          ),
          actions: [
            MaterialButton(
              child: const Text('Add'),
              elevation: 10,
              textColor: Colors.amber,
              onPressed: () => _addBandToList(textController.text),

            )
          ],
        );
      });
    }else{
      showCupertinoDialog(context: context, builder: (context){
        return CupertinoAlertDialog(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: const Text('New Band Name'),
          ),
          content: CupertinoTextField(
            controller: textController,
            onChanged: (value) {},
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text('Add'),
              isDefaultAction: true,
              onPressed: () => _addBandToList(textController.text),
            ),
            CupertinoDialogAction(
              child: const Text('Dismiss'),
              isDestructiveAction: true,
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      });
    }
  }

  _addBandToList(String name){
    if(name.length > 1){

      this.bands.add(Band(id: DateTime.now().toString(), name: name, votes: 0));
      setState(() {

      });

    }
    Navigator.pop(context);
  }





}