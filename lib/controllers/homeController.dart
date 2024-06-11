import 'package:emart_app/consts/consts.dart';
class HomeController extends GetxController{
  void onInit(){
    getUsername();
    super.onInit();
  }
  var currentNavIndex=0.obs;
  var username='';
  var password='';
  var order_count='';
  var searchController=TextEditingController();

  getUsername()async{
    var n= await firestore.collection(usersCollection).where('id',isEqualTo: currentUser!.uid).get().then((value) {
      if(value.docs.isNotEmpty){
        return value.docs.single['name'];
      }
    });
    username=n;
    print(username);
    /* await firestore.collection(usersCollection).where('id',isEqualTo: currentUser!.uid).get().then((value) {
      if(value.docs.isNotEmpty){
         password= value.docs.single['password'];
         order_count= value.docs.single['order_count'];
      }
    });

    print(password);
    print("Order_count ${order_count}");*/
  }

}