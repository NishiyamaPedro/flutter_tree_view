import 'package:json_annotation/json_annotation.dart';

import '../tree_view/node.dart';

part 'assets_model.g.dart';

enum AssetStatus { operating, alert }

enum AssetSensorType { vibration, energy }

@JsonSerializable()
class Asset with NodeMixin {
  String name;
  String? gatewayId;
  String? sensorId;
  AssetSensorType? sensorType;
  AssetStatus? status;

  Asset(id, this.name) {
    this.id = id;
  }

  factory Asset.fromJson(Map<String, dynamic> json) => _$AssetFromJson(json);
  Map<String, dynamic> toJson() => _$AssetToJson(this);
}
