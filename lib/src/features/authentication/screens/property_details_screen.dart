import 'package:flutter/material.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/property_model.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/see_review.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/write_review.dart';
import 'package:gap/gap.dart';

import 'customer_info.dart';

class PropertyDetailsScreen extends StatefulWidget {
  final Property property;

  const PropertyDetailsScreen({Key? key, required this.property})
      : super(key: key);

  @override
  _PropertyDetailsScreenState createState() => _PropertyDetailsScreenState();
}

class _PropertyDetailsScreenState extends State<PropertyDetailsScreen> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    // Set the initial favorite status based on property's isFavorite value
    isFavorite = widget.property.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Property Details',
            style: TextStyle(fontSize: 25),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 300.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: widget.property.imageUrl != null &&
                        widget.property.imageUrl.isNotEmpty
                        ? NetworkImage(widget.property.imageUrl!)
                        : AssetImage(
                        'assets/logo/renthub.png') as ImageProvider<Object>,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(widget.property.propertyType,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: _toggleFavorite,
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : null,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16.0),
                    Text('Location: ${widget.property.district}',
                        style: TextStyle(fontSize: 20)),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Icon(Icons.king_bed, size: 40),
                        SizedBox(width: 8.0),
                        Text('Bedrooms: ${widget.property.bedrooms}',
                            style: TextStyle(fontSize: 15)),
                        SizedBox(width: 50.0),
                        Icon(Icons.bathtub, size: 40),
                        SizedBox(width: 8.0),
                        Text('Bathrooms: ${widget.property.bathrooms}',
                            style: TextStyle(fontSize: 15)),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    _buildSection('Price Info',
                        'Price(Monthly): ${widget.property.price}', 18),
                    _buildSection('Location',
                        'District: ${widget.property.district}\nArea: ${widget
                            .property.area} ', 20),
                    _buildSection('Facilities',
                        'Facilities: ${widget.property.facilities}', 20),
                    _buildSection(
                        'Contact', 'Phone: ${widget.property.phone}', 20),
                    _buildSection('Available From',
                        'Available From: ${widget.property.availableDate}', 20),
                    SizedBox(height: 16.0),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Add your button click logic here
                            // For example, you can navigate to another screen or perform an action
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WriteReview(),
                              ),
                            );
                          },
                          child: Text('Give Review'),
                        ),
                        Gap(10),
                        ElevatedButton(
                          onPressed: () {
                            // Add your button click logic here
                            // For example, you can navigate to another screen or perform an action
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SeeReviewScreen(),
                              ),
                            );
                          },
                          child: Text('See Review'),
                        ),
                        Gap(10),
                        ElevatedButton(
                          onPressed: () {
                            // Add your button click logic here
                            // For example, you can navigate to another screen or perform an action
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CustomerInfoScreen(),
                              ),
                            );
                          },
                          child: const Text('Advance Payment'),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    // Favorite Button
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content, double fontSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Text(
          content,
          style: TextStyle(fontSize: fontSize),
        ),
        SizedBox(height: 16.0),
      ],
    );
  }

  void _toggleFavorite() {
    setState(() {
      // Toggle the favorite status
      isFavorite = !isFavorite;
      // Update the property's isFavorite status
      widget.property.isFavorite = isFavorite;
      // Update the favorite status in Firebase or your preferred storage mechanism
      // Here, you can call a function to update the property's favorite status in your database

      // Show SnackBar
      final snackBar = SnackBar(
        content: Text(
            isFavorite ? 'Added to favorites' : 'Removed from favorites'),
        duration: Duration(seconds: 1), // Adjust duration as needed
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }
}