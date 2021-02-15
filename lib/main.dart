import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ListsUI.dart';
import 'ItemsUI.dart';
import 'DataService.dart';

// flutter run -d web-server --web-hostname 192.168.1.3 --web-port 80
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    OurApp(),
  );
}

class OurApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider(create: (BuildContext context) => DataService().loadLists())
      ],
      child: MaterialApp(
          title: 'Our Lists',
          home: ListsUI(),
          initialRoute: '/ListsUI',
          routes: {
            '/ListsUI': (context) => ListsUI(),
            '/ItemsUI': (context) => ItemsUI(),
          },
      ),
    );
  }

  handlerror(e) { print(e.toString()); }
}
