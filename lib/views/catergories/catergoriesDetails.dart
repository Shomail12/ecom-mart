import 'package:emart_app/consts/consts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/controllers/product_controller.dart';
import 'package:emart_app/services/services.dart';
import 'package:emart_app/views/catergories/itemDetails.dart';
import 'package:emart_app/views/home_screen/featuredButton.dart';
import 'package:emart_app/widgets/bg_widget.dart';
import 'package:emart_app/widgets/loading_indicator.dart';
class CatergoriesDetails extends StatelessWidget {
  final String? title;
  const CatergoriesDetails({Key? key,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller=Get.find<ProductController>();
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: title!.text.fontFamily(bold).make(),
        ),
        body:StreamBuilder(
          stream: FirestoreServices.getProducts(title),
          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return Center(
                child: loadingIndicator(),
              );
            }
            else if(snapshot.data!.docs.isEmpty){
              return Center(
                child: "No Product Found".text.color(darkFontGrey).make(),
              );
            }
            else{
              var data= snapshot.data!.docs;
              return  Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    width: double.infinity,
                    decoration: BoxDecoration(color: redColor),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(controller.subcat.length
                              , (index) => "${controller.subcat[index]}".text.fontFamily(semibold).color(darkFontGrey)
                                  .makeCentered()
                                  .box
                                  .white.rounded
                                  .size(120,60).margin(const EdgeInsets.symmetric(horizontal: 4)).padding(const EdgeInsets.all(4)).make()

                          )),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: lightGrey,
                      padding: EdgeInsets.all(12),
                      child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: data.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2 ,mainAxisSpacing: 8,crossAxisSpacing: 8,mainAxisExtent: 200),
                          itemBuilder:   (context,index){
                            return  AllProduct(

                                icon:data[index]['p_images'][0],
                                title:"${data[index]['p_name']}",
                                price: "${data[index]['p_price']}".numCurrency

                            ).onTap(() {
                              controller.checkIfFav(data[index]);
                              Get.to(()=>ItemDetail(title: "${data[index]['p_name']}",data: data[index],));});
                          }),),
                  ),
                ],
              );
            }
          },
        )
        /* Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(color: redColor),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(controller.subcat.length
                      , (index) => "${controller.subcat[index]}".text.fontFamily(semibold).color(darkFontGrey)
                      .makeCentered()
                      .box
                      .white.rounded
                      .size(120,60).margin(const EdgeInsets.symmetric(horizontal: 4)).padding(const EdgeInsets.all(4)).make()

                  )),
              ),
            ),
            Expanded(
              child: Container(
                color: lightGrey,
                padding: EdgeInsets.all(12),
                child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: 6,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2 ,mainAxisSpacing: 8,crossAxisSpacing: 8,mainAxisExtent: 200),
                    itemBuilder:   (context,index){
                      return  AllProduct(

                          icon:featuredProductimages[index],
                          title: featuredProductTitle[index],
                          price: featuredProductPrice[index]

                      ).onTap(() {Get.to(()=>ItemDetail(title: featuredProductTitle[index],));});
                    }),),
            ),
          ],
        ),*/
      )
    );
  }
}
