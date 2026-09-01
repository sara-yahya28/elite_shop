import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elite_shop/services/api_services.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final ApiService _apiService = ApiService();

  Future<void> login(String username, String password) async {
    // نعلن أن عملية تسجيل الدخول بدأت
    emit(LoginLoading());

    try {
      // نرسل البيانات إلى API
      final user = await _apiService.login(username, password);

      // إذا رجعت بيانات المستخدم
      if (user.isNotEmpty) {
        emit(LoginSuccess(user));
      } else {
        emit(LoginError('اسم المستخدم أو كلمة المرور غير صحيحة'));
      }
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}