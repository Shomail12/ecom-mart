import 'package:emart_app/consts/consts.dart';

Widget detailCard({ width,String?count,String?title}){
  return  Column(children: [
    count!.text.fontFamily(bold).color(darkFontGrey).size(16).make(),
    5.heightBox,
    title!.text.color(darkFontGrey).make(),
  ],).box.white.rounded.width(width).height(50).padding(const EdgeInsets.all(4)).make();

}