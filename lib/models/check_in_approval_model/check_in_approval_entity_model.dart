import 'dart:convert';
import '../../generated/json/base/json_field.dart';
import '../../generated/json/check_in_approve_entity.g.dart';
@JsonSerializable()
class CheckInApproveEntity {
  late String condition = "";
  late String message = "";
  @JSONField(name: "document_no")
  late String documentNo = "";
  @JSONField(name: "pending_count")
  late String pendingCount = "";
  @JSONField(name: "like_count")
  late String likeCount = "";
  @JSONField(name: "dislike_count")
  late String dislikeCount = "";
  @JSONField(name: "emp_name")
  late String empName = "";
  @JSONField(name: "place_to_visit")
  late String placeToVisit = "";
  @JSONField(name: "completed_on")
  late String completed_on = "";
  @JSONField(name: "image_url")
  late String imageUrl = "";
  @JSONField(name: "document_type")
  late String documentType = "";

  CheckInApproveEntity();

  factory CheckInApproveEntity.fromJson(Map<String, dynamic> json) => $CheckInApproveEntityFromJson(json);

  Map<String, dynamic> toJson() => $CheckInApproveEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}