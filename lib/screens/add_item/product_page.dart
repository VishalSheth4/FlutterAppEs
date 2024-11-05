// ignore_for_file: library_private_types_in_public_api

import 'dart:typed_data';
import 'dart:convert'; // For jsonEncode
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:http/http.dart' as http; // Add this import for HTTP requests

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage>
    with SingleTickerProviderStateMixin {
  String productName = 'Xiaomi Watch 2 Pro';
  String description =
      'Xiaomi Watch 2 Pro supports 19 professional fitness modes such as for basketball, tennis, swimming, and HIIT, and also for nearly 100 additional fitness modes. Accurately monitor and analyze important data, such as heart rate, average pace, and calories burned, for more efficient exercise. Waterproof 5 ATM* Suitable for swimming.';

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final List<String> productImageAssets = [
    'assets/1.jpg',
    'assets/e-mart.jpeg',
    'assets/e-t.jpeg',
  ];
  List<Uint8List> pickedImages = [];

  late AnimationController _controller;
  late Animation<Offset> _leftBoxAnimation;
  late Animation<Offset> _rightBoxAnimation;

  @override
  void initState() {
    super.initState();
    nameController.text = productName;
    descriptionController.text = description;

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _leftBoxAnimation = Tween<Offset>(
      begin: Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _rightBoxAnimation = Tween<Offset>(
      begin: Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward(); // Start the animation
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pickImages() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
        withData: true,
      );

      if (result != null) {
        setState(() {
          pickedImages.addAll(result.files.map((file) => file.bytes!).toList());
        });
      }
    } catch (e) {
      print('Error picking images: $e');
    }
  }

  Future<void> _saveProduct() async {
    final Map<String, dynamic> productData = {
      'name': nameController.text,
      'description': descriptionController.text,
      'basePrice': double.parse('118.89'), // Update this to get from a text field
      'discountPercentage': double.parse('25'), // Update this to get from a text field
      'discountType': 'Percentage', // Replace with actual data
      'category': 'Electronics', // Replace with actual data
      'tags': 'Internet Of Things', // Replace with actual data
      'sku': '113902', // Replace with actual data
      'barcode': '0924289012', // Replace with actual data
      'quantity': 10, // Replace with actual data
      'images': pickedImages.map((img) => base64Encode(img)).toList(),
    };

    final response = await http.post(
      Uri.parse('https://localhost:3002/products'), // Update with your server address
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(productData),
    );

    if (response.statusCode == 201) {
      // Successfully saved the product
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product saved successfully!')),
      );
    } else {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save product.')),
      );
    }
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {bool readOnly = false, int maxLines = 1, int minLines = 1}) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      maxLines: maxLines,
      minLines: minLines,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        fillColor: Colors.white,
        filled: true,
      ),
    );
  }

  Widget _buildImageGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: productImageAssets.length + pickedImages.length,
      itemBuilder: (context, index) {
        if (index < productImageAssets.length) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              productImageAssets[index],
              fit: BoxFit.cover,
            ),
          );
        } else {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.memory(
              pickedImages[index - productImageAssets.length],
              fit: BoxFit.cover,
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Calculate container width considering padding
    final double containerWidth = (MediaQuery.of(context).size.width - 40) / 2; // 20 padding on each side
    final double containerHeight = MediaQuery.of(context).size.height * 0.45;

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Page'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SlideTransition(
                  position: _leftBoxAnimation,
                  child: Container(
                    width: containerWidth,
                    height: containerHeight,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeader('General Information'),
                        _buildTextField(nameController, 'Product Name', readOnly: false),
                        SizedBox(height: 16),
                        _buildTextField(
                          descriptionController,
                          'Description',
                          maxLines: 5,
                          minLines: 3,
                          readOnly: false,
                        ),
                      ],
                    ),
                  ),
                ),
                SlideTransition(
                  position: _rightBoxAnimation,
                  child: Container(
                    width: containerWidth,
                    height: containerHeight,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeader('Product Media'),
                        SizedBox(height: 4),
                        Text(
                          'Photo Product',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        SizedBox(height: 8),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey.shade100,
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: DottedBorder(
                                    borderType: BorderType.RRect,
                                    radius: Radius.circular(8),
                                    dashPattern: [8, 4],
                                    color: Colors.grey.shade400,
                                    strokeWidth: 1,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        child: _buildImageGrid(),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                ElevatedButton.icon(
                                  onPressed: _pickImages,
                                  icon: Icon(Icons.add_a_photo, color: Colors.blue),
                                  label: Text(
                                    'Add More Image',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    side: BorderSide(color: Colors.grey.shade400),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SlideTransition(
                  position: _leftBoxAnimation,
                  child: Container(
                    width: containerWidth,
                    height: containerHeight,
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.only(top: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeader('Pricing'),
                        _buildTextField(
                          TextEditingController()..text = '118.89',
                          'Base Price',
                          readOnly: false,
                        ),
                        SizedBox(height: 16),
                        _buildTextField(
                          TextEditingController()..text = '25%',
                          'Discount Percentage (%)',
                          readOnly: false,
                        ),
                        SizedBox(height: 16),
                        _buildTextField(TextEditingController(), 'Discount Type',
                            readOnly: false),
                      ],
                    ),
                  ),
                ),
                SlideTransition(
                  position: _rightBoxAnimation,
                  child: Container(
                    width: containerWidth,
                    height: containerHeight,
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.only(top: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeader('Category'),
                        _buildTextField(
                          TextEditingController()..text = 'Electronics',
                          'Product Category',
                          readOnly: false,
                        ),
                        SizedBox(height: 16),
                        _buildTextField(
                          TextEditingController()..text = 'Internet Of Things',
                          'Product Tags',
                          readOnly: false,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SlideTransition(
              position: _leftBoxAnimation,
              child: Container(
                width: containerWidth,
                height: containerHeight,
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.only(top: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader('Inventory'),
                    _buildTextField(
                      TextEditingController()..text = '113902',
                      'SKU',
                      readOnly: false,
                    ),
                    SizedBox(height: 16),
                    _buildTextField(
                      TextEditingController()..text = '0924289012',
                      'Barcode',
                      readOnly: false,
                    ),
                    SizedBox(height: 16),
                    _buildTextField(TextEditingController(), 'Quantity',
                        readOnly: false),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20), // Add some spacing
            ElevatedButton(
              onPressed: _saveProduct,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue, padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ), // Call the save function
              child: Text('Save Product'),
            ),
          ],
        ),
      ),
    );
  }
}
