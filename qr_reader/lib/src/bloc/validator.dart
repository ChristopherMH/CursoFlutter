import 'dart:async';

import 'package:qrreaderapp/src/models/scan_model.dart';

class Validators {
  final validateGeo =
      StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
          handleData: (scans, sink) {
    final geoScans = scans.where((element) => element.type == 'geo').toList();
    sink.add(geoScans);
  });

  final validateHttp =
      StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
          handleData: (scans, sink) {
    final httpScans = scans.where((element) => element.type == 'http').toList();
    sink.add(httpScans);
  });
}
