import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/model/catergory_model.dart';
import 'package:flutter/services.dart';

class ProductController extends GetxController{
  var quantity=0.obs;
  var colorIndex=0.obs;
  var totalprice=0.obs;
  var subcat=[];
  var fav=false.obs;
  getSubCategories(title)async{
    subcat.clear();
    var data=await rootBundle.loadString("lib/services/catergory_model.json");
    var decoded =catergoryModelFromJson(data);
    var s=decoded.catergories.where((element) => element.name==title).toList();
    for(var e in s[0].subcatergory){
      subcat.add(e);
    }
  }
  changeColorIndex(index){
    colorIndex=index;
  }
  increaseQuantity(totalQuantity){
    if(quantity.value<totalQuantity){
    quantity.value++;}
  }
  decreaseQuantity(){
    if(quantity.value>0){
      quantity.value--;
    }
  }
  calculateTotalPrice(price){
   totalprice.value= price*quantity.value;
  }
  addToCart({product_name,image,sellername,color,quantity,totalprice,context,vendorID})async{
    await firestore.collection(cartCollection).doc().set({
      'title':product_name,
      'image':image,
      'sellername':sellername,
      'color':color,
      'vendorId':vendorID,
      'quantity':quantity,
      'totalprice':totalprice,
      'added_by':currentUser!.uid
    }).catchError((error){
      VxToast.show(context, msg: error.toString());
    });

  }
  resetValues(){
    totalprice.value=0;
    quantity.value=0;
    colorIndex.value=0;
  }
  addToWishlist(docId,context)async{
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist':FieldValue.arrayUnion([currentUser!.uid])
    },SetOptions(merge: true));
    fav(true);
    VxToast.show(context, msg: "Added wishlist");
  }
  removeFromWishlist(docId,context)async{
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist':FieldValue.arrayRemove([currentUser!.uid])
    },SetOptions(merge: true));
    fav(false);
    VxToast.show(context, msg: "Remove wishlist");

  }
  checkIfFav(data)async{
    if(data['p_wishlist'].contains(currentUser!.uid)){
      fav(true);
    }else{
      fav(false);
    }
  }
}