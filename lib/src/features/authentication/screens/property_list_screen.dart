import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/property_model.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/property_tile.dart';

import 'about_us_screen.dart';
import 'category_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_options.dart';

class PropertyListScreen extends StatefulWidget {
  PropertyListScreen({Key? key}) : super(key: key);

  @override
  _PropertyListScreenState createState() => _PropertyListScreenState();
}

class _PropertyListScreenState extends State<PropertyListScreen> {
  final CollectionReference _propertyCollection =
  FirebaseFirestore.instance.collection('properties');

  List<String> catNames = ['Family', 'Bachelor', 'Office', 'Sublet', 'Hostel', 'More..'];
  List<Color> catColors = [
    Colors.black87, Colors.black87, Colors.black87, Colors.black87, Colors.black87, Colors.black87,
  ];
  List<Icon> catIcons = [
    Icon(Icons.people,color: Colors.white,size: 30,),
    Icon(Icons.person,color: Colors.white,size: 30,),
    Icon(Icons.work,color: Colors.white,size: 30,),
    Icon(Icons.apartment,color: Colors.white,size: 30,),
    Icon(Icons.hotel,color: Colors.white,size: 30,),
    Icon(Icons.more_horiz_outlined,color: Colors.white,size: 30,),
  ];

  List<Property> allProperties = [];
  List<Property> filteredProperties = [];

  @override
  void initState() {
    super.initState();

    _propertyCollection.snapshots().listen((snapshot) {

      if (snapshot.docs.isNotEmpty) {

        allProperties = snapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          return Property.fromDocument(data);
        }).toList();

        _updateProperties(allProperties);
      }
    });
  }

  // Method to update the list of filtered properties
  void _updateProperties(List<Property> properties) {
    setState(() {
      filteredProperties = properties;
    });
  }

  void _filterPropertiesByCategory(String category) {
    List<Property> filteredProperties = allProperties
        .where((property) => property.propertyType == category)
        .toList();
    _updateProperties(filteredProperties);
  }

  void _handleTap(String category) {
    print('Pressed: $category');
    List<Property> categoryProperties = allProperties
        .where((property) => property.propertyType == category)
        .toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryPropertiesScreen(
          categoryName: category,
          properties: categoryProperties,
        ),
      ),
    );
  }

  int _currentIndex = 0;
  final List<String> images = [
  'assets/images/Review.png',
    'assets/images/UserSelection.png',
    'assets/images/welcome.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Categories', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,),),
                    ),
                  ),
                  const SizedBox(height: 10),

                  GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.4,
                    ),
                    itemCount: catNames.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          _handleTap(catNames[index]);
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  color: catColors[index],
                                  shape: BoxShape.circle
                              ),
                              child: Center(
                                child: catIcons[index],
                              ),
                            ),
                            Text(
                              catNames[index],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            CarouselSlider.builder(
              itemCount: images.length,
              options: CarouselOptions(
                height: 250,
                autoPlay: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return Container(
                  child: Center(
                    child: Image.asset(
                      images[index],
                      fit: BoxFit.cover,

                    ),
                  ),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: images.map((url) {
                int index = images.indexOf(url);
                return Container(
                  width: 20.0,
                  height: 10.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index ? Colors.blueAccent : Colors.grey,
                  ),
                );
              }).toList(),
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Recent Posts', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,),),
              ),
            ),
            const SizedBox(height: 15,),
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: filteredProperties.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                Property property = filteredProperties[index];
                return PropertyTile(property: property);
              },
            ),
          ],
        ),
      ),
    );
  }
}