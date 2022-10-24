import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:smart_travel_app/consts/contss.dart';
import 'package:smart_travel_app/consts/firebase_consts.dart';
import 'package:smart_travel_app/providers/services_provider.dart';
import 'package:smart_travel_app/screens/bottom_bar_screen.dart';

class FetchScreen extends StatefulWidget {
  const FetchScreen({Key? key}) : super(key: key);

  @override
  State<FetchScreen> createState() => _FetchScreenState();
}

class _FetchScreenState extends State<FetchScreen> {
  List<String> images = Constss.offerImages;
  @override
  void initState() {
    images.shuffle();
    Future.delayed(const Duration(microseconds: 5), () async {
      final serviceProvider = Provider.of<ServicesProvider>(context,listen: false);
      final User? user = authInstance.currentUser;
      if (user == null) {
        await serviceProvider.fetchServices();
      } else {
        await serviceProvider.fetchServices();
      }
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const BottomBarScreen()));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            images[0],
            fit: BoxFit.cover,
            height: double.infinity,
          ),
          Container(
            color: Colors.black.withOpacity(0.9),
          ),
          const Center(
            child: SpinKitFadingFour(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
