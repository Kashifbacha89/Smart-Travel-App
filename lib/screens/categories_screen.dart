import 'package:flutter/material.dart';
import 'package:smart_travel_app/services/utils.dart';
import 'package:smart_travel_app/widgets/categories_widgets.dart';
import 'package:smart_travel_app/widgets/text_widgets.dart';
class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({Key? key}) : super(key: key);
  List<Color> gridColors = [
    const Color(0xff53B175),
    const Color(0xffF8A44C),
    const Color(0xffF7A593),
    const Color(0xffD3B0E0),
    const Color(0xffFDE598),
    const Color(0xffB7DFF5),
  ];

  List<Map<String, dynamic>> catInfo = [
    {
      'imgPath': 'assets/images/mardan.jpg',
      'catText': 'Peshawar To Mardan',
    },
    {
      'imgPath': 'assets/images/abot.jpg',
      'catText': 'Peshawar To Abotabad',
    },

    {
      'imgPath': 'assets/images/islam.jpg',
      'catText': 'Peshawar To Islamabad',
    },
    {
      'imgPath': 'assets/images/lahore.png',
      'catText': 'Peshawar To Lahore',
    },
    {
      'imgPath': 'assets/images/pesh.jpg',
      'catText': 'Peshawar To Faisalabad',
    },
    {
      'imgPath': 'assets/images/swat.jpg',
      'catText': 'Peshawar To Swat',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final utils=Utils(context);
    Color color=utils.color;
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,

        elevation: 0,
        title: TextWidget(
          text: 'Categories',
          color: color,
          textSize: 24,
          isTitle: true,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(crossAxisCount: 2,
          childAspectRatio: 240/250,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: List.generate(6, (index){
            return CategoriesWidget(
              passedColor: gridColors[index],
              catText:catInfo[index]['catText'] ,
              imgPath: catInfo[index]['imgPath'],
            );
          }),
        ),
      ),



    );
  }
}
