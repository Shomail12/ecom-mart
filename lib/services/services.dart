import 'package:emart_app/consts/consts.dart';

class FirestoreServices{
  //get user data
  static getUser(uid){
    return firestore.collection(usersCollection).where('id',isEqualTo: uid).snapshots();
  }
  static getProducts(category){
    return firestore.collection(productsCollection).where('p_category',isEqualTo:category).snapshots();
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
    return firestore.collection(messageCollection).where('fromId',isEqualTo:currentUser!.uid).snapshots();
  }
}