class PaymentResponse {
  String? payUrl;

  PaymentResponse({this.payUrl});

  PaymentResponse.fromJson(Map<String, dynamic> json) {
    payUrl = json['pay_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pay_url'] = this.payUrl;
    return data;
  }
}
