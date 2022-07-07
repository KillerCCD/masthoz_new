import 'dart:convert';


import 'package:mashtoz_flutter/domens/models/book_data/search_data.dart';
import 'package:http/http.dart' as http;
import 'package:mashtoz_flutter/globals.dart';

import '../models/book_data/data.dart';

class SearchBookProvider {
  static Future<List<Search>> fetchAllBooks(String query) async {
    // var searchList = <Search>[];
    var response = await http
        .get(Uri.parse("https://mashtoz.org/api/v1/search?search=$query"));
    //var body =
    if (response.statusCode == 200) {
      List books = json.decode(response.body)['data'];

      // return (books).map((e) => Search.fromJson(e)).where((book) {
      //   final bookName = book.title?.toLowerCase();
      //   inspect(book.title);
      //   //final typeName = book.type.toString();
      //   //final image = book.image;
      //   final searchLover = query.toLowerCase();
      //   return bookName.toString().contains(searchLover);
      // }).toList();
      return (books).map((e) => Search.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  //Navigate Search_reuslt to Screen
  Future<Data?> fetchBook({String? type, int? id}) async {
    var response =
        await http.get(Uri.parse(Api.searchReuslts(type: type, id: id)));

    try {
      if (response.statusCode == 200) {
        var books = json.decode(response.body)['data'];

        return Data.fromJson(books);
      } else {
        return Data();
      }
    } catch (e) {
      throw Exception('Failed to load Data');
    }
  }
}
