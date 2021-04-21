import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoopooh_app/modules/inBoarding/cubit/cubit.dart';
import 'package:hoopooh_app/modules/inBoarding/cubit/states.dart';
import 'package:hoopooh_app/modules/login/login_screen.dart';
import 'package:hoopooh_app/shared/components/compnents.dart';
import 'package:hoopooh_app/shared/styles/colors.dart';
import 'package:hoopooh_app/shared/styles/size_config.dart';

class InBoardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    List<Map<String, String>> splashContent = [
      {
        "text": "Title1",
        "image": "assets/images/splash_1.png"
      },
      {
        "text":
        "Title2",
        "image": "assets/images/splash_2.png"
      },
      {
        "text": "Title3",
        "image": "assets/images/splash_3.png"
      }
    ];
    return BlocProvider(
      create: (BuildContext context) => InBoardingScreenCubit(),
      child: BlocConsumer<InBoardingScreenCubit, InBoardingScreenStates>(
        builder: (BuildContext context, state) {
          return Scaffold(
            backgroundColor: kScaffoldColor,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
            ),
            body: Padding(
              padding:  EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(15.0) , ),
              child: Column(
                children: [
                  Expanded(
                      flex: 3,
                      child: PageView.builder(
                        onPageChanged: (value) {
                          InBoardingScreenCubit.get(context).changePage(value);
                        },
                        itemCount: splashContent.length,
                        itemBuilder: (BuildContext context, int index) =>
                            splashContentItem(
                              flex: 2,
                              textContent: splashContent[index]['text'],
                              image: splashContent[index]['image'],
                            ),
                      )),

                  Expanded(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 15.0,
                        ),
                        Row(
                          children: List.generate(
                            splashContent.length,
                                (index) => buildDot(
                                index: index,
                                currentPage:
                                InBoardingScreenCubit.get(context).currentPage),
                          ),
                          mainAxisAlignment: MainAxisAlignment.start,
                        ),
                        Spacer(),
                        if (InBoardingScreenCubit.get(context).currentPage != 3)
                          FlatButton(
                            onPressed: () {
                              navigateAndFinish(context: context , route: LoginScreen());
                            },
                            child: Text(
                              (InBoardingScreenCubit.get(context).currentPage == 2) ?
                              'Finish' : 'Skip',
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(12),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        listener: (BuildContext context, state) {},
      ),
    );
  }
}