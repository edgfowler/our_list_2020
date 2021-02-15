import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'OurList.dart';

class ListsUI extends StatefulWidget {
  @override
  _ListsUIState createState() => _ListsUIState();
}

class _ListsUIState extends State<ListsUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lists UI')),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //print('ADD A LIST');
          showDialog(
              context: context,
              builder: (context) {
                Future.delayed(Duration(seconds: 2), () {
                  Navigator.of(context).pop(true);
                });
                return AlertDialog(
                  title: Text('Coming soon.'),
                );
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    var lists = Provider.of<List<OurList>>(context);
    if (lists == null) return Center(child: CircularProgressIndicator());

    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: lists.map((list) => _buildListItem(context, list)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, OurList list) {
    return Padding(
      key: ValueKey(list.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        //padding: const EdgeInsets.only(bottom: 10.0, top: 20.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          //contentPadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 1.1) ,
          title: Text(
            list.name + '  <' + list.docId + '>',
          ),
          onTap: () =>
              Navigator.pushNamed(context, '/ItemsUI', arguments: list.name),
        ),
      ),
    );
  }
}
