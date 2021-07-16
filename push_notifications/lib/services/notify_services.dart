import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotifyService{
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static StreamController<String> _messageStreamController = new StreamController.broadcast();
  static Stream<String> get messageStream => _messageStreamController.stream;

  static Future _backgroundHandler(RemoteMessage message) async{
    // print('background Handler ${message.messageId}');
    _messageStreamController.add(message.data['producto'] ?? 'No data');
  }

  static Future _onMessageHandler(RemoteMessage message) async{
    // print('onMessage Handler ${message.messageId}');
    _messageStreamController.add(message.data['producto'] ?? 'No data');  }

  static Future _onMessageOpenedApp(RemoteMessage message) async{
    // print('_onMessageOpenApp ${message.messageId}');
    _messageStreamController.add(message.data['producto'] ?? 'No data');
  }

  static Future initializeApp() async{
    //PUSH NOTIFICATIONS
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    print('Token: $token');

    //HANDLERS
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);

    //LOCAL NOTIFICATIONS
  }

  static closeStreams(){
    _messageStreamController.close();
  }
}