

import '../../models/check_in_approval_model/check_in_approval_entity_model.dart';
import 'base/json_convert_content.dart';

CheckInApproveEntity $CheckInApproveEntityFromJson(Map<String, dynamic> json) {
  final CheckInApproveEntity checkInApproveEntity = CheckInApproveEntity();
  final String? condition = jsonConvert.convert<String>(json['condition']);
  if (condition != null) {
    checkInApproveEntity.condition = condition;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    checkInApproveEntity.message = message;
  }
  final String? documentNo = jsonConvert.convert<String>(json['document_no']);
  if (documentNo != null) {
    checkInApproveEntity.documentNo = documentNo;
  }
  final String? pendingCount = jsonConvert.convert<String>(
      json['pending_count']);
  if (pendingCount != null) {
    checkInApproveEntity.pendingCount = pendingCount;
  }
  final String? likeCount = jsonConvert.convert<String>(json['like_count']);
  if (likeCount != null) {
    checkInApproveEntity.likeCount = likeCount;
  }
  final String? dislikeCount = jsonConvert.convert<String>(
      json['dislike_count']);
  if (dislikeCount != null) {
    checkInApproveEntity.dislikeCount = dislikeCount;
  }
  final String? empName = jsonConvert.convert<String>(json['emp_name']);
  if (empName != null) {
    checkInApproveEntity.empName = empName;
  }
  final String? placeToVisit = jsonConvert.convert<String>(
      json['place_to_visit']);
  if (placeToVisit != null) {
    checkInApproveEntity.placeToVisit = placeToVisit;
  }
  final String? compltedOn = jsonConvert.convert<String>(json['completed_on']);
  if (compltedOn != null) {
    checkInApproveEntity.completed_on = compltedOn;
  }
  final String? imageUrl = jsonConvert.convert<String>(json['image_url']);
  if (imageUrl != null) {
    checkInApproveEntity.imageUrl = imageUrl;
  }
  final String? documentType = jsonConvert.convert<String>(json['document_type']);
  if (documentType != null) {
    checkInApproveEntity.documentType = documentType;
  }
  return checkInApproveEntity;
}

Map<String, dynamic> $CheckInApproveEntityToJson(CheckInApproveEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['condition'] = entity.condition;
  data['message'] = entity.message;
  data['document_no'] = entity.documentNo;
  data['pending_count'] = entity.pendingCount;
  data['like_count'] = entity.likeCount;
  data['dislike_count'] = entity.dislikeCount;
  data['emp_name'] = entity.empName;
  data['place_to_visit'] = entity.placeToVisit;
  data['completed_on'] = entity.completed_on;
  data['image_url'] = entity.imageUrl;
  data['document_type'] = entity.documentType;
  return data;
}

extension CheckInApproveEntityExtension on CheckInApproveEntity {
  CheckInApproveEntity copyWith({
    String? condition,
    String? message,
    String? documentNo,
    String? pendingCount,
    String? likeCount,
    String? dislikeCount,
    String? empName,
    String? placeToVisit,
    String? compltedOn,
    String? imageUrl,
    String? documentType,
  }) {
    return CheckInApproveEntity()
      ..condition = condition ?? this.condition
      ..message = message ?? this.message
      ..documentNo = documentNo ?? this.documentNo
      ..pendingCount = pendingCount ?? this.pendingCount
      ..likeCount = likeCount ?? this.likeCount
      ..dislikeCount = dislikeCount ?? this.dislikeCount
      ..empName = empName ?? this.empName
      ..placeToVisit = placeToVisit ?? this.placeToVisit
      ..completed_on = compltedOn ?? this.completed_on
      ..imageUrl = imageUrl ?? this.imageUrl
      ..documentType = documentType ?? this.documentType;

  }
}