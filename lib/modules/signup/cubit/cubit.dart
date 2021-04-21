

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoopooh_app/modules/signup/cubit/states.dart';
import 'package:hoopooh_app/shared/components/constants.dart';
import 'package:image_picker/image_picker.dart';

class SignUpScreenCubit extends Cubit<SignUpScreenStates>
{
  SignUpScreenCubit() : super(SignUpScreenInitialState());
  static SignUpScreenCubit get (context) => BlocProvider.of(context);
  List errors = [];
  BuildContext context ;
  File image;
  List<bool> radio = [
    false ,
    false,
  ];

  Future<void> pickImage() async {
    await ImagePicker().getImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        image = File(value.path);
        emit(SignUpScreenPickImageState());

        print(value.path);

      }
    });
  }
  void addEmailNullError()
  {
    errors.add(kEmailNullError);
    emit(SignUpScreenAddEmailErrorState());
  }
  void addFNameNullError()
  {
    errors.add(kFNameNullError);
    emit(SignUpScreenAddFNameErrorState());
  }
  void addLNameNullError()
  {
    errors.add(kPhoneNullError);
    emit(SignUpScreenAddLNameErrorState());
  }
  void addPassWordNullError()
  {
    errors.add(kPassNullError);
    emit(SignUpScreenAddPasswordErrorState());
  }
  void addEmailNotValidError()
  {
    errors.add(kInvalidEmailError);
    emit(SignUpScreenAddEmailErrorState());
  }
  void addPasswordShortError()
  {
    errors.add(kShortPassError);
    emit(SignUpScreenAddPasswordErrorState());
  }
  void removeEmailNullError()
  {
    errors.remove(kEmailNullError);
    emit(SignUpScreenRemoveEmailErrorState());
  }
  void removeFNameNullError()
  {
    errors.remove(kFNameNullError);
    emit(SignUpScreenRemoveFNameErrorState());
  }
  void removeLNameNullError()
  {
    errors.remove(kPhoneNullError);
    emit(SignUpScreenRemoveLNameErrorState());
  }
  void removePassWordNullError()
  {
    errors.remove(kPassNullError);
    emit(SignUpScreenRemovePasswordErrorState());
  }
  void removeEmailNotValidError()
  {
    errors.remove(kInvalidEmailError);
    emit(SignUpScreenRemoveEmailErrorState());
  }
  void removePasswordShortError()
  {
    errors.remove(kShortPassError);
    emit(SignUpScreenRemovePasswordErrorState());
  }
  void activeColor(int index)
  {
    for (int i = 0; i < radio.length; i++) {
      if (i == index) {
        radio[i] = true;
      } else {
        radio[i] = false;
      }
    }

    emit(SignUpScreenActiveColorState());
  }



}