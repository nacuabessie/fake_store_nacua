import 'package:fake_store/screens/products_by_category.dart';
import 'package:flutter/material.dart';

import '../services/api_service.dart';

class AllCategoryScreen extends StatelessWidget {
  AllCategoryScreen({Key? key}) : super(key: key);
  ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: FutureBuilder(
        future: apiService.getAllCategories(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final categories = snapshot.data;
          return ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: InkWell(
                    // onTap: () => Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (_) => ProductsByCategoryScreen(
                    //       categoryName: categoryName,
                    //     ),
                    //   ),
                    // ),
                    child: Container(
                      padding: const EdgeInsets.all(40),
                      child: Center(
                        child: Text( 'Go'
                          // categoryName,
                          // style: const TextStyle(
                          //   fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  );              
              });
        },
      ),
    );
  }
}
