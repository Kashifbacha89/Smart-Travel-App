import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_travel_app/inner_screens/services_detail_screen.dart';
import 'package:smart_travel_app/models/services_model.dart';
import 'package:smart_travel_app/services/global_methods.dart';
import 'package:smart_travel_app/services/utils.dart';
import 'package:smart_travel_app/widgets/text_widgets.dart';
class FeedsWidgets extends StatefulWidget {
  const FeedsWidgets({Key? key}) : super(key: key);

  @override
  State<FeedsWidgets> createState() => _FeedsWidgetsState();
}

class _FeedsWidgetsState extends State<FeedsWidgets> {
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).color;
    final servicesModel= Provider.of<ServicesModel>(context);

    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor.withOpacity(0.9),
        child: InkWell(
          onTap: (){
            Navigator.pushNamed(context, ServicesDetailScreen.routeName,
            arguments: servicesModel.id);


          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 5,
                      child:FancyShimmerImage(
                          imageUrl: servicesModel.imageUrl,
                      boxFit: BoxFit.fill,
                        height: size.width*0.21,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: 'VehicleType:',
                      color: color,
                      textSize: 10,
                      isTitle: false,
                    ),
                    const Spacer(),
                    TextWidget(
                      text: servicesModel.vehicleType,
                      color: color,
                      textSize: 12,
                      isTitle: true,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: 'Seats:',
                      color: color,
                      textSize: 10,
                      isTitle: false,
                    ),
                    const Spacer(),
                    TextWidget(
                      text: servicesModel.capacity.toString(),
                      color: color,
                      textSize: 16,
                      isTitle: true,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: 'Available Seat:',
                      color: color,
                      textSize: 10,
                      isTitle: false,
                    ),
                    const Spacer(),
                    TextWidget(
                      text: servicesModel.availableSeat.toString(),
                      color: color,
                      textSize: 16,
                      isTitle: true,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: 'Timing:',
                      color: color,
                      textSize: 10,
                      isTitle: false,
                    ),
                    const Spacer(),
                    TextWidget(
                      text: servicesModel.timing.toString(),
                      color: color,
                      textSize: 14,
                      isTitle: true,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: 'Destination:',
                      color: color,
                      textSize: 10,
                      isTitle: false,
                    ),
                    const Spacer(),
                    TextWidget(
                      text: servicesModel.destination.toString(),
                      color: color,
                      textSize: 12,
                      isTitle: true,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: 'Ticket:',
                      color: color,
                      textSize: 10,
                      isTitle: false,
                    ),
                    const Spacer(),
                    TextWidget(
                      text: 'Rs:${servicesModel.price.toString()}',
                      color: color,
                      textSize: 16,
                      isTitle: true,
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                      onPressed: (){},
                      style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Colors.lightBlue),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(12.0),
                                    bottomRight: Radius.circular(12.0),
                                  )))),
                      child: TextWidget(text: 'Lets go', color: color, textSize: 20)),
                )
              ],
            ),
          ),

        ),
      ),
    );
  }
}
