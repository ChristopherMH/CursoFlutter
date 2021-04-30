import 'package:componentes/pages/alert_page.dart';
import 'package:componentes/pages/animated_container.dart';
import 'package:componentes/pages/avart_page.dart';
import 'package:componentes/pages/card_page.dart';
import 'package:componentes/pages/home_page.dart';
import 'package:componentes/pages/input_page.dart';
import 'package:componentes/pages/listview_page.dart';
import 'package:componentes/pages/slider_page.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getApplicationRoutes(){
  return <String, WidgetBuilder>{
    '/' : (BuildContext context) => HomePage(),
    'alert' : (BuildContext context) => AlertPage(),
    AvatarPage.pageName: (BuildContext context) => AvatarPage(),
    'card': (BuildContext context) => CardPage(),
    'animatedContainer': (BuildContext context) => AnimatedContainerPage(),
    'inputs': (BuildContext context) => InputPage(),
    'slider': (BuildContext context) => SliderPage(),
    'list': (BuildContext context) => ListaPage()
  };
}