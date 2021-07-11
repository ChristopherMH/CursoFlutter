import "package:latlong/latlong.dart";

class ScanModel {
  int id;
  String type;
  String value;

  ScanModel({
    this.id,
    this.type,
    this.value,
  }) {
    if (value.contains('http')) {
      type = 'http';
    } else {
      type = 'geo';
    }
  }

  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        type: json["type"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "value": value,
      };

  getLatLng() {
    final latLng = value.substring(4).split(',');
    final lattitude = double.parse(latLng[0]);
    final longitude = double.parse(latLng[1]);
    return LatLng(lattitude, longitude);
  }
}
