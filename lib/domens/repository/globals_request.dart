// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class GlobalsRequest {
//   Future<T> _makeRequest<T>({
//     required String api,
//   }) async {
//     var url = Uri.parse(api);
//     print("entered");
//     final response = await client
//         .get("http://api.themoviedb.org/3/movie/popular?api_key=$_apiKey");
//     print(response.body.toString());
//     if (response.statusCode == 200) {
//       // If the call to the server was successful, parse the JSON
//       return Generic.fromJson<T, K>(json.decode(response.body));
//     } else {
//       // If that call was not successful, throw an error.
//       throw Exception('Failed to load post');
//     }
//   }
// }
