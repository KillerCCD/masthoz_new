import 'dart:convert';
import 'dart:developer';
import 'dart:math';

import 'package:http/http.dart' as http;

import 'package:mashtoz_flutter/domens/data_providers/session_data_provider.dart';
import 'package:mashtoz_flutter/domens/models/book_data/book.dart';
import 'package:mashtoz_flutter/domens/models/book_data/category_lsit.dart';
import 'package:mashtoz_flutter/domens/models/book_data/gallery_data.dart';
import 'package:mashtoz_flutter/domens/models/book_data/lessons.dart';
import 'package:mashtoz_flutter/domens/models/book_data/word_of_day.dart';

import '../../globals.dart';
import '../models/book_data/by_caracters_data.dart';
import '../models/book_data/content_list.dart';
import '../models/book_data/data.dart';

class BookDataProvider {
  final sessionDataProvider = SessionDataProvider();

  //Fetch Category List
  Future<List<BookCategory>> getCategoryLists(String url) async {
    var libraryList = <BookCategory>[];
    //   try {
    var response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );

    var body = json.decode(response.body);

    var success = body['success'];
    if (success == true) {
      var data = body['data'];
      sessionDataProvider.setShowMenuList([
        (data as List).map((e) => BookCategory.fromJson(e)).toList().toString()
      ]);
      return (data).map((e) => BookCategory.fromJson(e)).toList();

      // print(newData);
      // libraryList.addAll(newData);
    } else {
      print("failed");
    }
    return libraryList;
  }

  //Fetch Library Book By Id
  Future<List<Content>> getLibrarayYbooksById(int idCategory) async {
    var libraryList = <Content>[];
    try {
      var response = await http.get(
        Uri.parse(Api.libraryCategoryById(idCategory)),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );

      var body = json.decode(response.body);

      var success = body['success'];
      if (success == true) {
        // print('succes');
        var content = body['data']['content'];
        print('getoteorfkldfk : ${content.runtimeType}');
        Map.from(content).forEach((key, value) {
          if (key
              .toString()
              .contains(Map.from(value).values.first.toString())) {
            var data = Content.fromJson(value);

            libraryList.add(data);
            print("kEEEEEEEEEEEEEEEEEEEEEEY::${key}");
          }
        });
      } else {
        print("failed");
      }
    } catch (e) {
      print(e);
    }
    return libraryList;
  }

  //Fetch Gallery List
  Future<List<dynamic>> fetchGalleryList() async {
    var galleryList = <dynamic>[];

    try {
      var response = await http.get(
        Uri.parse(Api.gallery),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );

      var body = json.decode(response.body);

      var success = body['success'];
      if (success == true) {
        var data = body['data'];
        Map.from(data).forEach((key, value) {
          (value is List)
              ? galleryList.add([key, value])
              : Map<String, dynamic>.from(value).forEach((key2, value2) {
                  var dataf = [key, Gallery.fromJson(value2)];

                  galleryList.add(dataf);
                });
        });
      }
    } catch (e) {
      print(e);
    }

    inspect(galleryList);
    return galleryList;
  }
  //     Map.from(data).forEach((key, value) => galleryList.add(value is List
  //         ? value
  //         : Map.from(value)
  //             .map((key, value) => MapEntry(key, Gallery.fromJson(value)))));
  //     inspect(galleryList);
  //   } else {
  //     print("failed");
  //   }
  //   //inspect(galleryList);
  //   return galleryList;
  // }

  //Main menu list
  Future<List<Data>?> getMenuList() async {
    var response = await http.get(
      Uri.parse(Api.menu),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    var body = json.decode(response.body);
    var success = body['success'];
    var datas = body['data'];
    if (success == true) {
      return (datas as List).map((e) => Data.fromJson(e)).toList();
    } else {
      print("failed");
    }
    return null;
  }

  //Dialect Character
  Future<List<String>> getDialect_Encyclopaedia_Characters(String url) async {
    var response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    var body = json.decode(response.body);
    var success = body['success'];
    var datas = body['data'];

    if (success == true) {
      var dat = List<String>.from(datas.map((x) => x)).toList();
      inspect(dat);
      return dat;
    } else {
      print("failed");
    }
    return [];
  }

  //Data by characters
  Future<List<Data>> getDataByCharacters(String url) async {
    var dialects = <Data>[];

    var response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    var body = json.decode(response.body);
    var success = body['success'];
    var datas = body['data'];
    if (success == true) {
      Map.from(datas).values.forEach((element) {
        //print(element);
        var dat = Data.fromJson(element);
        dialects.add(dat);
      });
      inspect(dialects);
      return dialects;
    } else {
      print("failed");
    }
    return dialects;
  }

  //Words of Day
  Future<WordOfDay?> getWordsOfDay() async {
    var response = await http.get(
      Uri.parse(Api.wordsOfDay),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    var body = json.decode(response.body);
    var success = body['success'];
    var datas = body['data'];
    if (success == true && response.statusCode == 200) {
      var newData = WordOfDay.fromJson(datas);
      inspect(newData);
      return newData;
    } else {
      print("failed");
      return null;
    }
  }

  //Lessons
  Future<List<Lessons>> getLessons() async {
    var dialects = <Lessons>[];
    try {
      var response = await http.get(
        Uri.parse(Api.italianLessons),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      var body = json.decode(response.body);
      var success = body['success'];
      var datas = body['data'];
      if (success == true) {
        var dialects = List.from(datas)
            .map(
              (e) => Lessons.fromJson(e),
            )
            .toList();
        inspect(dialects);
        return dialects;
      } else {
        print("failed");
        return dialects;
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
