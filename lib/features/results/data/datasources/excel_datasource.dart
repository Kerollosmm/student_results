import 'package:excel/excel.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@injectable
class ExcelDatasource {
  static const String assetPath = 'assets/data/student_results.xlsx';
  static const String sheetName = 'student_results_clean';

  Future<Map<String, dynamic>?> getStudentRow(String cardId) async {
    final bytes = await rootBundle.load(assetPath);
    final excel = Excel.decodeBytes(bytes.buffer.asUint8List());
    final sheet = excel.tables[sheetName];

    if (sheet == null) return null;

    final headers = sheet.rows[0].map((c) => c?.value?.toString() ?? '').toList();

    for (int i = 1; i < sheet.rows.length; i++) {
      final row = sheet.rows[i];
      final cardIdIdx = headers.indexOf('رقم الكارنيه');
      if (cardIdIdx == -1) continue;

      final rawValue = row[cardIdIdx]?.value?.toString() ?? '';
      final rowCardId = rawValue.replaceAll(RegExp(r'\.0$'), '');

      if (rowCardId == cardId) {
        final Map<String, dynamic> rowMap = {};
        for (int j = 0; j < headers.length; j++) {
          if (j < row.length) {
            rowMap[headers[j]] = row[j]?.value;
          }
        }
        return rowMap;
      }
    }
    return null;
  }
}
