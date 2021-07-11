import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';
import 'package:qrreaderapp/src/pages/addresses_page.dart';
import 'package:qrreaderapp/src/pages/maps_page.dart';
import 'package:qrreaderapp/src/bloc/scans_bloc.dart';
import 'package:qrreaderapp/utils/utils.dart' as utils;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scansBloc = new ScansBloc();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: [
          IconButton(
              icon: Icon(Icons.delete_forever),
              onPressed: () {
                if (currentIndex == 0) {
                  scansBloc.deleteAllMaps();
                } else {
                  scansBloc.deleteAllAddresses();
                }
              }),
        ],
      ),
      body: _callPage(currentIndex),
      bottomNavigationBar: _createBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.filter_center_focus,
        ),
        onPressed: () => _qrScan(context),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _createBottomNavigationBar() {
    return BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(label: 'Maps', icon: Icon(Icons.map)),
          BottomNavigationBarItem(
              label: 'Addresses', icon: Icon(Icons.location_on))
        ]);
  }

  Widget _callPage(int currentPage) {
    switch (currentPage) {
      case 0:
        return MapsPage();
      case 1:
        return AddressesPage();
      default:
        return MapsPage();
    }
  }

  void _qrScan(BuildContext context) async {
    String futureString = await FlutterBarcodeScanner.scanBarcode(
        '#ff8888', 'CANCEL', true, ScanMode.QR);
    if (futureString != '-1') {
      final ScanModel newScan = ScanModel(value: futureString);
      scansBloc.addScan(newScan);

      if (Platform.isIOS) {
        Future.delayed(Duration(milliseconds: 800), () {
          utils.launchURL(context, newScan);
        });
      } else {
        utils.launchURL(context, newScan);
      }
    }
  }
}
