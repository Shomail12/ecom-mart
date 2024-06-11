import 'package:emart_app/consts/consts.dart';

class FirestoreServices{
  //get user data
  static getUser(uid){
    return firestore.collection(usersCollection).where('id',isEqualTo: uid).snapshots();
  }
  static getProducts(category){
    return firestore.collection(productsCollection).where('p_category',isEqualTo:category).snapshots();
  }
  static getSubCategory(title){
    return firestore.collection(productsCollection).where('p_subcategory',isEqualTo:title).snapshots();
  }
  static getCart(uid){
    return firestore.collection(cartCollection).where('added_by',isEqualTo:uid).snapshots();
  }
  static deleteDocument(docId){
    return firestore.collection(cartCollection).doc(docId).delete();
  }
  static getChatMsg(docId){
    return firestore.collection(chatCollection).doc(docId).collection(messageCollection)
        .orderBy('created_on',descending: false).snapshots();
  }
  static getAllOrders(){
    return firestore.collection(ordersCollection).where('order_by',isEqualTo:currentUser!.uid).snapshots();
  }
  static getWishlist(){
    return firestore.collection(productsCollection).where('p_wishlist',arrayContains:currentUser!.uid ).snapshots();
  }
  static getAllMsgs(){
    return firestore.collection(chatCollection).where('fromId',isEqualTo:currentUser!.uid).snapshots();
  }
  static getCounts()async{
  var res=await Future.wait([
    firestore.collection(cartCollection).where('added_by',isEqualTo:currentUser!.uid).get().then((value) {
    return value.docs.length;
  }),
    firestore.collection(productsCollection).where('p_wishlist',isEqualTo:currentUser!.uid).get().then((value) {
      return value.docs.length;
    }),
    firestore.collection(ordersCollection).where('order_by',isEqualTo:currentUser!.uid).get().then((value) {
      return value.docs.length;
    }),
  ]);
  return res;

  }
  static allproducts(){
    return firestore.collection(productsCollection).snapshots();
  }
  static getFeaturedProducts(){
    return firestore.collection(productsCollection).where('isFeatured',isEqualTo:true
    ).get();
  }
  static searchProducts(title){
    return firestore.collection(productsCollection).where('p_name',isLessThanOrEqualTo: title).get();
  }

}