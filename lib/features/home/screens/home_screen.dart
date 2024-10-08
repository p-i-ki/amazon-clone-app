import 'package:amazone_clone_by_rivaan/constants/golbal_variables.dart';
import 'package:amazone_clone_by_rivaan/features/home/widgets/address_box.dart';
import 'package:amazone_clone_by_rivaan/features/home/widgets/carousel_image.dart';
import 'package:amazone_clone_by_rivaan/features/home/widgets/deal_of_day.dart';
import 'package:amazone_clone_by_rivaan/features/home/widgets/top_categories.dart';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    //  final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          //we can't directly pass gradient color to appbar , so we are using flexiblespace(and then a container) to do so and to occupy the whole appbar
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  //Expanded widget will expand the container in horizontal direction(mainAxis)
                  //So giving the width is meaningless
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    //we are using Material instead of Container to provide elevation to the search bar
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      decoration: InputDecoration(
                          prefixIcon: InkWell(
                            onTap: () {},
                            child: const Icon(Icons.search),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.only(top: 10),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            borderSide:
                                BorderSide(color: Colors.black38, width: 1),
                          ),
                          hintText: 'Search Amazon.in',
                          hintStyle: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 17)),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(Icons.mic),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: const Column(
          children: [
            AddressBox(),
            SizedBox(height: 10),
            TopCategories(),
            SizedBox(height: 10),
            CarouselImage(),
            DealOfDay(),
          ],
        ),
      ),
    );
  }
}
