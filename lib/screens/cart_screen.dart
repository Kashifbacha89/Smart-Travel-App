import 'package:flutter/material.dart';
import 'package:smart_travel_app/widgets/empty_screen.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const EmptyScreen(
        imagePath: 'assets/images/cart.png',
        title: 'your cart is empty',
        subtitle: 'Book something and make me happy',
        buttonText: 'book your seat');
  }
}
