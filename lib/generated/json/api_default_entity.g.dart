import '../../models/api_default_entity.dart';
import 'base/json_convert_content.dart';

ApiDefaultEntity $ApiDefaultEntityFromJson(Map<String, dynamic> json) {
  final ApiDefaultEntity apiDefaultEntity = ApiDefaultEntity();
  final String? condition = jsonConvert.convert<String>(json['condition']);
  if (condition != null) {
    apiDefaultEntity.condition = condition;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    apiDefaultEntity.message = message;
  }
  return apiDefaultEntity;
}

Map<String, dynamic> $ApiDefaultEntityToJson(ApiDefaultEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['condition'] = entity.condition;
  data['message'] = entity.message;
  return data;
}

extension ApiDefaultEntityExtension on ApiDefaultEntity {
  ApiDefaultEntity copyWith({
    String? condition,
    String? message,
  }) {
    return ApiDefaultEntity()
      ..condition = condition ?? this.condition
      ..message = message ?? this.message;
  }
}