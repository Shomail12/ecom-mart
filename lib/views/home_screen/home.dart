import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/homeButtons.dart';
import 'package:emart_app/views/home_screen/featuredButton.dart';
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.all(12),
    color: lightGrey,
      width:context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(child: Column(
        children: [Container(
          alignment: Alignment.center,
          height: 60,
          color: lightGrey,
          child: TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: whiteColor,
              hintText:searchAnyThing,
              hintStyle: TextStyle(color: textfieldGrey),
              suffixIcon: Icon(Icons.search)

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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(6, (index) => FeaturedProduct(
                              icon:featuredProductimages[index],
                            title: featuredProductTitle[index],
                              price: featuredProductPrice[index]

                          )),),
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

                //all product section
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 6,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent:200 ,mainAxisSpacing: 8,crossAxisSpacing: 8),
                    itemBuilder: (context,index){
                return Container(
                child: FeaturedProduct(

                    icon:featuredProductimages[index],
                    title: featuredProductTitle[index],
                    price: featuredProductPrice[index]

                ),
                );
                })
              ],),
            ),
          )

        ],
      ),),
    );
  }
}
