import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:e3dad_5odam/domain/models/student_result.dart';
import 'package:e3dad_5odam/domain/models/subject.dart';
import 'package:e3dad_5odam/presentation/cubit/student_results_cubit.dart';
import 'package:e3dad_5odam/presentation/cubit/student_results_state.dart';
import 'package:e3dad_5odam/presentation/theme/app_colors.dart';
import 'package:e3dad_5odam/presentation/utils/pdf_helper.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  void _handlePrint(StudentResult student) {
    PdfHelper.generateAndPrint(student);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StudentResultsCubit, StudentResultsState>(
      listener: (context, state) {
        if (state is! StudentLoggedIn) {
          context.go('/');
        }
      },
      child: BlocBuilder<StudentResultsCubit, StudentResultsState>(
        builder: (context, state) {
          if (state is! StudentLoggedIn) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          final student = state.student;

          return Scaffold(
            backgroundColor: AppColors.background,
            body: LayoutBuilder(
              builder: (context, constraints) {
                final isMobile = constraints.maxWidth < 600;
                final isTablet =
                    constraints.maxWidth >= 600 && constraints.maxWidth < 1024;
                final isDesktop = constraints.maxWidth >= 1024;

                final horizontalPadding = isMobile
                    ? 16.0
                    : (isTablet ? 32.0 : 48.0);
                final contentMaxWidth = isDesktop
                    ? 1000.0
                    : (isTablet ? 800.0 : double.infinity);

                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: 32.0,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: contentMaxWidth),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Brand Header
                          Wrap(
                            alignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 20,
                            runSpacing: 16,
                            children: [
                              Image.asset(
                                'assets/logo_elkarooz.png',
                                height: isMobile ? 60 : 80,
                              ),
                              Text(
                                'مدرسة الكاروز لأعداد الخدام',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: isMobile ? 22 : 28,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),

                          // Header Actions
                          Wrap(
                            alignment: isMobile
                                ? WrapAlignment.center
                                : WrapAlignment.spaceBetween,
                            spacing: 12,
                            runSpacing: 12,
                            children: [
                              OutlinedButton.icon(
                                onPressed: () {
                                  context.read<StudentResultsCubit>().logout();
                                  context.go('/');
                                },
                                icon: const Icon(Icons.logout, size: 20),
                                label: const Text('تسجيل خروج'),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppColors.primary,
                                  side: const BorderSide(
                                    color: AppColors.primary,
                                    width: 1.5,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                              ),
                              ElevatedButton.icon(
                                onPressed: () => _handlePrint(student),
                                icon: const Icon(Icons.print, size: 20),
                                label: const Text('تصدير PDF'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  elevation: 2,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          const Divider(
                            color: AppColors.borderDarker,
                            thickness: 1,
                          ),
                          const SizedBox(height: 24),

                          // Student Info Card
                          Container(
                            padding: EdgeInsets.all(isMobile ? 20 : 32),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(color: AppColors.border),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.03),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Wrap(
                              spacing: 40,
                              runSpacing: 24,
                              children: [
                                SizedBox(
                                  width: isMobile ? double.infinity : null,
                                  child: _buildInfoItem(
                                    icon: Icons.person_outline,
                                    iconColor: AppColors.primary,
                                    label: 'اسم الطالب',
                                    value: student.name,
                                    isMobile: isMobile,
                                  ),
                                ),
                                SizedBox(
                                  width: isMobile ? double.infinity : null,
                                  child: _buildInfoItem(
                                    icon: Icons.menu_book_outlined,
                                    iconColor: AppColors.accent,
                                    label: 'المرحلة الدراسية',
                                    value: student.stage,
                                    isMobile: isMobile,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 32),

                          // Subjects Table
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(color: AppColors.border),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.02),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: const BoxDecoration(
                                    color: AppColors.surfaceLight,
                                    border: Border(
                                      bottom: BorderSide(
                                        color: AppColors.border,
                                      ),
                                    ),
                                  ),
                                  child: const Row(
                                    children: [
                                      Icon(
                                        Icons.emoji_events_outlined,
                                        color: AppColors.primary,
                                        size: 24,
                                      ),
                                      SizedBox(width: 12),
                                      Text(
                                        'تفاصيل المواد',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textDark,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Scrollbar(
                                  thumbVisibility: isMobile,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints(
                                        minWidth: (isMobile
                                            ? 500
                                            : constraints.maxWidth -
                                                  (horizontalPadding * 2)),
                                      ),
                                      child: DataTable(
                                        headingRowColor:
                                            WidgetStateProperty.all(
                                              AppColors.surfaceLight.withValues(
                                                alpha: 0.5,
                                              ),
                                            ),
                                        dataRowMinHeight: 65,
                                        dataRowMaxHeight: 65,
                                        horizontalMargin: 20,
                                        columnSpacing: isMobile ? 12 : 24,
                                        columns: [
                                          _buildDataColumn(
                                            'المادة',
                                            numeric: false,
                                          ),
                                          _buildDataColumn('حضور'),
                                          _buildDataColumn('إمتحان'),
                                          _buildDataColumn('إجمالي'),
                                          _buildDataColumn('نسبة %'),
                                          _buildDataColumn('التقدير'),
                                        ],
                                        rows: student.subjects
                                            .map(
                                              (subject) =>
                                                  _buildSubjectRow(subject),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 32),

                          // Total Score Footer
                          Container(
                            padding: const EdgeInsets.all(32),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: AppColors.borderDarker,
                                width: 1.5,
                              ),
                            ),
                            child: Wrap(
                              alignment: WrapAlignment.spaceBetween,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 32,
                              runSpacing: 24,
                              children: [
                                Column(
                                  crossAxisAlignment: isMobile
                                      ? CrossAxisAlignment.center
                                      : CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'النتيجة النهائية',
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.baseline,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: [
                                        Text(
                                          student.totalScore,
                                          style: TextStyle(
                                            fontSize: isMobile ? 40 : 48,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.textDark,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        const Text(
                                          '%',
                                          style: TextStyle(
                                            color: AppColors.accent,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: isMobile
                                      ? CrossAxisAlignment.center
                                      : CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'التقدير العام',
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 32,
                                        vertical: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.surfaceLight,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: AppColors.border,
                                        ),
                                      ),
                                      child: Text(
                                        student.totalGrade,
                                        style: TextStyle(
                                          fontSize: isMobile ? 20 : 24,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  DataColumn _buildDataColumn(String label, {bool numeric = true}) {
    return DataColumn(
      numeric: numeric,
      label: Text(
        label,
        style: const TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
    String? subValue,
    required bool isMobile,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: isMobile ? 44 : 56,
          height: isMobile ? 44 : 56,
          decoration: BoxDecoration(
            color: iconColor,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, color: Colors.white, size: isMobile ? 22 : 28),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: isMobile ? 18 : 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              if (subValue != null) ...[
                const SizedBox(height: 2),
                Text(
                  subValue,
                  style: TextStyle(fontSize: 13, color: AppColors.primary),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  DataRow _buildSubjectRow(Subject subject) {
    Color gradeBgColor = AppColors.neutralBg;
    Color gradeTextColor = AppColors.neutralText;

    if (subject.grade.contains('راسب')) {
      gradeBgColor = AppColors.failBg;
      gradeTextColor = AppColors.failText;
    } else if (subject.grade.contains('ممتاز') ||
        subject.grade.contains('جيد')) {
      gradeBgColor = AppColors.passBg;
      gradeTextColor = AppColors.passText;
    }

    // Clean percentage to avoid double % signs
    String displayPercentage = subject.percentage.replaceAll('%', '');

    return DataRow(
      cells: [
        DataCell(
          Text(
            subject.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
        ),
        DataCell(
          Text(
            subject.attendance,
            style: const TextStyle(color: AppColors.textDark),
          ),
        ),
        DataCell(
          Text(subject.exam, style: const TextStyle(color: AppColors.textDark)),
        ),
        DataCell(
          Text(
            subject.totalScore,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
        ),
        DataCell(
          Text(
            '$displayPercentage%',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: gradeBgColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              subject.grade,
              style: TextStyle(
                color: gradeTextColor,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
