
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/authController.dart';
import 'package:emart_app/controllers/cart_controller.dart';
import 'package:emart_app/controllers/profile_Controller.dart';
import 'package:emart_app/services/services.dart';
import 'package:emart_app/views/account/detail_card.dart';
import 'package:emart_app/views/account/edit_profile.dart';
import 'package:emart_app/views/auth_screen/login_screen.dart';
import 'package:emart_app/views/messages/messages.dart';
import 'package:emart_app/views/order_screen/order_screen.dart';
import 'package:emart_app/views/wishlist.dart';
import 'package:emart_app/widgets/bg_widget.dart';
class Account extends StatelessWidget {
  const Account({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller=Get.put(ProfileController());

    return bgWidget(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirestoreServices.getUser(currentUser!.uid),
        builder:(BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return const Center(
              child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(redColor),
              ),
              );
    }
            else{
              var data=snapshot.data!.docs[0];
              return SafeArea(child:
              Column(children: [
              // edit profile buttone
              Align(
              alignment:Alignment.topRight,
              child: const Icon(Icons.edit,color: Colors.white,)).onTap(() {
                controller.nameController.text=data['name'];
                Get.offAll(()=> EditProfile(data: data));}),
              //user detail section
              Row(
              children: [
              data['imageUrl']==''?
                Image.asset(imgProfile2 ,width: 100,fit:BoxFit.cover).box.roundedFull.clip(Clip.antiAlias).make()
              :                  Image.network(data['imageUrl'] ,width: 100,fit:BoxFit.cover).box.roundedFull.clip(Clip.antiAlias).make()

                ,  Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    "${data['name']}".text.fontFamily(semibold).white.make(),
    5.heightBox,
      "${data['email']}".text.white.make(),
    ],
    )),
    OutlinedButton(
    style: OutlinedButton.styleFrom(
    side:const BorderSide(
    color: Colors.white
    )
    ),
    onPressed: ()async{
    await Get.put(AuthController()).signoutMethod();
    Get.offAll(()=>const LoginScreen());
    }, child:
    "Logout".text.fontFamily(semibold).white.make())
    ],
    ),

    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
    detailCard(
    width: context.screenWidth/3.6,
   count: "${data['cart_count']}",
    title: "in your cart"
    ),
    detailCard(
    width: context.screenWidth/3.6,
        count: "${data['order_count']}",
    title: "in your wishlist"
    ), detailCard(
    width: context.screenWidth/3.6,

    count: "${data['wishlist_count']}",
    title: "in your orders"
    )
    ],
    ),
    //profilebuttons
    ListView.separated(
    shrinkWrap: true,
    itemBuilder: (BuildContext context,int index){
    return ListTile(onTap:(){
      switch(index){
        case 0:
          Get.to(()=>const OrderScreen());
          break;
        case 1:
          Get.to(()=>const Wishlist());
          break;
        case 2:
          Get.to(()=>const MessagesScreen());
          break;
      }
    },
    leading: Image.asset(profileButtonIcon[index],width: 22,),
    title: profileButtonList[index].text.fontFamily(semibold).color(darkFontGrey).make(),
    );

    }, separatorBuilder: (context,index){
    return const Divider(color: lightGrey,);
    }, itemCount: profileButtonList.length
    ).box.white.rounded.margin(EdgeInsets.all(12)).padding(EdgeInsets.symmetric(horizontal: 16)).shadowSm.make().box.color(redColor).make()
    ],),);
    }
    }
      ),
    ));
  }
}
