
class Item {
  String desc;
  bool active;
  int order;

  Item({this.desc, this.active, this.order});

  factory Item.fromMap(String key, Map map) {
    return Item(
      desc: key,
      active: map['active'] ?? false,
      order: map['order'] ?? 0,
    );
  }
}
