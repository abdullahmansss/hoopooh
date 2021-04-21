import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoopooh_app/modules/login/cubit/states.dart';
import 'package:hoopooh_app/shared/components/constants.dart';

class LoginScreenCubit extends Cubit<LoginScreenStates> {
  LoginScreenCubit() : super(LoginScreenInitialState());

  static LoginScreenCubit get(context) => BlocProvider.of(context);
  List errors = [];
  bool remember = false;

  BuildContext context;

  void addEmailNullError() {
    errors.add(kEmailNullError);
    emit(LoginScreenAddEmailErrorState());
  }

  void addPassWordNullError() {
    errors.add(kPassNullError);
    emit(LoginScreenAddPasswordErrorState());
  }

  void addEmailNotValidError() {
    errors.add(kInvalidEmailError);
    emit(LoginScreenAddEmailErrorState());
  }

  void addPasswordShortError() {
    errors.add(kShortPassError);
    emit(LoginScreenAddPasswordErrorState());
  }

  void removeEmailNullError() {
    errors.remove(kEmailNullError);
    emit(LoginScreenAddEmailErrorState());
  }

  void removePassWordNullError() {
    errors.remove(kPassNullError);
    emit(LoginScreenAddPasswordErrorState());
  }

  void removeEmailNotValidError() {
    errors.remove(kInvalidEmailError);
    emit(LoginScreenAddEmailErrorState());
  }

  void removePasswordShortError() {
    errors.remove(kShortPassError);
    emit(LoginScreenAddPasswordErrorState());
  }

  void changeCheck(value) {
    remember = value;
    emit(LoginScreenRememberState());
  }

}
