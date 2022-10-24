import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_travel_app/consts/theme_data.dart';
import 'package:smart_travel_app/fetch_screen.dart';
import 'package:smart_travel_app/inner_screens/Feeds_Screen.dart';
import 'package:smart_travel_app/inner_screens/category_screen.dart';
import 'package:smart_travel_app/inner_screens/services_detail_screen.dart';
import 'package:smart_travel_app/provider/dark_theme_provider.dart';
import 'package:smart_travel_app/providers/services_provider.dart';
import 'package:smart_travel_app/screens/auth/login_screen.dart';
import 'package:smart_travel_app/screens/auth/register_screen.dart';
import 'package:smart_travel_app/screens/bottom_bar_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  DarkThemeProvider themeChangeProvider = DarkThemeProvider();
  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
    await themeChangeProvider.darkThemePrefs.getTheme();
  }
  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }
  final Future<FirebaseApp> _firebaseInitialization=Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _firebaseInitialization,
      builder: (context,snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting){
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),

            ),

          );

        }else if(snapshot.hasError){
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: Text('An error hase occurred'),
              ),
            ),
          );
        }


        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_){
              return themeChangeProvider;
            }),
            ChangeNotifierProvider(create: (_){
              return ServicesProvider();
            }),
          ],
          child: Consumer<DarkThemeProvider>(builder:(context, themeProvider, child){
            return   MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: Styles.themeData(themeProvider.getDarkTheme, context),

              home:  const FetchScreen(),
              routes: {
                RegisterScreen.routeName:(context)=> const RegisterScreen(),
                LoginScreen.routeName:(context)=> const LoginScreen(),
                FeedsScreen.routeName:(context)=> const FeedsScreen(),
                CategoryScreen.routeName:(context)=> const CategoryScreen(),
                ServicesDetailScreen.routeName:(context)=>const ServicesDetailScreen(),
              },
            );

          }
            ,),




        );
      }
    );
  }
}