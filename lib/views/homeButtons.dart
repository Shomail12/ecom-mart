import 'package:emart_app/consts/consts.dart';

Widget homeButtons({width,height,icon, String? title,onPress,color}){
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(color: color,
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),

    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      Image.asset(icon,width: 26,),
      5.heightBox,
title!.text.fontFamily(semibold).color(darkFontGrey).make()
    ],),
  );
}