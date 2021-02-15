class OurList {
  // Props
  final String docId;
  final String name;
  final Map items;

  OurList({this.docId, this.name, this.items});

  factory OurList.fromJson(Map<String, dynamic> doc) {

    return OurList(
      docId: doc['id'],
      name: doc['name'],
      items: doc['items']
    );
  }

  

}

