import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repositories/results_repository.dart';
import 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final ResultsRepository _repository;

  LoginCubit(this._repository) : super(const LoginState.initial());

  Future<void> login(String cardId) async {
    if (cardId.isEmpty) {
      emit(const LoginState.error('يرجى إدخال رقم الكارنيه'));
      return;
    }

    emit(const LoginState.loading());
    try {
      final result = await _repository.getStudentByCardId(cardId.trim());
      if (result != null) {
        emit(LoginState.success(result));
      } else {
        emit(const LoginState.error('رقم الكارنيه غير صحيح، حاول مرة أخرى'));
      }
    } catch (e) {
      emit(LoginState.error('حدث خطأ أثناء تحميل البيانات: $e'));
    }
  }

  void reset() {
    emit(const LoginState.initial());
  }
}
