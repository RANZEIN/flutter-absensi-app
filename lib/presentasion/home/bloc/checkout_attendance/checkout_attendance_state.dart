part of 'checkout_attendance_bloc.dart';

@freezed
class CheckoutAttendanceState with _$CheckoutAttendanceState {
  const factory CheckoutAttendanceState.initial() = _Initial;
  factory CheckoutAttendanceState.loading() = _Loading;
  factory CheckoutAttendanceState.loaded(
      CheckInOutResponseModel responseModel) = _Loaded;
  factory CheckoutAttendanceState.error(String message) = _Error;
}
