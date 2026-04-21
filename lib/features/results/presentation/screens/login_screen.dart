import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_theme.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LoginCubit>(),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _cardIdController = TextEditingController();

  @override
  void dispose() {
    _cardIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryGold,
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          state.maybeWhen(
            success: (student) => context.go('/results', extra: student),
            error: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message, textAlign: TextAlign.center),
                  backgroundColor: AppTheme.tertiaryError,
                ),
              );
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Card(
                elevation: 8,
                shadowColor: Colors.black12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 400),
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Hero(
                        tag: 'logo',
                        child: Image.asset(
                          'assets/logo_elkarooz.png',
                          height: 120,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                                Icons.church,
                                size: 80,
                                color: AppTheme.primaryGold,
                              ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        'نتائج الطلاب',
                        style: GoogleFonts.cairo(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.onSurfaceSoftBlack,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'أدخل رقم الكارنيه للاطلاع على نتيجتك',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.cairo(
                          fontSize: 16,
                          color: AppTheme.secondaryMetadata,
                        ),
                      ),
                      const SizedBox(height: 40),
                      TextField(
                        controller: _cardIdController,
                        keyboardType: TextInputType.number,
                        textDirection: TextDirection.rtl,
                        style: GoogleFonts.cairo(),
                        decoration: const InputDecoration(
                          labelText: 'رقم الكارنيه',
                          hintText: 'مثال: 1001',
                          prefixIcon: Icon(
                            Icons.badge_outlined,
                            color: AppTheme.primaryGold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: state.maybeWhen(
                            loading: () => null,
                            orElse: () => () {
                              context.read<LoginCubit>().login(
                                _cardIdController.text,
                              );
                            },
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryGold,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: state.maybeWhen(
                            loading: () => const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            ),
                            orElse: () => Text(
                              'عرض النتيجة',
                              style: GoogleFonts.cairo(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
