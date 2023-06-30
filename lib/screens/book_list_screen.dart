import 'package:flutter/material.dart';
import '../models/book.dart';
import '../data/http_helper.dart';

class BookListScreen extends StatefulWidget {
  const BookListScreen({super.key});
  @override
  State<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  List<Book> books = [];
  @override
  void initState() {
    super.initState();
    final HttpHelper helper = HttpHelper();
    helper.getBooks('flutter').then((List<Book> value) {
      setState(() {
        books = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isLargeScreen;
    if (MediaQuery.of(context).size.width > 600) {
      isLargeScreen = true;
    } else {
      isLargeScreen = false;
    }
    return Scaffold(
        appBar: AppBar(title: const Text('Books')),
        body: GridView.count(
            childAspectRatio: isLargeScreen ? 8 : 5,
            crossAxisCount: isLargeScreen ? 2 : 1,
            children: List.generate(books.length, (index) {
              return ListTile(
                title: Text(books[index].title),
                subtitle: Text(books[index].authors),
                leading: CircleAvatar(
                  backgroundImage: (books[index].thumbnail) == ''
                      ? null
                      : NetworkImage(books[index].thumbnail),
                ),
              );
            })));
  }
}
