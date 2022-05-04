import 'dart:convert';
import 'dart:developer';

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

      return (data as List).map((e) => BookCategory.fromJson(e)).toList();
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
    var keyGallery = <dynamic>[];
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
      // List<dynamic> keyGallery = Map.from(data).keys.map((e) => e).toList();
      //  inspect(keyGallery);

      var newElement;
      //  inspect(newElement);

      // newElement.forEach(
      //   (key, value) {
      //     if (value is List) {
      //     } else {
      //       Map.from(value).values.forEach((element) {
      //         //   var newData = Gallery.fromJson(element);
      //       });

      //       print('Is Map');
      //     }
      //   },
      // );
      // newElement.forEach(
      //   (key, value) {
      //     if (value is List) {
      //     } else {
      //       Map.from(value).values.forEach((element) {
      //         //   var newData = Gallery.fromJson(element);
      //         Gallery.fromJson(element);
      //       });

      //       print('Is Map');
      //     }

      //   },
      // );
      Map.from(data).forEach((key, value) {
        MapEntry(
            key,
            (value is List)
                ? galleryList.add(MapEntry(key, value))
                : Map<String, dynamic>.from(value).entries.forEach((element) {
                    var dataf = MapEntry(key, Gallery.fromJson(element.value));
                    galleryList.add(dataf);
                  }));
      });
    } else {
      print("failed");
    }
    //inspect(galleryList);
    return galleryList;
  }

  //Main menu list
  Future<List<Data>?> getMenuList() async {
    var token = await sessionDataProvider.readToken();

    var response = await http.get(
      Uri.parse(Api.menu),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'bearer $token'
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
    var token = await sessionDataProvider.readToken();

    var response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'bearer $token'
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
  Future<List<ByCharacters>> getDataByCharacters(String url) async {
    var token = await sessionDataProvider.readToken();
    var dialects = <ByCharacters>[];

    var response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'bearer $token'
      },
    );
    var body = json.decode(response.body);
    var success = body['success'];
    var datas = body['data'];
    if (success == true) {
      Map.from(datas).values.forEach((element) {
        //print(element);
        var dat = ByCharacters.fromJSon(element);
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
  Future<WordOfDay> getWordOfDay() async {
    var token = await sessionDataProvider.readToken();
    var dialects = WordOfDay(summary: '', author: '');

    var response = await http.get(
      Uri.parse(Api.wordsOfDay),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'bearer $token'
      },
    );
    var body = json.decode(response.body);
    var success = body['success'];
    var datas = body['data'];
    if (success == true) {
      var newData = WordOfDay.fromJson(datas);
      inspect(newData);
      return newData;
    } else {
      print("failed");
      return dialects;
    }
  }

  //Lessons
  Future<List<Lessons>> getLessons() async {
    var token = await sessionDataProvider.readToken();
    var dialects = <Lessons>[];
    try {
      var response = await http.get(
        Uri.parse(Api.italianLessons),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'bearer $token'
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
