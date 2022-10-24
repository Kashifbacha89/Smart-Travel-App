import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_travel_app/consts/contss.dart';
import 'package:smart_travel_app/inner_screens/Feeds_Screen.dart';
import 'package:smart_travel_app/models/services_model.dart';
import 'package:smart_travel_app/providers/services_provider.dart';
import 'package:smart_travel_app/services/global_methods.dart';
import 'package:smart_travel_app/services/utils.dart';
import 'package:smart_travel_app/widgets/feeds_widgets.dart';
import 'package:smart_travel_app/widgets/text_widgets.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    Size size = utils.getScreenSize;
    final theme = utils.getTheme;
    final Color color = utils.color;
    final servicesProvider=Provider.of<ServicesProvider>(context);
    List<ServicesModel> allServices= servicesProvider.getServices;


    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: size.width *0.55,
            child: Swiper(
              itemCount: Constss.offerImages.length,
              pagination: const SwiperPagination(
                  alignment: Alignment.bottomCenter,
                  builder: DotSwiperPaginationBuilder(
                    color: Colors.white,
                    activeColor: Colors.red,
                  )),
              autoplay: true,
              itemBuilder: (context,index){
                return Image.asset(Constss.offerImages[index],
                fit: BoxFit.fill,);
              },

            ),),
            const SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  TextWidget(text: 'Our Services', color: color, textSize: 22,isTitle: true,),
                   const Spacer(),
                  TextButton(onPressed: (){
                    GlobalMethod.navigateTo(ctx: context, routeName: FeedsScreen.routeName);
                  },
                      child: TextWidget(text: 'Browse all', color: color, textSize: 20,isTitle: true,)),
                ],
              ),
            ),
            GridView.count(
              physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              childAspectRatio: size.width/(size.height*.80),
              children: List.generate(allServices.length, (index) {
                return ChangeNotifierProvider.value(
                    value: allServices[index],
                    child: const FeedsWidgets());

              }),







            ),



          ],

        ),
      ),


    );
  }
}
