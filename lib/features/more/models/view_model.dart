class ViewsModel {
  int? count;
  String? clicks;

  ViewsModel({this.count, this.clicks});

  ViewsModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    clicks = "${json['clicks']}";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['clicks'] = this.clicks;
    return data;
  }
}
