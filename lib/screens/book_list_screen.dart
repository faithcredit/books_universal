import 'package:flutter/material.dart';
import '../models/book.dart';
import '../data/http_helper.dart';

class BookListScreen extends StatefulWidget {
  const BookListScreen({super.key});
  @override
  State<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  final HttpHelper helper = HttpHelper();
  List<Book> books = [];
  List<Color> bgColors = [];

  @override
  void initState() {
    super.initState();
    helper.getBooks('flutter').then((List<Book> value) {
      int i;
      for (i = 0; i < value.length; i++) {
        bgColors.add(Colors.white);
      }

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
              return GestureDetector(
                onTap: () => setColor(Colors.lightBlue, index),
                onSecondaryTap: () => setColor(Colors.white, index),
                onLongPress: () => setColor(Colors.white, index),
                child: ColoredBox(
                  color: bgColors.isNotEmpty ? bgColors[index] : Colors.white,
                  child: ListTile(
                    title: Text(books[index].title),
                    subtitle: Text(books[index].authors),
                    leading: CircleAvatar(
                      backgroundImage: (books[index].thumbnail) == ''
                          ? null
                          : NetworkImage(books[index].thumbnail),
                    ),
                  ),
                ),
              );
            })));
  }

  void setColor(Color color, int index) {
    setState(() {
      bgColors[index] = color;
    });
  }
}
