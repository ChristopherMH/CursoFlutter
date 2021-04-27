import 'package:componentes/pages/alert_page.dart';
import 'package:componentes/src/routes/routes.dart';
// import 'package:componentes/pages/home_temp.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        // AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'), // English, no country code
        const Locale('es', 'ES'), // Spanish, no country code
      ],
      title: 'Componentes App',
      // home: HomePage()
      initialRoute: '/',
      routes: getApplicationRoutes(),
      onGenerateRoute: (settings){
        return MaterialPageRoute(
          builder: (context) => AlertPage()
        );
      },
    );
  }
}
