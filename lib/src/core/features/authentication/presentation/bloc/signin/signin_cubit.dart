import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/datasources/auth_repo.dart';
import '../../../data/models/custom_error.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  final AuthRepository authRepository;
  SigninCubit({required this.authRepository}) : super(SigninState.initial());

  Future<void> signin({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(signinStatus: SigninStatus.submitting));

    try {
      await authRepository.signin(email: email, password: password);

      emit(state.copyWith(signinStatus: SigninStatus.success));
    } on CustomError catch (e) {
      emit(
        state.copyWith(
          signinStatus: SigninStatus.error,
          error: e,
        ),
      );
    }
  }
}
