import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hoopooh_app/shared/styles/colors.dart';
import 'package:hoopooh_app/shared/styles/size_config.dart';

void navigateTo ({context , route })
{
  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => route));
}
void navigateAndFinish({context, route}) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => route,
    ),
        (Route<dynamic> route) => false);
Widget splashContentItem ({@required textContent  ,@required image , flex = 2}) => Column(
  children: [

    SizedBox(height: getProportionateScreenHeight(20.0),),
    Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Hoopooh' , style: TextStyle(
              color: kPrimaryColor,
              fontSize: getProportionateScreenWidth(32),
            ),),
            SizedBox(height: getProportionateScreenHeight(10.0),),
            Text(textContent , style: TextStyle(
              fontSize: getProportionateScreenWidth(20.0),
              fontWeight: FontWeight.w400,
            ),textAlign: TextAlign.center,),
          ],
        ),
      ),
    ),
    Expanded(
        flex: flex,
        child: Image.asset(image,)),
    SizedBox(height: 10.0,),
  ],
);
Widget buildDot({@required index , currentPage}) =>  AnimatedContainer(
  height: 6.0,
  width: currentPage == index ? 30.0 : 6.0,
  margin: EdgeInsetsDirectional.only(end: 5.0),
  decoration: BoxDecoration(
    color: currentPage == index ? kPrimaryColor : Colors.grey[300],
    borderRadius: BorderRadius.circular(3.0),
  ), duration: Duration(milliseconds: 250),
);
Widget defaultButton ({padding  , radius , text , function}) =>   Padding(
  padding:  EdgeInsets.symmetric(horizontal: padding),
  child: Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: kPrimaryColor,

      borderRadius: BorderRadius.circular(radius),
    ),
    child: FlatButton(onPressed: function, child: Text(text , style: TextStyle(
      color: Colors.white,
    ),),),
  ),
);
Widget defaultFormField({type , controller ,labelText  , radius ,validator , onChanged , hintText , isPassword = false}) =>  TextFormField(
  keyboardType: type,
  onChanged: onChanged,
  validator: validator,
  decoration: InputDecoration(
    contentPadding: EdgeInsets.all(18.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(radius,),),
    labelText: labelText,
    hintText: hintText ,



  ),
  obscureText: isPassword,
  controller: controller,
);
void showToast({@required text, isError = false}) => Fluttertoast.showToast(
    msg: text.toString(),
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: isError ? Colors.red : Colors.grey[400],
    textColor: Colors.black,
    fontSize: 16.0);
Widget formErrorText ({@required error}) =>  Padding(
  padding:  EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
  child:   Row(
    children: [
      SvgPicture.asset('assets/icons/Error.svg' , height: getProportionateScreenHeight(14), width: getProportionateScreenWidth(14),),
      SizedBox(width: getProportionateScreenWidth(10)),
      Text(error),
    ],
  ),
);
Widget socialItem({icon , function}) =>   GestureDetector(
  onTap: function,
  child: Container(
    padding: EdgeInsets.all(getProportionateScreenWidth(8)),
    child:
    SvgPicture.asset(icon ,),
    height: getProportionateScreenHeight(40),
    width: getProportionateScreenWidth(40),
    decoration: BoxDecoration(
      shape: BoxShape.circle ,
      color: Colors.grey[200],
    ),
  ),
);