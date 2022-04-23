import 'models/book_data/book.dart';

const books = [
  Book(
      bookName: 'ՍՈՒՐԲ ՀՈԳՈՒՆ \nՆՎԻՐՎԱԾ ԱՂՈԹՔՆԵՐ',
      title: 'ՍՈՒՐԲ ՀՈԳՈՒՆ',
      imageUrl: 'https://source.unsplash.com/user/c_v_r/100x100',
      body: 'ՏԵՐ'),
  Book(
      bookName: 'ՏԵՐ ՀԻՍՈՒՍ \nՔՐԻՍՏՈՍԻՆ \nՆՎԻՐՎԱԾ ԱՂՈԹՔՆԵՐ',
      title: 'ՍՈՒՐԲ ՀՈԳՈՒՆ',
      imageUrl: 'https://source.unsplash.com/user/c_v_r/100x100',
      body: 'ՍՈՒՐԲ'),
  Book(
      bookName: 'ՀԻՍՈՒՍԻ ՍՈՒՐԲ \nՍՐՏԻՆ ՆՎԻՐՎԱԾ \nԱՂՈԹՔՆԵՐ',
      title: 'ՍՈՒՐԲ ՀՈԳՈՒՆ',
      imageUrl: 'https://source.unsplash.com/user/c_v_r/100x100',
      body: ''),
  Book(
      bookName: 'ՍՈՒՐԲ ՊԱՏԱՐԱԳԻ \nԽՈՐՀՐԴԱԾՈՒԹՅՈՒՆ \nՆԵՐ',
      title: 'ՍՈՒՐԲ ՀՈԳՈՒՆ',
      imageUrl: 'https://source.unsplash.com/user/c_v_r/100x100',
      body: 'ԿՈՒՅՍ'),
  Book(
      bookName: 'ՍՈՒՐԲ ԿՈՒՅՍ ՄԱՐԻԱՄ \nԱՍՏՎԱԾԱԾՆԻՆ \nՆՎԻՐՎԱԾ ԱՂՈԹՔՆԵՐ',
      title: 'ՍՈՒՐԲ ՀՈԳՈՒՆ',
      imageUrl: 'https://source.unsplash.com/user/c_v_r/100x100',
      body: 'ՊԱՏԱՐԱԳԻ'),
  Book(
      bookName: 'ՍՈՒՐԲ ՀՈՎՍԵՓ \nԱՍՏՎԱԾԱՀՈՐԸ \nՆՎԻՐՎԱԾ ԱՂՈԹՔՆԵՐ',
      title: 'ՍՈՒՐԲ ՀՈԳՈՒՆ',
      imageUrl: 'https://source.unsplash.com/user/c_v_r/100x100',
      body: 'ՀՈՎՍԵՓ'),
  Book(
      bookName: 'ՍՈՒՐԲ ՀՈՎՍԵՓ \nԱՍՏՎԱԾԱՀՈՐԸ \nՆՎԻՐՎԱԾ ԱՂՈԹՔՆԵՐ',
      title: 'ՍՈՒՐԲ ՀՈԳՈՒՆ',
      imageUrl: 'https://picsum.photos/200/300',
      body: 'ԱՍՏՎԱԾԱԾՆԻՆ'),
];
String jsonString = '''{  
    
    "book":{
        "id":2,
        "type":"book",
   "title": "title",
   "image_url": "https://ddlfdskldfkalsdfdfj",
        "content":{
           "author": "A1",
           "body": "AaaaaA1dddd"
        }
    },
    "dzaynadaran":{
        
        "id":2,
          "type":"dzaynadaran",
   "title": "title",
   "image_url": "https://ddlfdskldfkalsdfdfj",
        "content":{
           "author": "A1",
           "body": "AaaaaA1dddd"
        }
    },
     "bararan":{
        "id":2,
        "type":"bararan",
   "title": "title",
   "image_url": "https://ddlfdskldfkalsdfdfj",
        "content":{
           "author": "A1",
           "body": "AaaaaA1dddd"
        }
    }
    
}''';

List<Gellerys> galleryItems = [
  Gellerys(
    id: "tag1",
    resource: "assets/images/gallery1.jpg",
  ),
  Gellerys(id: "tag2", resource: "assets/images/gallery3.jpg"),
  Gellerys(
    id: "tag3",
    resource: "assets/images/gallery2.jpg",
  ),
  Gellerys(
    id: "tag4",
    resource: "assets/images/gallery3.jpg",
  ),
];
