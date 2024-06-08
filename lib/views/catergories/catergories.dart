import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/product_controller.dart';
import 'package:emart_app/views/catergories/catergoriesDetails.dart';
import 'package:emart_app/views/home_screen/featuredButton.dart';
import 'package:emart_app/widgets/bg_widget.dart';
class Catergories extends StatelessWidget {
  const Catergories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller=Get.put(ProductController());
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: catergories.text.fontFamily(bold).white.make(),
        ),
        body: Container(padding: EdgeInsets.all(12),
        child: GridView.builder(
          shrinkWrap: true,
            itemCount: 9,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3 ,mainAxisSpacing: 8,crossAxisSpacing: 8,mainAxisExtent: 200),
            itemBuilder:   (context,index){
            return Column(
              children: [Image.asset(CatergoriesImage[index],height: 120,width: 200,fit: BoxFit.cover,),
                "${CatergoriesList[index]}".text.color(darkFontGrey).align(TextAlign.center).make()

              ],


            ).box.white.rounded.clip(Clip.antiAlias).outerShadowSm.make().onTap(() {
              controller.getSubCategories(CatergoriesList[index]);
              Get.to(()=>CatergoriesDetails(title: CatergoriesList[index],));});
            }),),
      )
    );
  }
}
