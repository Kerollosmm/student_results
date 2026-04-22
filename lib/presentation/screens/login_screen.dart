import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:e3dad_5odam/presentation/cubit/student_results_cubit.dart';
import 'package:e3dad_5odam/presentation/cubit/student_results_state.dart';
import 'package:e3dad_5odam/presentation/theme/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 450),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.border),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header
                  Container(
                    width: double.infinity,
                    color: AppColors.primary,
                    padding: const EdgeInsets.symmetric(
                      vertical: 32,
                      horizontal: 16,
                    ),
                    child: Column(
                      children: [
                        Image.asset('assets/logo_elkarooz.png', height: 100),
                        const SizedBox(height: 16),
                        const Text(
                          'مدرسة الكاروز لأعداد الخدام',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'منظومة النتائج',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'قم بتسجيل الدخول لمعرفة نتيجتك',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.background.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Form
                  Padding(
                    padding: EdgeInsets.all(
                      MediaQuery.of(context).size.width < 360 ? 20.0 : 32.0,
                    ),
                    child: BlocConsumer<StudentResultsCubit, StudentResultsState>(
                      listener: (context, state) {
                        if (state is StudentLoggedIn) {
                          context.go('/results');
                        }
                      },
                      builder: (context, state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              'اسم المستخدم',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textDark,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: _usernameController,
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.ltr,
                              decoration: InputDecoration(
                                hintText: 'أدخل اسم المستخدم',
                                hintStyle: const TextStyle(
                                  color: Colors.black38,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 16,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: AppColors.border,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: AppColors.border,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: AppColors.primary,
                                    width: 2,
                                  ),
                                ),
                              ),
                              onSubmitted: (_) {
                                context.read<StudentResultsCubit>().login(
                                  _usernameController.text,
                                  _passwordController.text,
                                );
                              },
                            ),
                            const SizedBox(height: 16),

                            const Text(
                              'كلمة المرور',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textDark,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: _passwordController,
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.ltr,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'أدخل كلمة المرور',
                                hintStyle: const TextStyle(
                                  color: Colors.black38,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 16,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: AppColors.border,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: AppColors.border,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: AppColors.primary,
                                    width: 2,
                                  ),
                                ),
                              ),
                              onSubmitted: (_) {
                                context.read<StudentResultsCubit>().login(
                                  _usernameController.text,
                                  _passwordController.text,
                                );
                              },
                            ),
                            const SizedBox(height: 16),

                            if (state is StudentResultsError)
                              Container(
                                padding: const EdgeInsets.all(12),
                                margin: const EdgeInsets.only(bottom: 16),
                                decoration: BoxDecoration(
                                  color: AppColors.failBg,
                                  border: Border.all(
                                    color: Colors.red.shade100,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.error_outline,
                                      color: AppColors.failText,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        state.message,
                                        style: const TextStyle(
                                          color: AppColors.failText,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            ElevatedButton(
                              onPressed: state is StudentResultsLoading
                                  ? null
                                  : () {
                                      if (_usernameController.text
                                              .trim()
                                              .isEmpty ||
                                          _passwordController.text.isEmpty) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'يرجى إدخال اسم المستخدم وكلمة المرور',
                                            ),
                                          ),
                                        );
                                        return;
                                      }
                                      context.read<StudentResultsCubit>().login(
                                        _usernameController.text,
                                        _passwordController.text,
                                      );
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                elevation: 0,
                              ),
                              child: state is StudentResultsLoading
                                  ? const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Text(
                                      'عرض النتيجة',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
