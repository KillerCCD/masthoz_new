import 'dart:convert';
import 'dart:developer';

import 'package:mashtoz_flutter/domens/fake_book_data.dart';

import 'package:mashtoz_flutter/domens/models/book_data/search_data.dart';
import 'package:http/http.dart' as http;
import '../models/book_data/book.dart';

class SearchBookProvider {
  // Future<List<Search>> fetchBooks() async {
  //   var searchList = <Search>[];
  //   // var response =
  //   //     await http.get(Uri.parse("https://jsonplaceholder.typicode.com/todos"));
  //   // var body = json.decode(response.body);
  //   // if (response.statusCode == 200) {
  //   // var data = body['data'];
  //   //  var newDAta = (data as List).map((e) => Search.fromJson(e)).toList();
  //   // var searchs = json.encode(searchLists);

  //   var data = json.decode(jsonString);
  //   // var newData = (data as List).map((e) => Search.fromJson(e)).where((book) {
  //   //   final bookName = book.title?.toLowerCase();
  //   //   //final typeName = book.type.typeName?.toLowerCase();
  //   //   // final contetBodyName =
  //   //   //     book.type.content?.values.map((e) => e.body).toString();
  //   //   final searchLower = query.toLowerCase();
  //   //   if (bookName!.contains(searchLower)) {
  //   //     return true;
  //   //   } else {
  //   //     return false;
  //   //   }
  //   // }).toList();
  //   // inspect(newData);
  //   //  var newData = searchLists;
  //   //  searchList.addAll(datas);
  //   //return searchList;
  //   //  }
  //   // var newData = (data).map((e) => Search.fromJson(e)).toList();
  //   var query = 'A1';
  //   Map.from(data).forEach((key, value) {
  //     //if (key.toString().contains(Map.from(value).values.first.toString())) {
  //     for (var i = 0; i < (Map.from(data).length); i++) {
  //       print('DADAS${data["book"]![i]}');
  //     }

  //     // }
  //   });
  //   var kiki = Search.fromJson(data);
  //   inspect(kiki);
  //   return searchList;
  // }
  static Future<List<Book>> getBooks(String query) async {
    final url = Uri.parse(
        'https://gist.githubusercontent.com/JohannesMilke/d53fbbe9a1b7e7ca2645db13b995dc6f/raw/eace0e20f86cdde3352b2d92f699b6e9dedd8c70/books.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List books = json.decode(response.body);

      return books.map((json) => Book.fromJson(json)).where((book) {
        final titleLower = book.title.toLowerCase();
        final authorLower = book.author.toLowerCase();
        final searchLower = query.toLowerCase();

        return titleLower.contains(searchLower) ||
            authorLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}
