import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:screenshot/screenshot.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/file_saver.dart'
    if (dart.library.html) '../../../../core/utils/file_saver_web.dart'
    if (dart.library.io) '../../../../core/utils/file_saver_mobile.dart';
import '../../domain/entities/student_result.dart';
import '../../domain/entities/subject_result.dart';

class ResultsScreen extends StatefulWidget {
  final StudentResult student;
  const ResultsScreen({super.key, required this.student});

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  final ScreenshotController _screenshotController = ScreenshotController();
  bool _isCapturing = false;

  Future<void> _saveAsImage() async {
    setState(() => _isCapturing = true);

    try {
      final uint8list = await _screenshotController.capture(
        delay: const Duration(milliseconds: 100),
        pixelRatio: 2.0,
      );

      if (uint8list != null) {
        if (!mounted) return;
        final saver = getFileSaver();
        await saver.saveAndShare(
          uint8list,
          'result_${widget.student.cardId}.png',
          'نتيجة الطالب: ${widget.student.name}',
        );
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تم حفظ النتيجة بنجاح')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('حدث خطأ أثناء حفظ الصورة: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isCapturing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surfaceParchment,
      appBar: AppBar(
        title: Text(
          'بوابة النتائج الأكاديمية',
          style: GoogleFonts.ibmPlexSansArabic(
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryGold,
          ),
        ),
        actions: [
          if (!_isCapturing)
            IconButton(
              icon: const Icon(Icons.share_outlined),
              onPressed: _saveAsImage,
              tooltip: 'حفظ كصورة',
            )
          else
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(color: AppTheme.primaryGold, strokeWidth: 2),
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Screenshot(
          controller: _screenshotController,
          child: Container(
            color: AppTheme.surfaceParchment,
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildBackButton(),
                const SizedBox(height: 24),
                _buildHeroBanner(),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(child: _buildInfoCard('المواد المكتملة', '١٢ / ١٢')),
                    const SizedBox(width: 16),
                    Expanded(child: _buildInfoCard('الترتيب العام', '#٠٤', subtitle: 'على الدفعة')),
                  ],
                ),
                const SizedBox(height: 48),
                Text(
                  'تفاصيل المواد الدراسية',
                  style: GoogleFonts.ibmPlexSansArabic(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.onSurfaceSoftBlack,
                  ),
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 16),
                ...widget.student.subjects.map((s) => _buildSubjectCard(s)),
                const SizedBox(height: 48),
                _buildOfficialNotice(),
                const SizedBox(height: 64),
                _buildFooter(),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return InkWell(
      onTap: () => context.go('/'),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'العودة للوحة التحكم',
            style: GoogleFonts.ibmPlexSansArabic(
              color: AppTheme.onSurfaceSoftBlack,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_forward, size: 18, color: AppTheme.primaryGold),
        ],
      ),
    );
  }

  Widget _buildHeroBanner() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0052D4), Color(0xFF4364F7), Color(0xFF6FB1FC)],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppTheme.ambientShadow,
      ),
      padding: const EdgeInsets.all(32),
      child: Stack(
        children: [
          Positioned(
            left: -20,
            bottom: -20,
            child: Icon(Icons.school, size: 150, color: Colors.white.withAlpha(20)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'FINAL RESULT 2024',
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white.withAlpha(180),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'نتيجة إعداد خدام',
                style: GoogleFonts.ibmPlexSansArabic(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    widget.student.overallDegrees?.split('/')[0] ?? '94.8',
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white,
                      fontSize: 64,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '%',
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white.withAlpha(180),
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(51),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  widget.student.overallGrade ?? '—',
                  style: GoogleFonts.ibmPlexSansArabic(color: Colors.white, fontSize: 14),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, {String? subtitle}) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppTheme.ambientShadow,
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.ibmPlexSansArabic(
              color: AppTheme.secondaryMetadata,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: value.startsWith('#') ? AppTheme.primaryGold : AppTheme.onSurfaceSoftBlack,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(width: 8),
                Text(
                  subtitle,
                  style: GoogleFonts.ibmPlexSansArabic(
                    color: AppTheme.secondaryMetadata,
                    fontSize: 14,
                  ),
                ),
              ]
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectCard(SubjectResult subject) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppTheme.ambientShadow,
      ),
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subject.name,
                    style: GoogleFonts.ibmPlexSansArabic(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.onSurfaceSoftBlack,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'مستوى المادة: أكاديمي',
                    style: GoogleFonts.ibmPlexSansArabic(
                      fontSize: 13,
                      color: AppTheme.secondaryMetadata,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.gradeColor(subject.grade).withAlpha(30),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Text(
                  subject.grade ?? '—',
                  style: GoogleFonts.ibmPlexSansArabic(
                    color: AppTheme.gradeColor(subject.grade),
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Editorial Stat Grid (No Borders)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatItem('حضور', subject.attendance),
              _buildStatItem('إمتحان', subject.exam),
              _buildStatItem('إجمالي', subject.totalDegrees, isBold: true),
              _buildStatItem(
                'النسبة',
                subject.totalPercent != null ? '${(subject.totalPercent! * 100).round()}%' : null,
                isGold: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, dynamic value, {bool isBold = false, bool isGold = false}) {
    return Column(
      children: [
        Text(
          label,
          style: GoogleFonts.ibmPlexSansArabic(
            color: AppTheme.secondaryMetadata,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value?.toString() ?? '—',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: isBold || isGold ? FontWeight.bold : FontWeight.w600,
            color: isGold ? AppTheme.primaryGold : AppTheme.onSurfaceSoftBlack,
          ),
        ),
      ],
    );
  }

  Widget _buildOfficialNotice() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF0F4FF),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.verified_user_outlined, color: Color(0xFF4364F7), size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'إشعار الاعتماد الأكاديمي',
                  style: GoogleFonts.ibmPlexSansArabic(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'هذه النتائج مستخرجة آلياً من الأرشيف الرقمي المعتمد. أي كشط أو تعديل في هذه البيانات يلغي صلاحيتها القانونية والأكاديمية.',
                  style: GoogleFonts.ibmPlexSansArabic(
                    fontSize: 12,
                    color: AppTheme.secondaryMetadata,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        Hero(
          tag: 'logo',
          child: Image.asset(
            'assets/logo_elkarooz.png',
            height: 90,
            errorBuilder: (context, error, stackTrace) => const SizedBox(),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'كنيسة القديس مارمرقس الرسول - كليوباترا',
          style: GoogleFonts.ibmPlexSansArabic(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppTheme.onSurfaceSoftBlack,
          ),
        ),
        Text(
          'مدرسة الكاروز لإعداد الخدام',
          style: GoogleFonts.ibmPlexSansArabic(
            fontSize: 12,
            color: AppTheme.secondaryMetadata,
          ),
        ),
      ],
    );
  }
}
