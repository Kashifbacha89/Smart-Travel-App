import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_travel_app/models/services_model.dart';
import 'package:smart_travel_app/providers/services_provider.dart';
import 'package:smart_travel_app/services/utils.dart';
import 'package:smart_travel_app/widgets/back_widget.dart';
import 'package:smart_travel_app/widgets/empty_product_widget.dart';
import 'package:smart_travel_app/widgets/feeds_widgets.dart';
import 'package:smart_travel_app/widgets/text_widgets.dart';
class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);
  static const routeName = '/CategoryScreen';

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final TextEditingController _searchController=TextEditingController();
  final FocusNode _searchFocusNode= FocusNode();
  List<ServicesModel> listServicesSearch=[];
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
    final catName = ModalRoute.of(context)!.settings.arguments as String;
    final servicesProvider=Provider.of<ServicesProvider>(context);
    List<ServicesModel> servicesByCat=servicesProvider.findByCategory(catName);


    return Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextWidget(
          text: catName,
          color: color,
          textSize: 24,
          isTitle: true,
        ),
        centerTitle: true,
      ),
      body:servicesByCat.isEmpty?
          const EmptyProductWidget(text: 'No services belong to this category'):

      SingleChildScrollView(
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
                      listServicesSearch=servicesProvider.searchQuery(value);
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "what's  in your mind",
                    prefixIcon: const Icon(Icons.search),
                    suffix: IconButton(
                      onPressed: () {
                        _searchController.clear();
                        _searchFocusNode.unfocus();
                      },
                      icon: Icon(
                        Icons.close,
                        color: _searchFocusNode.hasFocus
                            ? Colors.red
                            : color,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                          color: Colors.greenAccent, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                          color: Colors.greenAccent, width: 1),
                    ),
                  ),
                ),
              ),
            ),
            _searchController.text.isNotEmpty&& listServicesSearch.isEmpty?
            const EmptyProductWidget(text: 'No services belong to this category'):
            GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              childAspectRatio: size.width/(size.height*.80),
              children: List.generate(
              _searchController.text.isNotEmpty?listServicesSearch.length:servicesByCat.length,
                      (index) {

                return ChangeNotifierProvider.value(
                  value: _searchController.text.isNotEmpty?
                    listServicesSearch[index]:servicesByCat[index],
                    child:const FeedsWidgets());

              }),







            ),


          ],
        ),
      ),
    );
  }
}
