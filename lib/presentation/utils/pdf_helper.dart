import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:e3dad_5odam/domain/models/student_result.dart';

class PdfHelper {
  static Future<void> generateAndPrint(StudentResult student) async {
    final pdf = pw.Document();

    // Load Arabic font
    final arabicFont = await PdfGoogleFonts.cairoRegular();
    final arabicFontBold = await PdfGoogleFonts.cairoBold();

    // Load logo if available
    pw.MemoryImage? logo;
    try {
      final logoData = await rootBundle.load('assets/logo_elkarooz.png');
      logo = pw.MemoryImage(logoData.buffer.asUint8List());
    } catch (e) {
      // ignore
    }

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        theme: pw.ThemeData.withFont(base: arabicFont, bold: arabicFontBold),
        build: (pw.Context context) {
          return pw.Container(
            padding: const pw.EdgeInsets.all(30),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.amber800, width: 2),
            ),
            child: pw.Container(
              padding: const pw.EdgeInsets.all(20),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.amber400, width: 1),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  // Logo and Header
                  if (logo != null) pw.Image(logo, width: 90, height: 90),
                  pw.SizedBox(height: 15),
                  pw.Text(
                    'مدرسة الكاروز لإعداد الخدام',
                    style: pw.TextStyle(
                      fontSize: 26,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.amber900,
                    ),
                  ),
                  pw.Text(
                    'كنيسة القديس مارمرقس الرسول - كليوباترا',
                    style: const pw.TextStyle(fontSize: 14, color: PdfColors.grey700),
                  ),
                  pw.SizedBox(height: 30),
                  
                  pw.Text(
                    'بيان درجات أكاديمي',
                    style: pw.TextStyle(
                      fontSize: 22,
                      fontWeight: pw.FontWeight.bold,
                      decoration: pw.TextDecoration.underline,
                    ),
                  ),
                  pw.SizedBox(height: 40),

                  // Student Info Box
                  pw.Container(
                    width: double.infinity,
                    padding: const pw.EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                    decoration: pw.BoxDecoration(
                      color: PdfColors.amber50,
                      borderRadius: const pw.BorderRadius.all(pw.Radius.circular(15)),
                    ),
                    child: pw.Column(
                      children: [
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Expanded(
                              child: pw.Text(
                                'الاسم: ${student.name}',
                                style: pw.TextStyle(
                                  fontSize: 20,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColors.black,
                                ),
                                textDirection: pw.TextDirection.rtl,
                              ),
                            ),
                            pw.SizedBox(width: 20),
                            pw.Text(
                              'رقم الكارنيه: ${student.id}',
                              style: const pw.TextStyle(fontSize: 16),
                              textDirection: pw.TextDirection.rtl,
                            ),
                          ],
                        ),
                        pw.SizedBox(height: 15),
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
                  pw.SizedBox(height: 40),

                  // Table Header
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    children: [
                      pw.Text(
                        'تفاصيل التقييم الأكاديمي',
                        style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 15),

                  // Table
                  pw.Table(
                    border: pw.TableBorder.all(color: PdfColors.amber200),
                    columnWidths: {
                      0: const pw.FlexColumnWidth(2),
                      1: const pw.FlexColumnWidth(1.2),
                      2: const pw.FlexColumnWidth(1),
                      3: const pw.FlexColumnWidth(1),
                      4: const pw.FlexColumnWidth(1),
                      5: const pw.FlexColumnWidth(4.5),
                    },
                    children: [
                      pw.TableRow(
                        decoration: const pw.BoxDecoration(color: PdfColors.amber100),
                        children: [
                          _tableHeader('التقدير'),
                          _tableHeader('نسبة %'),
                          _tableHeader('إجمالي'),
                          _tableHeader('إمتحان'),
                          _tableHeader('حضور'),
                          _tableHeader('المادة'),
                        ],
                      ),
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
                  pw.SizedBox(height: 40),

                  // Result Footer
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      // Official stamp placeholder
                      pw.Column(
                        children: [
                          pw.Text('ختم المدرسة', style: const pw.TextStyle(fontSize: 12, color: PdfColors.grey500)),
                          pw.SizedBox(height: 50),
                        ],
                      ),
                      
                      // Overall result box
                      pw.Container(
                        padding: const pw.EdgeInsets.all(20),
                        decoration: pw.BoxDecoration(
                          color: PdfColors.amber800,
                          borderRadius: const pw.BorderRadius.all(pw.Radius.circular(12)),
                        ),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.end,
                          children: [
                            pw.Text(
                              'النتيجة النهائية: ${student.totalScore}%',
                              style: pw.TextStyle(
                                fontSize: 20,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.white,
                              ),
                            ),
                            pw.SizedBox(height: 8),
                            pw.Text(
                              'التقدير العام: ${student.totalGrade}',
                              style: pw.TextStyle(
                                fontSize: 22,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  pw.Spacer(),
                  
                  // Encouraging message
                  pw.Text(
                    'مع تمنياتنا بدوام التوفيق والنجاح في خدمة كنيستنا المقدسة',
                    style: pw.TextStyle(
                      fontSize: 14,
                      fontWeight: pw.FontWeight.normal,
                      fontStyle: pw.FontStyle.italic,
                      color: PdfColors.grey800,
                    ),
                  ),
                  pw.SizedBox(height: 10),
                ],
              ),
            ),
          );
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
      padding: const pw.EdgeInsets.all(5),
      alignment: align == pw.TextAlign.right
          ? pw.Alignment.centerRight
          : pw.Alignment.center,
      child: pw.Text(
        text,
        textAlign: align,
        style: pw.TextStyle(
          fontSize: 10,
          color: textColor,
          fontWeight: isGrade ? pw.FontWeight.bold : pw.FontWeight.normal,
        ),
      ),
    );
  }
}
