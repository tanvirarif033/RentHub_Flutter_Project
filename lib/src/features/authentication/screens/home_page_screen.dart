import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/home_screen0.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/navigation_drawer_screen.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/rent_property_screen.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/search_screen.dart';
import 'favourite_screen.dart';
import 'home_screen.dart';
import 'messages_screen.dart';
import 'notification_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final items = const [

    Icon(Icons.home_outlined, size: 30, color: Colors.white),
    Icon(Icons.favorite_border, size: 30, color: Colors.white),
    Icon(Icons.add_circle_outline_sharp, size: 30, color: Colors.white),
    Icon(Icons.chat_bubble_outline_outlined, size: 30, color: Colors.white),
    Icon(Icons.search_outlined, size: 30, color: Colors.white),
  ];
  int index = 0;

  List<String> appBarTitles = [
    'Home',
    'Favorites',
    'Rent Property',
    'Messages',
    'Search',
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarOpacity: 1,
        leading: SafeArea(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(6),


                  const Row(
                    children: [
                      Gap(10),
                      Text(
                        'RENTHUB',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        leadingWidth: 100,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const notification_screen(),
                ),
              );
            },
            icon: const Icon(Icons.notifications_none_outlined),
            color: Colors.white,
            focusColor: Colors.grey.shade800,
          ),
          Builder(
            builder: (context) {
              return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(Icons.dehaze_outlined, color: Colors.white),
              );
            },
          ),
        ],
        title: Text(appBarTitles[index],
        style: TextStyle(color: Colors.white,fontSize: 28) ,
        ),
        centerTitle: true,
      ),
      drawer: const NavigationDrawerWidget(),
      bottomNavigationBar: CurvedNavigationBar(
        items: items,
        index: index,
        onTap: (selectedIndex) {

          setState(() {
            index = selectedIndex;
          });
        },
        height: 70,
        color: Colors.black,
        backgroundColor: Colors.white,
        animationDuration: const Duration(milliseconds: 300),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        margin: const EdgeInsets.all(5),
        child: getSelectedWidget(index: index),
      ),
    );
  }

  Widget getSelectedWidget({required int index}) {
    Widget widget;
    switch (index) {
      case 0:
        widget = const HomeScreen();
        break;
      case 1:
        widget = const favourite_screen();
        break;
      case 2:
        widget = const rent_property_screen();
        break;
      case 3:

      widget =ChatScreen();
        break;
      case 4:
        widget = const SearchScreen();
        break;
      default:
        widget = const HomeScreen();
        break;
    }
    return widget;
  }
}
