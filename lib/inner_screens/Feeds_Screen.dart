import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_travel_app/models/services_model.dart';
import 'package:smart_travel_app/providers/services_provider.dart';
import 'package:smart_travel_app/services/utils.dart';
import 'package:smart_travel_app/widgets/back_widget.dart';
import 'package:smart_travel_app/widgets/empty_product_widget.dart';
import 'package:smart_travel_app/widgets/feeds_widgets.dart';
import 'package:smart_travel_app/widgets/text_widgets.dart';

class FeedsScreen extends StatefulWidget {
  static const routeName = '/FeedsScreen';
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  List<ServicesModel> listServicesSearch = [];
  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final servicesProvider = Provider.of<ServicesProvider>(context);
    List<ServicesModel> allServices = servicesProvider.getServices;

    return Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextWidget(
          text: 'All Services',
          color: color,
          textSize: 24,
          isTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: kBottomNavigationBarHeight,
                child: TextField(
                  controller: _searchController,
                  focusNode: _searchFocusNode,
                  onChanged: (value) {
                    setState(() {
                      listServicesSearch = servicesProvider.searchQuery(value);
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Where to go',
                    prefixIcon: const Icon(Icons.search),
                    suffix: IconButton(
                      onPressed: () {
                        _searchController.clear();
                        _searchFocusNode.unfocus();
                      },
                      icon: Icon(
                        Icons.close,
                        color: _searchFocusNode.hasFocus ? Colors.red : color,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: Colors.greenAccent, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: Colors.greenAccent, width: 1),
                    ),
                  ),
                ),
              ),
            ),
            _searchController.text.isNotEmpty && listServicesSearch.isEmpty
                ? const EmptyProductWidget(
                    text: 'Service can not be found please try another keyword')
                : GridView.count(crossAxisCount: 2,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,

              childAspectRatio: size.width/(size.height * 0.80),
              children: List.generate(
                  _searchController.text.isNotEmpty?
                  listServicesSearch.length:

                  allServices.length, (index) {
                return  ChangeNotifierProvider.value(

                    value:
                    _searchController.text.isNotEmpty?
                    listServicesSearch[index]:
                    allServices[index],
                    child: const FeedsWidgets());
              }),
            ),
          ],
        ),
      ),
    );
  }
}
