import 'package:flutter_test/flutter_test.dart';
import 'package:e3dad_5odam/data/repositories/excel_repository.dart';
import 'package:e3dad_5odam/presentation/cubit/student_results_cubit.dart';
import 'package:e3dad_5odam/presentation/cubit/student_results_state.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('Test ExcelRepository parsing and loading', () async {
    final repository = ExcelRepository();
    final students = await repository.getStudents();
    
    print('Loaded students count: ${students.length}');
    if (students.isNotEmpty) {
      print('First student: id=${students.first.id}, name=${students.first.name}, username=${students.first.username}, password=${students.first.password}');
    }
    
    expect(students.isNotEmpty, true);
    expect(students.first.id, isNot('ERROR'));
  });

  test('Test StudentResultsCubit login flow with valid credentials', () async {
    final repository = ExcelRepository();
    final cubit = StudentResultsCubit(repository);
    
    // We expect the first student to be STU133498 / 5365
    await cubit.login('STU133498', '5365');
    
    print('Cubit state after login: ${cubit.state}');
    expect(cubit.state, isA<StudentLoggedIn>());
  });
}
