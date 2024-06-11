import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/catergories/catergoriesDetails.dart';

Widget FeaturedButton({width,height,icon, String? title,onPress,color}){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(icon,width: 60,fit: BoxFit.fill,),
      5.heightBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],).box.width(200).margin(const EdgeInsets.symmetric(horizontal: 4)).padding(const EdgeInsets.all(4)).roundedSM.outerShadowSm.color(color).make().onTap(() {
      Get.to(() =>
  CatergoriesDetails(
  title: title,)); });
}
Widget FeaturedProduct({width,height,icon, String? title,onPress,color,String? price}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(color: Colors.purple,
          child: Image.network(icon,width: 180,
            height: 130,
            fit: BoxFit.cover,)),
      10.heightBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make(),
      5.heightBox,
      price!.text.fontFamily(bold).color(redColor).make(),
    ],).box.padding(const EdgeInsets.all(8)).margin(const EdgeInsets.symmetric(horizontal: 4)).roundedSM.color(Colors.white).make();
}
Widget AllProduct({width,height,icon, String? title,onPress,color,String? price}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(color: Colors.purple,
          child: Image.network(icon,width: 150,height:150,fit: BoxFit.cover,)),

      title!.text.fontFamily(semibold).color(darkFontGrey).make(),
      10.heightBox,
      price!.text.fontFamily(bold).color(redColor).make(),
    ],).box.padding(const EdgeInsets.all(4)).margin(const EdgeInsets.symmetric(horizontal: 8)).roundedSM.color(Colors.white).make();
}