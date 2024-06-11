import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/services/services.dart';
import 'package:emart_app/views/catergories/itemDetails.dart';
import 'package:emart_app/widgets/loading_indicator.dart';

class SearchScreen extends StatelessWidget {
  final String? title;
  const SearchScreen({Key? key,this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(title: title!.text.color(darkFontGrey).make(),),
      body: FutureBuilder(
          future: FirestoreServices.searchProducts(title),
          builder: (context,AsyncSnapshot<QuerySnapshot>snapshot){
            if(!snapshot.hasData){
              return Center(
                child:  loadingIndicator(),
              );
            }

            else if(snapshot.data!.docs.isEmpty){
              return "No products found".text.white.makeCentered();
            }
            else {
              var data = snapshot.data!.docs;
              var filtered=data.where((element) => element['p_name'].toString().toLowerCase()
                  .contains(title!.toLowerCase()),).toList();
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 200,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8),

                    children: filtered.mapIndexed((currentValue, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Image.network(data[index]['p_images'][0],width: 150,
                        height: 130,
                        fit: BoxFit.cover,),
                        const Spacer(),
                        "${filtered[index]['p_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                        10.heightBox,
                        "${filtered[index]['p_price']}".text.fontFamily(bold).color(redColor).make(),
                    ],)
                      .box.padding(const EdgeInsets.all(12)).margin(const EdgeInsets.symmetric(horizontal: 4)).outerShadowMd.color(Colors.white).make().onTap(() {  Get.to(() =>
                        ItemDetail(
                          title: filtered[index]['p_name'],
                          data: filtered[index],)); }),

                ).toList(),
                ),
              );
            }  }
      ),
    );
  }
}
