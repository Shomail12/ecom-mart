import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/product_controller.dart';
import 'package:emart_app/views/chat_screen/chat_screen.dart';
import 'package:emart_app/views/home_screen/featuredButton.dart';
import 'package:emart_app/widgets/our_button.dart';
class ItemDetail extends StatelessWidget {
  final String? title;
  final dynamic data;
   const ItemDetail({Key? key,required this.title,this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("vendor id=${data['vendor_id']}");
    // final controller=Get.find<ProductController>();
    final ProductController controller = Get.put(ProductController());
    return WillPopScope(
      onWillPop:()async{
        controller.resetValues();
        return true;
      }, child:Scaffold(
      bottomNavigationBar:  SizedBox(
          width: double.infinity,
          height: 65,
          child:    OurButton(color: redColor,textColor: whiteColor,title: "Add to Cart",onPres: (){
            controller.addToCart(
                color: data['p_color'][controller.colorIndex.value],
                context: context,
                image: data['p_images'][0],
                vendorID: data['vendor_id'],
                quantity: controller.quantity.value,
                sellername: data['p_seller'],
                product_name: data['p_name'],
                totalprice: controller.totalprice.value
            );
            VxToast.show(context, msg: "Added to Cart");
          })),
        backgroundColor: lightGrey,
        appBar: AppBar(

leading: IconButton(
  onPressed: (){
      controller.resetValues();
      Get.back();
  },
  icon: const Icon(Icons.arrow_back),
),        title:  title!.text.fontFamily(bold).color(redColor).make(),
          iconTheme: IconThemeData(
            color: darkFontGrey
          ),
          actions: [
            IconButton(onPressed: (){}, icon: const Icon(Icons.share,color: darkFontGrey,)),
            Obx(()=> IconButton(onPressed: (){
                if(controller.fav.value){
                  controller.removeFromWishlist(data.id,context);

                }else{
                  controller.addToWishlist(data.id,context);

                }
              }, icon: Icon(Icons.favorite_border_outlined,
                color:
                controller.fav.value ?redColor: darkFontGrey,)),
            ),
          ],
        ),
        body: Column(
          children: [Expanded(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  //Image
                  VxSwiper.builder(autoPlay: true,
                itemCount:  data["p_images"].length,
                  height: 350,
                  aspectRatio: 16/9,
                  viewportFraction: 1.0,
                  itemBuilder: (context,index){
                  return Image.network(data['p_images'][index],
                  width: double.infinity,
                  fit: BoxFit.cover,);
                  },
                ),
                  10.heightBox,
                  //name
                  title!.text.size(16).fontFamily(bold).color(darkFontGrey).make(),
                  10.heightBox,
                  //rationg
                  VxRating(value: double.parse(data['p_rating']),
isSelectable: false,
                    onRatingUpdate: (value){},
                    normalColor: textfieldGrey,
                    selectionColor: golden,
                    count: 5,
                    size: 25,
                    stepInt: true,
                    maxRating: 5,

                  ),
                  10.heightBox,
                  //price
                  "${data['p_price']}".numCurrency.text.size(18).fontFamily(bold).color(redColor).make(),
                  10.heightBox,
                  //message
                  Row(
                    children: [Expanded(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    "Seller".text.fontFamily(semibold).make(),
                    5.heightBox,
                    "${data['p_seller']}".text.fontFamily(semibold).make(),

                  ],),
                  ),
                  const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.message,color: darkFontGrey,),
                  ).onTap(() {Get.to(()=>  ChatScreen(),
                 arguments: [data['p_seller'],data['vendor_id']]
                     // arguments: ["sellername","vendor_id"]
                  );})
                  ],).box.height(60).color(textfieldGrey).padding(const EdgeInsets.symmetric(horizontal: 16)).make(),
        20.heightBox,
                  Obx(()=>
                     Column(children: [
                      //colors
                      Row(children: [
                      SizedBox(
                        width: 100,
                        child: "Color ".text.size(18).fontFamily(bold).color(textfieldGrey).make(),
                      ),
                      Row(children:  List.generate(data['p_color'].length, (index) =>
                          Stack(
                            alignment: Alignment.center,
                            children:[ VxBox().roundedFull.color(Color(data['p_color'][index]).withOpacity(1.0)).size(40, 40)
                            .margin(const EdgeInsets.symmetric(horizontal: 6,vertical: 4)).make().onTap(() {controller.changeColorIndex(index); }),
                              Visibility(
                                  visible: index==controller.colorIndex.value,
                                  child: const Icon(Icons.done,color: Colors.white,))
                         ] )
                       // List.generate(3, (index) => VxBox().size(40, 40).roundedFull.color(Vx.randomPrimaryColor).make())
                      ) ,)
                    ],).box.padding(const EdgeInsets.all(8)).make(),
                      //minus,add
                      Obx(()=>
                         Row(children: [
                          SizedBox(
                            width: 100,
                            child: "Quantity ".text.size(18).fontFamily(bold).color(textfieldGrey).make(),
                          ),
                          Row(children: [IconButton(onPressed: (){ controller.decreaseQuantity();
                          controller.calculateTotalPrice(int.parse(data['p_price']));},
                              icon: const Icon(Icons.remove)),
                            controller.quantity.value.text.size(16).fontFamily(bold).color(darkFontGrey).make(),] ,),
                          IconButton(onPressed: (){
                            controller.increaseQuantity(int.parse(data['p_quantity']));
                            controller.calculateTotalPrice(int.parse(data['p_price']));
                          }, icon: const Icon(Icons.add)),
                          10.widthBox,
                          "(${data['p_quantity']} avaiable)".text.size(16).fontFamily(bold).color(textfieldGrey).make()
                        ],).box.padding(const EdgeInsets.all(8)).make(),
                      ),
                      //total
                      Container(color:lightRedColor,
                        child: Row(children: [
                          SizedBox(
                            width: 100,
                            child: "Total ".text.size(18).fontFamily(bold).color(textfieldGrey).make(),
                          ),

                          10.widthBox,
                          "${controller.totalprice.value}".numCurrency.text.size(16).fontFamily(bold).color(redColor).make()
                        ],).box.padding(const EdgeInsets.all(8)).make(),
                      )
        ],).box.white.shadowSm.make(),
                  ),
                  10.heightBox,
                  "Description".text.fontFamily(semibold).color(darkFontGrey).make(),
                  "${data['p_description']}".text.fontFamily(semibold).color(darkFontGrey).make(),
10.heightBox,
// Video
                ListView(
                  shrinkWrap: true,
                  children: List.generate(5, (index) => ListTile(
                  title:itemDetailsButton[index].text.fontFamily(semibold).color(darkFontGrey).make(),
                    trailing: const Icon(Icons.arrow_forward),

                )),),
                  productYouMayLike.text.size(16).fontFamily(bold).color(darkFontGrey).make(),
                  10.heightBox,
                  //other product list
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(3, (index) => Column(
                          children:[ FeaturedProduct(
                              icon:featuredProductimages[index],
                              title: featuredProductTitle[index],
                              price: featuredProductPrice[index]

                          ),


                          ] )),),
                  ),
                ] ),
            ),
          )),

          ],

        ),

      ),
    );
  }
}
