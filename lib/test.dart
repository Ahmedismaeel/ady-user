import 'package:equatable/equatable.dart';

class Test extends Equatable {
  final String? username;
  final String? password;

  Test({this.username, this.password});

  @override
  List<Object?> get props => [username, password];
}
