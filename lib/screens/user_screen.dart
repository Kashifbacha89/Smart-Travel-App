import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:smart_travel_app/consts/firebase_consts.dart';
import 'package:smart_travel_app/provider/dark_theme_provider.dart';
import 'package:smart_travel_app/screens/auth/login_screen.dart';
import 'package:smart_travel_app/screens/loading_manager.dart';
import 'package:smart_travel_app/services/global_methods.dart';
import 'package:smart_travel_app/widgets/text_widgets.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  String?_name;
  String?_email;
  String?address;
  String?phoneNumber;
  bool?_isLoading=false;
  final TextEditingController _addressTextController=TextEditingController(text: '');
  final TextEditingController _phoneNumberController=TextEditingController(text: '');
  @override
  void dispose() {
    _addressTextController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    getUserData();
    super.initState();
  }
  final User? user= authInstance.currentUser;
  Future<void> getUserData()async{
    setState(() {
      _isLoading=true;
    });
    if(user==null){
      setState(() {
        _isLoading=false;
      });

    }
    try{
      String _uid=user!.uid;
      final DocumentSnapshot userDocs=
      await FirebaseFirestore.instance.collection('users').doc(_uid).get();
      if(userDocs==null){
        return;
      }else{
        _name=userDocs.get('name');
        _email= userDocs.get('email');
        address=userDocs.get('shipping-address');
        _addressTextController.text=userDocs.get('shipping-address');
        phoneNumber=userDocs.get('phoneNumber');
        _phoneNumberController.text=userDocs.get('phoneNumber');





      }


    }catch(error){
      setState(() {
        _isLoading=false;
      });
      GlobalMethod.errorDialog(subTitle: '$error', context: context);

    }finally{
      setState(() {
        _isLoading=false;
      });
    }


  }





  @override
  Widget build(BuildContext context) {
    final themestate = Provider.of<DarkThemeProvider>(context);
    final Color color = themestate.getDarkTheme ? Colors.white : Colors.black;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                RichText(
                    text: TextSpan(
                        text: 'Hi',
                        style: const TextStyle(
                          color: Colors.cyan,
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                        ),

                        children: <TextSpan>[

                      TextSpan(

                          text: _name==null?'User':_name,
                          style: TextStyle(
                              color: color,
                              fontWeight: FontWeight.w600,
                              fontSize: 25),
                        recognizer:TapGestureRecognizer()
                          ..onTap=(){
                            print('my name is pressed');
                          }
                      ),

                    ])),
               const  SizedBox(height: 5,),
                TextWidget(text: _email==null?'email':_email!, color: color, textSize: 18),
                const SizedBox(height: 20,),
                const Divider(thickness: 3,),
                const SizedBox(height: 20,),
                _listTiles(title: 'Address',
                    subtitle: address,
                    icon: IconlyLight.call, onPressed: ()async{
                  _showAddressDialog();


                    }, color: color),
                _listTiles(title: 'Phone',
                    subtitle: phoneNumber,
                    icon: IconlyLight.call, onPressed: (){
                 _showPhoneDialogue();


                    }, color: color),
                _listTiles(title: 'bookings', icon: IconlyLight.bag, onPressed: (){}, color: color),
                _listTiles(title: 'viewed', icon: IconlyLight.show, onPressed: (){}, color: color),
                _listTiles(title: 'Forgot Password', icon: IconlyLight.unlock, onPressed: (){}, color: color),
                SwitchListTile(
                    title: TextWidget(text: themestate.getDarkTheme?'Dark Mode':'Light Mode',
                        color: color, textSize: 18),
                    secondary: Icon(themestate.getDarkTheme?Icons.dark_mode_outlined:Icons.light_mode_outlined),



                    value: themestate.getDarkTheme, onChanged: (bool value){
                  setState(() {
                    themestate.setDarkTheme=value;

                  });
                }),
                _listTiles(title: user==null?'Login':'Logout',
                    icon: user==null?IconlyLight.login:IconlyLight.logout,
                    onPressed: (){
                  if(user==null){
                    Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const LoginScreen()),
                    );
                    return;

                  }
                  GlobalMethod.warningDialog(title: 'Sign Out',
                      subTitle: 'Do you wanna sign out?', fct: ()async{
                    await authInstance.signOut();
                    Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const LoginScreen()));


                      }, context: context);




                }, color: color),









              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> _showPhoneDialogue() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Update'),
            content: TextField(

              controller: _phoneNumberController,
              maxLines: 5,
              decoration: const InputDecoration(hintText: "Your Phone Number"),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  String _uid = user!.uid;
                  try {
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(_uid)
                        .update({
                      'phoneNumber': _addressTextController.text,
                    });

                    Navigator.pop(context);
                    setState(() {
                      phoneNumber = _phoneNumberController.text;
                    });
                  } catch (err) {
                    GlobalMethod.errorDialog(
                        subTitle: err.toString(), context: context);
                  }
                },
                child: const Text('Update'),
              ),
            ],
          );
        });
  }
  Future<void> _showAddressDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Update'),
            content: TextField(
              // onChanged: (value) {
              //   print('_addressTextController.text ${_addressTextController.text}');
              // },
              controller: _addressTextController,
              maxLines: 5,
              decoration: const InputDecoration(hintText: "Your address"),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  String _uid = user!.uid;
                  try {
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(_uid)
                        .update({
                      'shipping-address': _addressTextController.text,
                    });

                    Navigator.pop(context);
                    setState(() {
                      address = _addressTextController.text;
                    });
                  } catch (err) {
                    GlobalMethod.errorDialog(
                        subTitle: err.toString(), context: context);
                  }
                },
                child: const Text('Update'),
              ),
            ],
          );
        });
  }
  Widget _listTiles({
    required String title,
    String? subtitle,
    required IconData icon,
    required Function onPressed,
    required Color color,
  }) {
    return ListTile(
      title: TextWidget(
        text: title,
        color: color,
        textSize: 22,
        // isTitle: true,
      ),
      subtitle: TextWidget(
        text: subtitle == null ? "" : subtitle,
        color: color,
        textSize: 18,
      ),
      leading: Icon(icon),
      trailing: const Icon(IconlyLight.arrowRight2),
      onTap: () {
        onPressed();
      },
    );
  }
}
