import 'package:injectable/injectable.dart';
import '../../domain/entities/student_result.dart';
import '../../domain/repositories/results_repository.dart';
import '../datasources/excel_datasource.dart';
import '../models/student_result_model.dart';

@Injectable(as: ResultsRepository)
class ResultsRepositoryImpl implements ResultsRepository {
  final ExcelDatasource _datasource;

  ResultsRepositoryImpl(this._datasource);

  @override
  Future<StudentResult?> getStudentByCardId(String cardId) async {
    final row = await _datasource.getStudentRow(cardId);
    if (row == null) return null;
    return StudentResultModel.fromExcelRow(row);
  }
}
