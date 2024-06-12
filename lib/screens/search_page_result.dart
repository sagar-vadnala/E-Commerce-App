import 'package:e_commerce_app/models/product_model.dart';
import 'package:flutter/material.dart';

class SearchResultsPage extends StatefulWidget {
  final List<ProductModel> staticResults;

  const SearchResultsPage({Key? key, required this.staticResults}) : super(key: key);

  @override
  _SearchResultsPageState createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  List<ProductModel> searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Results"),
      ),
      body: Column(
        children: [
          // Search Widget
          TextField(
            onChanged: (query) {
              setState(() {
                searchResults = widget.staticResults.where((product) => product.title.toLowerCase().contains(query.toLowerCase())).toList();
              });
            },
            decoration: const InputDecoration(
              hintText: "Search",
              prefixIcon: Icon(Icons.search),
            ),
          ),
          // Dynamic Search Results
          if (searchResults.isEmpty) ...[
            const Center(
              child: Text("No results found"),
            ),
          ] else ...[
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(searchResults[index].title),
                    // Display other details as needed
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}
