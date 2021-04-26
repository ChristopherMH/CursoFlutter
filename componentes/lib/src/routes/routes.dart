import 'package:componentes/pages/alert_page.dart';
import 'package:componentes/pages/avart_page.dart';
import 'package:componentes/pages/card_page.dart';
import 'package:componentes/pages/home_page.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getApplicationRoutes(){
  return <String, WidgetBuilder>{
    '/' : (BuildContext context) => HomePage(),
    'alert' : (BuildContext context) => AlertPage(),
    'avatar' : (BuildContext context) => AvatarPage(),
    'card': (BuildContext context) => CardPage()
  };
}