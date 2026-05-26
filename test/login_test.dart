import 'package:flutter_test/flutter_test.dart';
import 'package:e3dad_5odam/data/repositories/excel_repository.dart';
import 'package:e3dad_5odam/presentation/cubit/student_results_cubit.dart';
import 'package:e3dad_5odam/presentation/cubit/student_results_state.dart';
import 'package:e3dad_5odam/domain/models/student_result.dart';
import 'package:e3dad_5odam/domain/models/subject.dart';

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

  group('StudentResult Grading Tests', () {
    test('Uses the original totalGrade passed directly', () {
      final student = StudentResult(
        id: '1',
        name: 'Test Student',
        stage: 'Stage 1',
        subjects: [
          Subject(name: 'S1', attendance: '30', exam: '30', totalScore: '60', percentage: '60%', grade: 'مقبول'),
          Subject(name: 'S2', attendance: '30', exam: '30', totalScore: '60', percentage: '60%', grade: 'مقبول'),
          Subject(name: 'S3', attendance: '10', exam: '10', totalScore: '20', percentage: '20%', grade: 'راسب'),
          Subject(name: 'S4', attendance: '10', exam: '10', totalScore: '20', percentage: '20%', grade: 'راسب'),
          Subject(name: 'S5', attendance: '10', exam: '10', totalScore: '20', percentage: '20%', grade: 'راسب'),
        ],
        totalScore: '55',
        totalGrade: 'مقبول',
        username: 'user',
        password: 'pwd',
      );

      expect(student.totalGrade, 'مقبول');
    });

    test('Uses the original totalGrade passed directly for passing case', () {
      final studentGood = StudentResult(
        id: '2',
        name: 'Test Student 2',
        stage: 'Stage 1',
        subjects: [
          Subject(name: 'S1', attendance: '30', exam: '30', totalScore: '60', percentage: '60%', grade: 'مقبول'),
          Subject(name: 'S2', attendance: '30', exam: '30', totalScore: '60', percentage: '60%', grade: 'مقبول'),
          Subject(name: 'S3', attendance: '30', exam: '30', totalScore: '60', percentage: '60%', grade: 'مقبول'),
          Subject(name: 'S4', attendance: '10', exam: '10', totalScore: '20', percentage: '20%', grade: 'راسب'),
          Subject(name: 'S5', attendance: '10', exam: '10', totalScore: '20', percentage: '20%', grade: 'راسب'),
        ],
        totalScore: '70',
        totalGrade: 'جيد',
        username: 'user',
        password: 'pwd',
      );

      expect(studentGood.totalGrade, 'جيد');
    });
  });
}
