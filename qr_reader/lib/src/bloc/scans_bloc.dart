import 'dart:async';

import 'package:qrreaderapp/src/bloc/validator.dart';
import 'package:qrreaderapp/src/providers/db_provider.dart';

class ScansBloc with Validators {
  static final ScansBloc _scans = new ScansBloc._internal();

  factory ScansBloc() {
    return _scans;
  }

  ScansBloc._internal() {
    //Get Scans from database
    getScans();
  }

  final _scansController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStream =>
      _scansController.stream.transform(validateGeo);
  Stream<List<ScanModel>> get scansStreamHttp =>
      _scansController.stream.transform(validateHttp);

  dispose() {
    _scansController?.close();
  }

  getScans() async {
    _scansController.sink.add(await DBProvider.db.getAllScans());
  }

  addScan(ScanModel newScan) async {
    await DBProvider.db.newScan(newScan);
    getScans();
  }

  deleteScan(int id) async {
    await DBProvider.db.deleteScan(id);
    getScans();
  }

  deleteAllScans() async {
    await DBProvider.db.deleteAll();
    getScans();
  }

  deleteAllMaps() async {
    await DBProvider.db.deleteAllMaps();
    getScans();
  }

  deleteAllAddresses() async {
    await DBProvider.db.deleteAllAddresses();
    getScans();
  }
}
