// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:push_notifications/screens/home_screen.dart';
import 'package:push_notifications/screens/message_screen.dart';
import 'package:push_notifications/services/notify_services.dart';
 
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await NotifyService.initializeApp();

  runApp(MyApp());
}
 
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = new GlobalKey<ScaffoldMessengerState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NotifyService.messageStream.listen((message) {
      // print('MyApp: $message');
      navigatorKey.currentState?.pushNamed('message', arguments: message);
      final snackBar = SnackBar(content: Text(message));
      scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
    }); 
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'home',
      navigatorKey: navigatorKey,//navegar
      scaffoldMessengerKey: scaffoldMessengerKey,//Mostrar snacks
      routes: {
        'home': (_) => HomeScreen(),
        'message': (_) => MessageScreen(),
      },
    );
  }
}