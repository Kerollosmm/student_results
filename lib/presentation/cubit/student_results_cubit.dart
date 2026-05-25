import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e3dad_5odam/data/repositories/excel_repository.dart';
import 'package:e3dad_5odam/presentation/cubit/student_results_state.dart';

class StudentResultsCubit extends Cubit<StudentResultsState> {
  final ExcelRepository _repository;

  StudentResultsCubit(this._repository) : super(StudentResultsInitial());

  Future<void> loadData() async {
    emit(StudentResultsLoading());
    try {
      final students = await _repository.getStudents();
      emit(StudentResultsLoaded(students));
    } catch (e, st) {
      // ignore: avoid_print
      print('loadData error: $e\n$st');
      emit(StudentResultsError('خطأ في تحميل البيانات: $e'));
    }
  }

  Future<void> login(String username, String password) async {
    emit(StudentResultsLoading());
    try {
      final students = await _repository.getStudents();
      final student = students.where(
        (s) =>
            s.username.toLowerCase() == username.trim().toLowerCase() &&
            s.password == password.trim(),
      ).firstOrNull;

      if (student != null) {
        emit(StudentLoggedIn(student));
      } else {
        emit(StudentResultsError('اسم المستخدم أو كلمة المرور غير صحيح'));
      }
    } catch (e, st) {
      // ignore: avoid_print
      print('login error: $e\n$st');
      emit(StudentResultsError('خطأ: $e'));
    }
  }

  Future<void> logout() async {
    try {
      final students = await _repository.getStudents();
      emit(StudentResultsLoaded(students));
    } catch (e) {
      emit(StudentResultsInitial());
    }
  }
}
