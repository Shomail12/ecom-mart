import 'package:emart_app/consts/consts.dart';

Widget OurButton({onPres,color,textColor,String? title}){
  return  ElevatedButton(style: ElevatedButton.styleFrom(
    primary: color,
    padding: const EdgeInsets.all(12)
  ),
      onPressed: onPres, child: title!.text.color(textColor).fontFamily(bold).make());
}