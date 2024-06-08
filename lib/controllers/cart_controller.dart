import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/homeController.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class CartController extends GetxController{
  var totalPrice=0.obs;
  //controllers for shipping details
  var addressController=TextEditingController();
  var cityController=TextEditingController();
  var stateController=TextEditingController();
  var postalController=TextEditingController();
  var phoneController=TextEditingController();
  var paymentIndex=0.obs;
  late dynamic productSnapshot;
  var products=[];
  var placingOrder=false.obs;

  calculate(data){
    totalPrice.value=0;
    for(var i=0;i<data.length;i++){
      totalPrice.value=totalPrice.value+int.parse(data[i]['totalprice'].toString());
    }
  }
changePaymentIndex(index){
    paymentIndex.value=index;
}
placeMyorder({required orderPaymentMethod,required totalAmount})async{
    await getProductDetail();
    placingOrder(true);
    await firestore.collection(ordersCollection).doc().set({
      'order_code':"233981237",
      'order_date':FieldValue.serverTimestamp(),
      'order_by':currentUser!.uid,
      'order_name':Get.find<HomeController>().username,
      'order_by_email':currentUser!.email,
      'order_by_address':addressController.text,
      'order_by_state':stateController.text,
      'order_by_city':cityController.text,
      'order_by_phone':phoneController.text,
      'order_by_postalcode':postalController.text,
      'shipping_method':"Home Delivery",
      'payment_method':orderPaymentMethod,
      'order_placed':true,
    'order_confrimed':false,
    'order_Delivered':false,
    'order_on_delivery':false,
      'total_amount':totalAmount,
      'orders':FieldValue.arrayUnion(products)

    });
    placingOrder(false);
}
getProductDetail(){
    products.clear();
    for(var i=0;i<productSnapshot.length;i++){
      products.add({
        'color':productSnapshot[i]['color'],
        'img':productSnapshot[i]['image'],
        'qty':productSnapshot[i]['quantity'],
        'totalPrice':productSnapshot[i]['totalprice'],
        'title':productSnapshot[i]['title'],
        'vendorID':productSnapshot[i]['vendorId']
      });
    }
    print("Products ${products}");
}
clearCart(){
    for(var i=0;i<productSnapshot.length;i++){
      firestore.collection(cartCollection).doc(productSnapshot[i].id).delete();
    }
}
}