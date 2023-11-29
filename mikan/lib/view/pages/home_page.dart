import 'package:flutter/material.dart';
import 'package:mikan/controller/books_controller.dart';
import 'package:mikan/data/models/books.dart';
import 'package:mikan/view/widgets/bottom_nav_bar.dart';
import "package:mikan/view/widgets/webview.dart";
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();
  late final BooksController _booksViewModel;

  HomePage() {
    _booksViewModel =
        Get.put(BooksController('AIzaSyBGSUu0FfPaCiO9qqlugJe6osVpzr2Pm3k'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Search App'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey[200],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search for Books',
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                ),
                onChanged: (query) {
                  // Update the query in the BooksController using GetX's update method
                  _booksViewModel.searchBooks(query);
                },
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              final _searchResults = _booksViewModel.books;
              return ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  final book = _searchResults[index];
                  return GestureDetector(
                    onTap: () {
                      _onResultTapped(book);
                    }, 
                    child: ListTile(
                      title: Text(book.title),
                      subtitle: Text(book.author),
                      leading: Image.network(book.imageUrl),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  void _onResultTapped(Book book) {
    Get.to(BookWebView(book.url));
  }
}