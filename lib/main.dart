import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:e3dad_5odam/injection.dart';
import 'package:e3dad_5odam/presentation/cubit/student_results_cubit.dart';
import 'package:e3dad_5odam/presentation/screens/login_screen.dart';
import 'package:e3dad_5odam/presentation/screens/results_screen.dart';
import 'package:e3dad_5odam/presentation/theme/app_colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const MyApp());
}

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const LoginScreen()),
    GoRoute(
      path: '/results',
      builder: (context, state) => const ResultsScreen(),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<StudentResultsCubit>()..loadData(),
      child: MaterialApp.router(
        title: 'منظومة النتائج',
        debugShowCheckedModeBanner: false,
        routerConfig: _router,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ar', 'EG'), // Arabic, Egypt
        ],
        locale: const Locale('ar', 'EG'),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          useMaterial3: true,
          textTheme: GoogleFonts.cairoTextTheme(Theme.of(context).textTheme),
          scaffoldBackgroundColor: AppColors.background,
        ),
      ),
    );
  }
}
