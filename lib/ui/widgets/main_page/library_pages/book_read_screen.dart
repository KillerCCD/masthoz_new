import 'package:flutter/material.dart';

class BookReadScreen extends StatefulWidget {
  const BookReadScreen({Key? key}) : super(key: key);

  @override
  State<BookReadScreen> createState() => _BookReadScreenState();
}

class _BookReadScreenState extends State<BookReadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PageView(
          children: [
            Container(
              child: Center(
                child: Text('Page1'),
              ),
              color: Colors.red,
            ),
            Container(
                child: Center(
                  child: Text('Page1'),
                ),
                color: Colors.blue),
            Container(
                child: Center(
                  child: Text('Page2'),
                ),
                color: Colors.orange),
            Container(
                child: Center(
                  child: Text('Page3'),
                ),
                color: Colors.pink),
            Container(
                child: Center(
                  child: Text('Page4'),
                ),
                color: Colors.cyan),
          ],
        ),
      ),
    );
  }
}
