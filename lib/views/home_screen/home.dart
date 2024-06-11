import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/homeController.dart';
import 'package:emart_app/services/services.dart';
import 'package:emart_app/views/catergories/itemDetails.dart';
import 'package:emart_app/views/homeButtons.dart';
import 'package:emart_app/views/home_screen/featuredButton.dart';
import 'package:emart_app/views/home_screen/search_screen.dart';
import 'package:emart_app/widgets/loading_indicator.dart';
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller=Get.find<HomeController>();
    return Container(padding: const EdgeInsets.all(12),
    color: lightGrey,
      width:context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(child: Column(
        children: [Container(
          alignment: Alignment.center,
          height: 60,
          color: lightGrey,
          child: TextFormField(controller: controller.searchController,
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: whiteColor,
              hintText:searchAnyThing,
              hintStyle: TextStyle(color: textfieldGrey),
              suffixIcon: Icon(Icons.search).onTap(() {
                Get.to(()=>SearchScreen(title:controller.searchController.text));
              })

            ),
          ),
        ),
          10.heightBox,

          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(children: [
                // First Swiper
                VxSwiper.builder(
                  aspectRatio: 16/9,
                  autoPlay: true,
                  height: 150,
                  enlargeCenterPage: true,
                  itemCount: slidersList.length, itemBuilder: (context,index){
                return Image.asset(
                  slidersList[index],
                  fit: BoxFit.fill,
                ).box.rounded.clip(Clip.antiAlias).margin(const EdgeInsets.symmetric(horizontal: 8)).make();

              }),
                10.heightBox,
                //First button list
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(2, (index) => homeButtons(
                    color: Colors.white,
                    height: context.screenHeight*0.12  ,
                    width: context.screenWidth/2.5,
                    icon:index==0?icTodaysDeal:icFlashDeal,
                    title:index==0?todayDeals:flashSale,

                  )),),
                //Second slider
                10.heightBox,
                VxSwiper.builder(
                    aspectRatio: 16/9,
                    autoPlay: true,
                    height: 150,
                    enlargeCenterPage: true,
                    itemCount: secondSliderList.length, itemBuilder: (context,index){
                  return Image.asset(
                    secondSliderList[index],
                    fit: BoxFit.fill,
                  ).box.rounded.clip(Clip.antiAlias).margin(const EdgeInsets.symmetric(horizontal: 8)).make();
                }),
                //homeButtons
                10.heightBox,
                //Second button list
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(3, (index) => homeButtons(
                    color: Colors.white,
                    height: context.screenHeight*0.12  ,
                    width: context.screenWidth/3.5,
                    icon:index==0?icTopCategories:index==1?icBrands:icTopSeller,
                    title:index==0?topCatergories:index==1?brand:topSellers,
                  )),),
                10.heightBox,
                //Featured Catergories
                Align(alignment: Alignment.centerLeft,
                    child: featuredCatergories.text.color(darkFontGrey).size(18).fontFamily(semibold).make()),
                10.heightBox,
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(3, (index) => Column(
                      children:[ FeaturedButton(
                        color: Colors.white,
                        height: context.screenHeight*0.12  ,
                        width: context.screenWidth/3.5,
                        icon:featuredimages1[index],
                        title:featuredTitles1[index],
                      ),
                        10.heightBox,
                        FeaturedButton(
                          color: Colors.white,
                          height: context.screenHeight*0.12  ,
                          width: context.screenWidth/3.5,
                          icon:featuredimages2[index],
                          title:featuredTitles2[index],
                        ),
                   ] )),),
                ),
                10.heightBox,
                //Product Featured
                Container(
                  padding: const EdgeInsets.all(12),
                  width: double.infinity,
                  decoration: BoxDecoration(color: redColor),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        featuredProduct.text.color(whiteColor).size(18).fontFamily(bold).make(),
                        10.heightBox,
                        FutureBuilder(
                          future: FirestoreServices.getFeaturedProducts(),
                          builder: (context,AsyncSnapshot<QuerySnapshot>snapshot){
                            if(!snapshot.hasData){
                              return Center(
                                child:  loadingIndicator(),
                              );
                            }

                             else if(snapshot.data!.docs.isEmpty){
                           return "No featured products".text.white.makeCentered();
                            }
                             else{
                               var featuredData=snapshot.data!.docs;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(featuredData.length, (index) => FeaturedProduct(
                                icon:featuredData[index]['p_images'][0],
                              title: featuredData[index]['p_name'],
                                price: featuredData[index]['p_price']

                            ).onTap(() {  Get.to(() =>
                                ItemDetail(
                                  title: featuredData[index]['p_name'],
                                  data: featuredData[index],)); }),),);}}
                        ),
                      ],
                    ),
                  ),
                ),

                10.heightBox,
                //third swiper
                VxSwiper.builder(
                    aspectRatio: 16/9,
                    autoPlay: true,
                    height: 150,
                    enlargeCenterPage: true,
                    itemCount: secondSliderList.length, itemBuilder: (context,index){
                  return Image.asset(
                    secondSliderList[index],
                    fit: BoxFit.fill,
                  ).box.rounded.clip(Clip.antiAlias).margin(const EdgeInsets.symmetric(horizontal: 8)).make();
                }),
                10.heightBox,
               Column(crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   "AllProduct".text.size(18).fontFamily(bold).make(),
                   8.heightBox,
                   //all product section
                   StreamBuilder(
                       stream: FirestoreServices.allproducts(),
                       builder: (BuildContext context,AsyncSnapshot <QuerySnapshot>snapshot){
                         if(!snapshot.hasData){
                           return Center(
                             child: loadingIndicator(),
                           );
                         }
                         else{
                           var allproductdata= snapshot.data!.docs;
                           print("Msg data ${allproductdata}");
                           return GridView.builder(
                               physics: const NeverScrollableScrollPhysics(),
                               shrinkWrap: true,
                               itemCount: allproductdata.length,
                               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent:200 ,mainAxisSpacing: 8,crossAxisSpacing: 8),
                               itemBuilder: (context,index){
                                 return Container(
                                   child: FeaturedProduct(

                                       icon:allproductdata[index]['p_images'][0],
                                       title: allproductdata[index]['p_name'],
                                       price: allproductdata[index]['p_price'],

                                   ).onTap(() {  Get.to(() =>
                                       ItemDetail(
                                         title: allproductdata[index]['p_name'],
                                         data: allproductdata[index],)); }),
                                 );
                               });
                         }}
                   )
                 ],
               ),


              ],),
            ),
          )

        ],
      ),),
    );
  }
}
