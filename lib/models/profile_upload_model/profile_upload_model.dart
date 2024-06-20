class ProfileUploadModel {
  String? condition;
  String? message;
  String? imageUrl;

  ProfileUploadModel({this.condition, this.message, this.imageUrl});

  ProfileUploadModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['image_url'] = this.imageUrl;
    return data;
  }
}