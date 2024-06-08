import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/homeController.dart';
import 'package:emart_app/views/account/account.dart';
import 'package:emart_app/views/cart/cart.dart';
import 'package:emart_app/views/catergories/catergories.dart';
import 'package:emart_app/views/home_screen/home.dart';
import 'package:emart_app/widgets/exitDialog.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var controller=Get.put(HomeController());
    var navbarItem=[
      BottomNavigationBarItem(icon: Image.asset(icHome,width: 26,),label: home),
      BottomNavigationBarItem(icon: Image.asset(icCategories,width: 26,),label: catergories),
      BottomNavigationBarItem(icon: Image.asset(icCart,width: 26,),label: cart),
      BottomNavigationBarItem(icon: Image.asset(icProfile,width: 26,),label: account),
    ];
    var navbar=[const Home(),
      const Catergories(),
      const Cart(),
     const Account(),
    ];
    return WillPopScope(
      onWillPop: ()async{
        showDialog(context: context,
            barrierDismissible: false,
            builder: (context)=>exitDialog(context));
        return false;
    },
      child: Scaffold(
        body: Column(
          children: [
            Obx(()=> Expanded(child: navbar.elementAt(controller.currentNavIndex.value),)),
          ],
        ),
        bottomNavigationBar: Obx(()=>
           BottomNavigationBar(
             currentIndex: controller.currentNavIndex.value,
            selectedItemColor: redColor,
            selectedLabelStyle: const TextStyle(fontFamily: semibold),
            type: BottomNavigationBarType.fixed,
            backgroundColor: whiteColor ,
            items: navbarItem,
           onTap: (value){
               controller.currentNavIndex.value=value;
           },
           ),
        ),
      ),
    );
  }
}
