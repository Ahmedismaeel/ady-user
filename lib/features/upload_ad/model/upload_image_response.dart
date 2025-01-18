class UploadImageResponse {
  String? imageName;
  String? type;

  UploadImageResponse({this.imageName, this.type});

  UploadImageResponse.fromJson(Map<String, dynamic> json) {
    imageName = json['image_name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image_name'] = this.imageName;
    data['type'] = this.type;
    return data;
  }
}
