// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assets_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Asset _$AssetFromJson(Map<String, dynamic> json) => Asset(
      json['id'],
      json['name'] as String,
    )
      ..parentId = json['parentId'] as String?
      ..locationId = json['locationId'] as String?
      ..gatewayId = json['gatewayId'] as String?
      ..sensorId = json['sensorId'] as String?
      ..sensorType =
          $enumDecodeNullable(_$AssetSensorTypeEnumMap, json['sensorType'])
      ..status = $enumDecodeNullable(_$AssetStatusEnumMap, json['status']);

Map<String, dynamic> _$AssetToJson(Asset instance) => <String, dynamic>{
      'id': instance.id,
      'parentId': instance.parentId,
      'locationId': instance.locationId,
      'name': instance.name,
      'gatewayId': instance.gatewayId,
      'sensorId': instance.sensorId,
      'sensorType': _$AssetSensorTypeEnumMap[instance.sensorType],
      'status': _$AssetStatusEnumMap[instance.status],
    };

const _$AssetSensorTypeEnumMap = {
  AssetSensorType.vibration: 'vibration',
  AssetSensorType.energy: 'energy',
};

const _$AssetStatusEnumMap = {
  AssetStatus.operating: 'operating',
  AssetStatus.alert: 'alert',
};
