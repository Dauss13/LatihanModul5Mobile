import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mikan/data/models/books.dart';

class BooksController extends GetxController {
  final String apiKey;
  final RxList<Book> books = <Book>[].obs; // RxList to store the books
  final RxString query = ''.obs; // RxString to store the query

  BooksController(this.apiKey);

  // Use the debounce method to delay the API request
  void searchBooks(String query) {
    this.query.value = query;
    // Fetch books based on the updated query
    fetchBooks();
  }

  void fetchBooks() async {
    final response = await http.get(
      Uri.https('www.googleapis.com', '/books/v1/volumes',
          {'q': query.value, 'key': apiKey}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<Book> fetchedBooks = [];

      if (data['items'] != null) {
        for (var item in data['items']) {
          fetchedBooks.add(Book.fromJson(item));
        }
      }

      books.assignAll(fetchedBooks); // Update the RxList with fetched data
    } else {
      throw Exception('Failed to load books');
    }
  }
}
