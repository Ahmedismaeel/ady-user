extension ForNullable on String? {
  String get s => this ?? "";
}

extension ForNullableInt on int? {
  String get s => this?.toString() ?? "0";
  int get i => this ?? 0;
}

extension ForNullabledouble on double? {
  String get s => this?.toStringAsFixed(2) ?? "0.00";
}
