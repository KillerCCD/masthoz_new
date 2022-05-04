// import 'package:flutfillter/widgets.dart';
// import 'package:mashtoz_flutter/domens/models/book_data/by_caracters_data.dart';
// import 'package:mashtoz_flutter/domens/repository/book_data_provdier.dart';

// class BookNotifire extends ChangeNotifier {
//   final bookDataProvider = BookDataProvider();
//   List<String>? charctersData;
//   List<ByCharacters>? bookByCharacters;
//   String firstCharacter = '';
//   String get firstCharacters => firstCharacter;

//   bool _isLoading = false;
//   bool get isLoading => _isLoading;
//   List<String>? get dataCharacters => charctersData;

//   Future getBookCharacters(String url) async {
//     notifyListeners();
//     return charctersData =
//         await bookDataProvider.getDialect_Encyclopaedia_Characters(url);
//   }

//   Future<List<ByCharacters>?> getDataByCharacters(String url) async {
//     notifyListeners();
//     return await bookDataProvider.getDataByCharacters(url).then((value) {
//       this.firstCharacter = value.first.firstCharacter;
//       print("charactesr $firstCharacter");
//       notifyListeners();
//       return value;
//     });
//   }

//   void charactersSet(var characters) {
//     firstCharacter = characters;
//   }
// }

// List<String> wordsArm = [
//   'ա',
//   "բ",
//   "գ",
//   "դ",
//   "ե",
//   "զ",
//   "է",
//   "ը",
//   "թ",
//   "ժ",
//   "ի",
//   "լ",
//   "խ",
//   "ծ",
//   "կ",
//   "հ",
//   "ձ",
//   "ղ",
//   "ճ",
//   "մ",
//   "յ",
//   "ն",
//   "շ",
//   "ո",
//   "չ",
//   "պ",
//   "ջ",
//   "ռ",
//   "ս",
//   "վ",
//   "տ",
//   "ր",
//   "ց",
//   "ու",
//   "փ",
//   "ք",
//   "ԵՎ",
//   "Օ",
//   "Ֆ"
// ];
