part of 'logout_bloc.dart';

@freezed
class LogoutState with _$LogoutState {
  const factory LogoutState.initial() = _Initial;
  factory LogoutState.loading() = _Loading;
  factory LogoutState.success() = _Success;
  factory LogoutState.error(String error) = _Error;
}
