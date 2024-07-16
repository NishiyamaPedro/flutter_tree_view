import 'package:json_annotation/json_annotation.dart';

part 'companies_model.g.dart';

@JsonSerializable()
class Company {
  String id;
  String name;

  Company(this.id, this.name);

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyToJson(this);
}
