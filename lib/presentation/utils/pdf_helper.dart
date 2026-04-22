import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:e3dad_5odam/domain/models/student_result.dart';

class PdfHelper {
  static Future<void> generateAndPrint(StudentResult student) async {
    final pdf = pw.Document();

    // Load Arabic font (using Almarai instead of Cairo to prevent clipping of final 'ي')
    final arabicFont = await PdfGoogleFonts.almaraiRegular();
    final arabicFontBold = await PdfGoogleFonts.almaraiBold();

    // Load logo if available
    pw.MemoryImage? logo;
    try {
      final logoData = await rootBundle.load('assets/logo_elkarooz.png');
      logo = pw.MemoryImage(logoData.buffer.asUint8List());
    } catch (e) {
      // ignore
    }

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        theme: pw.ThemeData.withFont(base: arabicFont, bold: arabicFontBold),
        textDirection: pw.TextDirection.rtl,
        build: (pw.Context context) {
          return [
            // Header
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                if (logo != null) pw.Image(logo, width: 80, height: 80),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text(
                      'نتائج الطلاب',
                      style: pw.TextStyle(
                        fontSize: 24,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      'إعداد خدام - مدرسة الكاروز',
                      style: pw.TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 20),
            pw.Divider(),
            pw.SizedBox(height: 20),

            // Student Info
            pw.Container(
              padding: const pw.EdgeInsets.all(15),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.grey300),
                borderRadius: const pw.BorderRadius.all(pw.Radius.circular(10)),
              ),
              child: pw.Column(
                children: [
                  pw.Row(
                    children: [
                      pw.Expanded(
                        child: pw.Text(
                          'اسم الطالب: ${student.name}',
                          style: pw.TextStyle(
                            fontSize: 18,
                            fontWeight: pw.FontWeight.bold,
                          ),
                          textDirection: pw.TextDirection.rtl,
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  pw.Row(
                    children: [
                      pw.Expanded(
                        child: pw.Text(
                          'المرحلة الدراسية: ${student.stage}',
                          style: const pw.TextStyle(fontSize: 16),
                          textDirection: pw.TextDirection.rtl,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 20),

            // Table Header
            pw.Text(
              'تفاصيل المواد',
              style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 10),

            // Table
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.grey400),
              columnWidths: {
                0: const pw.FlexColumnWidth(2),
                1: const pw.FlexColumnWidth(1.2),
                2: const pw.FlexColumnWidth(1),
                3: const pw.FlexColumnWidth(1),
                4: const pw.FlexColumnWidth(1),
                5: const pw.FlexColumnWidth(
                  6,
                ), // Increased significantly to prevent truncation
              },
              children: [
                // Header Row
                pw.TableRow(
                  decoration: const pw.BoxDecoration(color: PdfColors.grey200),
                  children: [
                    _tableHeader('التقدير'),
                    _tableHeader('نسبة %'),
                    _tableHeader('إجمالي'),
                    _tableHeader('إمتحان'),
                    _tableHeader('حضور'),
                    _tableHeader('المادة'),
                  ],
                ),
                // Data Rows
                ...student.subjects.map(
                  (s) => pw.TableRow(
                    children: [
                      _tableCell(s.grade, isGrade: true),
                      _tableCell(s.percentage),
                      _tableCell(s.totalScore),
                      _tableCell(s.exam),
                      _tableCell(s.attendance),
                      _tableCell(s.name, align: pw.TextAlign.right),
                    ],
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 30),

            // Footer / Total
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.end,
              children: [
                pw.Container(
                  padding: const pw.EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: pw.BoxDecoration(
                    color: PdfColors.grey100,
                    border: pw.Border.all(color: PdfColors.grey400),
                    borderRadius: const pw.BorderRadius.all(
                      pw.Radius.circular(5),
                    ),
                  ),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(
                        'النتيجة النهائية: ${student.totalScore} %',
                        style: pw.TextStyle(
                          fontSize: 18,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(height: 5),
                      pw.Text(
                        'التقدير العام: ${student.totalGrade}',
                        style: pw.TextStyle(
                          fontSize: 18,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.blue900,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ];
        },
      ),
    );

    // Save or Print
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
      name: 'نتيجة_${student.name}.pdf',
    );
  }

  static pw.Widget _tableHeader(String text) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(5),
      child: pw.Text(
        text,
        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
        textAlign: pw.TextAlign.center,
      ),
    );
  }

  static pw.Widget _tableCell(
    String text, {
    pw.TextAlign align = pw.TextAlign.center,
    bool isGrade = false,
  }) {
    PdfColor textColor = PdfColors.black;
    PdfColor? bgColor;

    if (isGrade) {
      if (text.contains('ممتاز') ||
          text.contains('جيد جدا') ||
          text.contains('جيد')) {
        textColor = PdfColor.fromInt(0xFF047857); // AppColors.passText
        bgColor = PdfColor.fromInt(0xFFECFDF5); // AppColors.passBg
      } else if (text.contains('راسب')) {
        textColor = PdfColor.fromInt(0xFFB91C1C); // AppColors.failText
        bgColor = PdfColor.fromInt(0xFFFEF2F2); // AppColors.failBg
      }
    }

    return pw.Container(
      color: bgColor,
      padding: const pw.EdgeInsets.symmetric(horizontal: 2, vertical: 5),
      alignment: align == pw.TextAlign.right
          ? pw.Alignment.centerRight
          : pw.Alignment.center,
      child: pw.Text(
        text,
        textAlign: align,
        textDirection: pw.TextDirection.rtl,
        style: pw.TextStyle(
          fontSize: 10,
          color: textColor,
          fontWeight: isGrade ? pw.FontWeight.bold : pw.FontWeight.normal,
        ),
      ),
    );
  }
}
