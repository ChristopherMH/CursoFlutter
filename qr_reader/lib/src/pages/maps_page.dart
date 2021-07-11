import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/bloc/scans_bloc.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';
import 'package:qrreaderapp/utils/utils.dart' as utils;

class MapsPage extends StatelessWidget {
  final scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {
    scansBloc.getScans();

    return StreamBuilder<List<ScanModel>>(
        stream: scansBloc.scansStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final scans = snapshot.data;

          if (scans.length == 0) {
            return Center(
              child: Text('There\'s no info'),
            );
          }

          return ListView.builder(
              itemCount: scans.length,
              itemBuilder: (context, i) {
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (dir) {
                    scansBloc.deleteScan(scans[i].id);
                  },
                  background: Container(
                    color: Colors.redAccent,
                  ),
                  child: ListTile(
                    leading: Icon(Icons.map),
                    title: Text(scans[i].value),
                    subtitle: Text('ID: ${scans[i].id}'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      utils.launchURL(context, scans[i]);
                    },
                  ),
                );
              });
        });
  }
}
