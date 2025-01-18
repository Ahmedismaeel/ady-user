import 'package:freezed_annotation/freezed_annotation.dart';

part 'submit_status.freezed.dart';

@freezed
abstract class SubmitState<T> with _$SubmitState<T> {
  factory SubmitState() = _SubmitState;
  const factory SubmitState.initial() = _Initial;
  const factory SubmitState.loading() = _Loading;
  const factory SubmitState.success({required T response}) = _Success;
  const factory SubmitState.failed({required String message}) = _Failed;
}
