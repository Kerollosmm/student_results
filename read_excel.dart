// ignore_for_file: avoid_print
import 'dart:io';
import 'package:excel/excel.dart';

void main() {
  var file = "assets/data/student_results.xlsx";
  var bytes = File(file).readAsBytesSync();
  var excel = Excel.decodeBytes(bytes);

  var sheet = excel.tables.keys.first;
  var table = excel.tables[sheet]!;

  print('Sheet: $sheet');
  print('Max Rows: ${table.maxRows}');

  if (table.maxRows > 0) {
    var headerRow = table.rows.first;
    for (int i = 0; i < headerRow.length; i++) {
      final cell = headerRow[i];
      if (cell != null) {
        print('Header $i: ${cell.value}');
      }
    }
  }
}
