import '../entities/student_result.dart';

abstract class ResultsRepository {
  Future<StudentResult?> getStudentByCardId(String cardId);
}
