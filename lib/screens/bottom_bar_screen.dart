import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_travel_app/provider/dark_theme_provider.dart';
import 'package:smart_travel_app/screens/cart_screen.dart';
import 'package:smart_travel_app/screens/categories_screen.dart';
import 'package:smart_travel_app/screens/home_screen.dart';
import 'package:smart_travel_app/screens/user_screen.dart';
class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {

  var index = 0;
  final arrayofpages = [
    const HomeScreen(),
    CategoriesScreen(),
    const BookingScreen(),
    const UserScreen(),


  ];
  final items = [
    const Icon(Icons.home_outlined,color: Colors.white,),
    const Icon(Icons.category_outlined,color: Colors.white,),
    const Icon(Icons.shopping_cart,color: Colors.white,),
    const Icon(Icons.person,color: Colors.white,),
  ];












  @override
  Widget build(BuildContext context) {
    final themestate = Provider.of<DarkThemeProvider>(context);
    final Color color = themestate.getDarkTheme ? Colors.white : Colors.black;
    return Scaffold(

      bottomNavigationBar: CurvedNavigationBar(
        color: themestate.getDarkTheme?Colors.white:Colors.black,
        animationCurve: Curves.fastOutSlowIn,
        backgroundColor: Colors.transparent,
        items: items,
        index: index,
        onTap: (index) => setState(() => this.index = index),
      ),
      body: arrayofpages[index],
    );
  }
}
