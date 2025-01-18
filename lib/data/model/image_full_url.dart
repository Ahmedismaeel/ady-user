class ImageFullUrl {
  String? key;
  String? path;
  int? status;
  String? url;

  ImageFullUrl({this.key, this.path, this.status, this.url});

  ImageFullUrl.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    path = json['path'];
    url = json['url'];
    status = json['status'];
    if (status != 200) {
      path = '';
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['path'] = path;
    data['url'] = url;
    data['status'] = status;
    return data;
  }
}
