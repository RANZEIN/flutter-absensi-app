import 'package:bloc/bloc.dart';
import 'package:flutter_absensi_app/data/datasources/attendance_remote_datasource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'is_checkedin_event.dart';
part 'is_checkedin_state.dart';
part 'is_checkedin_bloc.freezed.dart';

class IsCheckedinBloc extends Bloc<IsCheckedinEvent, IsCheckedinState> {
  final AttendanceRemoteDataSource dataSource;
  IsCheckedinBloc(this.dataSource) : super(const _Initial()) {
    on<_IsCheckedIn>((event, emit) async {
      emit(const _Loading());
      final result = await dataSource.isCheckedin();
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Success(r)),
      );
    });
  }
}
