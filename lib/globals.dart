// ignore_for_file: constant_identifier_names

const String base_url = 'https://mashtoz.org';
const api_url = base_url + '/api/v1';

class Api {
  //Refresh_APIs
  static String get refreshToken => api_url + '/refresh';
  //Login_Signup_Forgot APIs
  static String get loginUrl => api_url + '/login';

  static String get loginOut => api_url + '/logout';

  static String get resgisterUrl => api_url + '/register';

  static String get forgotPassword => api_url + '/forgot-password';

  static String get checkCode => api_url + '/code-check';

  static String get resetPassword => api_url + '/password-reset';

  //Contact API
  static String get contactform => api_url + '/contactform';

  //Favorite_save_&_Favorite_update APIs
  static String get saveFavorite => api_url + '/saveFavorite';

  static String get updateFavorite => api_url + '/updateFavorite';

    //Get Favorite
  static String get getFavorites => api_url + '/getFavorites';
  
  //User_Info API
  static String get userInfo => api_url + '/me';

  //Info APIs
  static String get abaoutUs => api_url + '/getpage/about-us';

  static String get donation => api_url + '/getpage/donation';

  //Menu API
  static String get menu => api_url + '/menu';

//Gallery API
  static String get gallery => api_url + '/galleries';

//Dialect APIs
  static String get dialectCharacters => api_url + '/dialectsCharacters';

  static dialectBYCharacters(caracters) => api_url + '/dialects/$caracters';

//Encyclopedia APIs
  static String get encyclopediasCharacters =>
      api_url + '/encyclopediasCharacters';

  static encyclopediasByCharacters(character) =>
      api_url + '/encyclopedias/$character';

//AudioLibraries APIs
  static String get audioLibrariesCharacters =>
      api_url + '/audilibrariesCharacters';

  static audioLibrariesByCharacters(characters) =>
      api_url + '/audilibraries/$characters';

  //Library_Category APIs
  static String get categoryListUrl => api_url + '/libraries/categoryList';

  static libraryCategoryById(id) => api_url + '/libraries/$id';

  //ItalianLesson API
  static String get italianLessons => api_url + '/lessons';

  //Dictoniary APIs
  static String get italianDictionaryCharacters =>
      api_url + '/italiansCharacters';

  static italianDictionaryByCharacters(character) =>
      api_url + '/italians/$character';

  static String get armenianDictionaryCharacters =>
      api_url + '/armeniansCharacters';

  static armenianDictionaryByCharacters(character) =>
      api_url + '/armenians/$character';

  //Words of Day APIs
  static String get wordsOfDay => api_url + '/wordsofday';
}
