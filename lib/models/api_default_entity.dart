
import 'dart:convert';
import '../generated/json/api_default_entity.g.dart';
import '../generated/json/base/json_field.dart';

@JsonSerializable()
class ApiDefaultEntity {
	late String condition = "";
	late String message = "";

	ApiDefaultEntity();

	factory ApiDefaultEntity.fromJson(Map<String, dynamic> json) => $ApiDefaultEntityFromJson(json);

	Map<String, dynamic> toJson() => $ApiDefaultEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}