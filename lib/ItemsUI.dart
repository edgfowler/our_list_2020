import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'OurList.dart';
import 'Item.dart';

List<OurList> lists;
OurList thisList;

class ItemsUI extends StatefulWidget {
  @override
  _ItemsUIState createState() => _ItemsUIState();
}

class _ItemsUIState extends State<ItemsUI> {
  @override
  Widget build(BuildContext context) {

    final listName = ModalRoute.of(context).settings.arguments;

    setState(() {
      lists = Provider.of<List<OurList>>(context).toList();
      thisList = lists.singleWhere((i) => (i.name == listName));
    });

    return Scaffold(
      appBar: AppBar(title: Text('Items UI')),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          inputDialog(context).then((value) {
            print('ADD: $value');
            setState(
              thisList.items.putIfAbsent(value, () => Item(desc: value))
            );
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (lists == null) return LinearProgressIndicator();

    Map theItemMap = thisList.items;

    List<Item> items = List();

    theItemMap.forEach((key, value) {
      items.add(Item.fromMap(key, value));
    });

    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: items.map((item) => _buildListItem(context, item)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, Item item) {

    String itemText = item.order.toString() + '.  ' + item.desc;
    TextStyle inactiveStyle = TextStyle(decoration: TextDecoration.lineThrough);

    return Padding(
      key: ValueKey(item.desc),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 1.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(2.0),
        ),
        child: ListTile(
          title: Text(itemText,
              style: ! item.active ? inactiveStyle : null,
          ),
        ),
      ),
    );
  }

  Future<String> inputDialog(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text('Enter Item:'),
        content: TextField(
          controller: controller,
        ),
        actions: <Widget>[
          MaterialButton(
            elevation: 5.0,
            child: Text('Add'),
            onPressed: () {
              Navigator.of(context).pop(controller.text.toString());
            },
          )
        ],
      );
    });
  }

}
