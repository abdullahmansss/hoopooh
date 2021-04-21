import 'dart:io';

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoopooh_app/modules/signup/cubit/cubit.dart';
import 'package:hoopooh_app/modules/signup/cubit/states.dart';
import 'package:hoopooh_app/shared/components/compnents.dart';
import 'package:hoopooh_app/shared/components/constants.dart';
import 'package:hoopooh_app/shared/styles/colors.dart';
import 'package:hoopooh_app/shared/styles/size_config.dart';

class SignUpScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var fNameController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return BlocProvider(
      create: (BuildContext context) => SignUpScreenCubit(),
      child: BlocConsumer<SignUpScreenCubit, SignUpScreenStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          List errors = SignUpScreenCubit.get(context).errors;
          File image = SignUpScreenCubit.get(context).image;
          SignUpScreenCubit.get(context).context = context;

          return Scaffold(
            backgroundColor: kScaffoldColor,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              iconTheme: IconThemeData(color: Colors.black),
            ),
            body: ConditionalBuilder(
              condition: state is! SignUpScreenLoadingState,
              builder: (BuildContext context) => SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.02,
                      ),

                      Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(26),
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(5.0),
                      ),
                      Text(
                        'Complete your details or continue',
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(14),
                        ),
                      ),
                      Text(
                        'with social media',
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(14),
                        ),
                      ),
                      // SizedBox(
                      //   height: getProportionateScreenHeight(100.0),
                      // ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.02,
                      ),
                      InkWell(
                        onTap: () {
                          SignUpScreenCubit.get(context).pickImage();
                        },
                        child: CircleAvatar(
                          radius: getProportionateScreenWidth(50.0),
                          backgroundImage: (image != null)
                              ? FileImage(image)
                              : AssetImage(
                                  'assets/images/Profile Image.png',
                                ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.02,
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            defaultFormField(
                                validator: (String value) {
                                  if (value.isEmpty &&
                                      !errors.contains(kFNameNullError)) {
                                    SignUpScreenCubit.get(context)
                                        .addFNameNullError();
                                  }
                                  return null;
                                },
                                onChanged: (String value) {
                                  if (value.isNotEmpty &&
                                      errors.contains(kFNameNullError)) {
                                    SignUpScreenCubit.get(context)
                                        .removeFNameNullError();
                                  }
                                  return null;
                                },
                                controller: fNameController,
                                radius: 24.0,
                                labelText: 'Full Name',
                                hintText: 'Enter your name'),
                            SizedBox(
                              height: getProportionateScreenHeight(25.0),
                            ),
                            defaultFormField(
                                validator: (String value) {
                                  if (value.isEmpty &&
                                      !errors.contains(kEmailNullError)) {
                                    SignUpScreenCubit.get(context)
                                        .addEmailNullError();
                                  } else if (!emailValidatorRegExp
                                          .hasMatch(value) &&
                                      !errors.contains(kInvalidEmailError)) {
                                    SignUpScreenCubit.get(context)
                                        .addEmailNotValidError();
                                  }
                                  return null;
                                },
                                onChanged: (String value) {
                                  if (value.isNotEmpty &&
                                      errors.contains(kEmailNullError)) {
                                    SignUpScreenCubit.get(context)
                                        .removeEmailNullError();
                                  } else if (emailValidatorRegExp
                                          .hasMatch(value) &&
                                      errors.contains(kInvalidEmailError)) {
                                    SignUpScreenCubit.get(context)
                                        .removeEmailNotValidError();
                                  }
                                  return null;
                                },
                                type: TextInputType.emailAddress,
                                controller: emailController,
                                radius: 24.0,
                                labelText: 'Email',
                                hintText: 'Enter your email'),
                            SizedBox(
                              height: getProportionateScreenHeight(25.0),
                            ),
                            defaultFormField(
                                validator: (String value) {
                                  if (value.isEmpty &&
                                      !errors.contains(kPassNullError)) {
                                    SignUpScreenCubit.get(context)
                                        .addPassWordNullError();
                                  } else if (value.length < 6 &&
                                      !errors.contains(kShortPassError)) {
                                    SignUpScreenCubit.get(context)
                                        .addPasswordShortError();
                                  }
                                  return null;
                                },
                                onChanged: (String value) {
                                  if (value.isNotEmpty &&
                                      errors.contains(kPassNullError)) {
                                    SignUpScreenCubit.get(context)
                                        .removePassWordNullError();
                                  } else if (value.length >= 6 &&
                                      errors.contains(kShortPassError)) {
                                    SignUpScreenCubit.get(context)
                                        .removePasswordShortError();
                                  }
                                  return null;
                                },
                                type: TextInputType.visiblePassword,
                                controller: passwordController,
                                radius: 24.0,
                                labelText: 'Password ',
                                hintText: 'Enter your password',
                                isPassword: true),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(25.0),
                      ),

                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Account Type : '),
                            SizedBox(
                              width: 10.0,
                            ),
                            Container(
                              height: 40.0,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1.0),
                                borderRadius: BorderRadius.circular(5.0),
                                color: SignUpScreenCubit.get(context).radio[0]
                                    ? kPrimaryColor
                                    : Colors.transparent,
                              ),
                              child: FlatButton(
                                onPressed: () {
                                  SignUpScreenCubit.get(context).activeColor(0);
                                },
                                child: Text('Teacher'),
                              ),
                            ),
                            SizedBox(
                              width: 40.0,
                            ),
                            Container(
                              height: 40.0,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1.0),
                                borderRadius: BorderRadius.circular(5.0),
                                color: SignUpScreenCubit.get(context).radio[1]
                                    ? kPrimaryColor
                                    : Colors.transparent,
                              ),
                              child: FlatButton(
                                onPressed: () {
                                  SignUpScreenCubit.get(context).activeColor(1);
                                },
                                child: Text('Parent'),
                              ),
                            ),
                          ]),

                      SizedBox(
                        height: getProportionateScreenHeight(5.0),
                      ),
                      Column(
                        children: List.generate(
                          errors.length,
                          (index) => formErrorText(error: errors[index]),
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(10.0),
                      ),
                      defaultButton(
                          text: 'SignUp',
                          padding: 0.0,
                          function: () {
                            if (formKey.currentState.validate()) {
                              formKey.currentState.save();
                            }
                          },
                          radius: 24.0),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.02,
                      ),
                    ],
                  ),
                ),
              ),
              fallback: (ctx) => Stack(
                alignment: Alignment.center,
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: SizeConfig.screenHeight * 0.02,
                          ),

                          Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(26),
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(5.0),
                          ),
                          Text(
                            'Complete your details or continue',
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(14),
                            ),
                          ),
                          Text(
                            'with social media',
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(14),
                            ),
                          ),
                          // SizedBox(
                          //   height: getProportionateScreenHeight(100.0),
                          // ),
                          SizedBox(
                            height: SizeConfig.screenHeight * 0.02,
                          ),
                          InkWell(
                            onTap: () {
                              SignUpScreenCubit.get(context).pickImage();
                            },
                            child: CircleAvatar(
                              radius: getProportionateScreenWidth(50.0),
                              backgroundImage: (image != null)
                                  ? FileImage(image)
                                  : AssetImage(
                                'assets/images/Profile Image.png',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.screenHeight * 0.02,
                          ),
                          Form(
                            key: formKey,
                            child: Column(
                              children: [
                                defaultFormField(
                                    validator: (String value) {
                                      if (value.isEmpty &&
                                          !errors.contains(kFNameNullError)) {
                                        SignUpScreenCubit.get(context)
                                            .addFNameNullError();
                                      }
                                      return null;
                                    },
                                    onChanged: (String value) {
                                      if (value.isNotEmpty &&
                                          errors.contains(kFNameNullError)) {
                                        SignUpScreenCubit.get(context)
                                            .removeFNameNullError();
                                      }
                                      return null;
                                    },
                                    controller: fNameController,
                                    radius: 24.0,
                                    labelText: 'Full Name',
                                    hintText: 'Enter your name'),
                                SizedBox(
                                  height: getProportionateScreenHeight(25.0),
                                ),
                                defaultFormField(
                                    validator: (String value) {
                                      if (value.isEmpty &&
                                          !errors.contains(kEmailNullError)) {
                                        SignUpScreenCubit.get(context)
                                            .addEmailNullError();
                                      } else if (!emailValidatorRegExp
                                          .hasMatch(value) &&
                                          !errors.contains(kInvalidEmailError)) {
                                        SignUpScreenCubit.get(context)
                                            .addEmailNotValidError();
                                      }
                                      return null;
                                    },
                                    onChanged: (String value) {
                                      if (value.isNotEmpty &&
                                          errors.contains(kEmailNullError)) {
                                        SignUpScreenCubit.get(context)
                                            .removeEmailNullError();
                                      } else if (emailValidatorRegExp
                                          .hasMatch(value) &&
                                          errors.contains(kInvalidEmailError)) {
                                        SignUpScreenCubit.get(context)
                                            .removeEmailNotValidError();
                                      }
                                      return null;
                                    },
                                    type: TextInputType.emailAddress,
                                    controller: emailController,
                                    radius: 24.0,
                                    labelText: 'Email',
                                    hintText: 'Enter your email'),
                                SizedBox(
                                  height: getProportionateScreenHeight(25.0),
                                ),
                                defaultFormField(
                                    validator: (String value) {
                                      if (value.isEmpty &&
                                          !errors.contains(kPassNullError)) {
                                        SignUpScreenCubit.get(context)
                                            .addPassWordNullError();
                                      } else if (value.length < 6 &&
                                          !errors.contains(kShortPassError)) {
                                        SignUpScreenCubit.get(context)
                                            .addPasswordShortError();
                                      }
                                      return null;
                                    },
                                    onChanged: (String value) {
                                      if (value.isNotEmpty &&
                                          errors.contains(kPassNullError)) {
                                        SignUpScreenCubit.get(context)
                                            .removePassWordNullError();
                                      } else if (value.length >= 6 &&
                                          errors.contains(kShortPassError)) {
                                        SignUpScreenCubit.get(context)
                                            .removePasswordShortError();
                                      }
                                      return null;
                                    },
                                    type: TextInputType.visiblePassword,
                                    controller: passwordController,
                                    radius: 24.0,
                                    labelText: 'Password ',
                                    hintText: 'Enter your password',
                                    isPassword: true),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(25.0),
                          ),

                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Account Type : '),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Container(
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                    border:
                                    Border.all(color: Colors.grey, width: 1.0),
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: SignUpScreenCubit.get(context).radio[0]
                                        ? kPrimaryColor
                                        : Colors.transparent,
                                  ),
                                  child: FlatButton(
                                    onPressed: () {
                                      SignUpScreenCubit.get(context).activeColor(0);
                                    },
                                    child: Text('Teacher'),
                                  ),
                                ),
                                SizedBox(
                                  width: 40.0,
                                ),
                                Container(
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                    border:
                                    Border.all(color: Colors.grey, width: 1.0),
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: SignUpScreenCubit.get(context).radio[1]
                                        ? kPrimaryColor
                                        : Colors.transparent,
                                  ),
                                  child: FlatButton(
                                    onPressed: () {
                                      SignUpScreenCubit.get(context).activeColor(1);
                                    },
                                    child: Text('Parent'),
                                  ),
                                ),
                              ]),

                          SizedBox(
                            height: getProportionateScreenHeight(5.0),
                          ),
                          Column(
                            children: List.generate(
                              errors.length,
                                  (index) => formErrorText(error: errors[index]),
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(10.0),
                          ),
                          defaultButton(
                              text: 'SignUp',
                              padding: 0.0,
                              function: () {
                                if (formKey.currentState.validate()) {
                                  formKey.currentState.save();
                                }
                              },
                              radius: 24.0),
                          SizedBox(
                            height: SizeConfig.screenHeight * 0.02,
                          ),
                        ],
                      ),
                    ),
                  ),
                  CircularProgressIndicator(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
