import 'package:e3dad_5odam/domain/models/student_result.dart';

abstract class StudentResultsState {}

class StudentResultsInitial extends StudentResultsState {}

class StudentResultsLoading extends StudentResultsState {}

class StudentResultsLoaded extends StudentResultsState {
  final List<StudentResult> students;
  StudentResultsLoaded(this.students);
}

class StudentResultsError extends StudentResultsState {
  final String message;
  StudentResultsError(this.message);
}

class StudentLoggedIn extends StudentResultsState {
  final StudentResult student;
  StudentLoggedIn(this.student);
}
