import 'package:go_router/go_router.dart';
import '../../features/results/domain/entities/student_result.dart';
import '../../features/results/presentation/screens/login_screen.dart';
import '../../features/results/presentation/screens/results_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/results',
      builder: (context, state) {
        final student = state.extra as StudentResult;
        return ResultsScreen(student: student);
      },
    ),
  ],
);
