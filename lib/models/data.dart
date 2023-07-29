import 'package:igv2/models/story_model.dart';
import 'package:igv2/models/user_model.dart';

const User user = User(
    name: "Shsho",
    profileImageUrl:
        "https://instagram.fbgw41-5.fna.fbcdn.net/v/t51.2885-19/329022303_178977061158289_1279320722366143691_n.jpg?stp=dst-jpg_s150x150&_nc_ht=instagram.fbgw41-5.fna.fbcdn.net&_nc_cat=1&_nc_ohc=8zeSTeNl8VQAX98sWWB&edm=ACWDqb8BAAAA&ccb=7-5&oh=00_AfAVvAs3EtfdnLYFXCQ-NDF1T0nbbxEXjqLJ42xTaqAiIQ&oe=642EE98D&_nc_sid=1527a3");
List<Story> stories = [
  Story(
      url:
          "https://instagram.fnjf4-2.fna.fbcdn.net/v/t51.2885-15/338370207_2361532204046909_5336258643789702080_n.jpg?stp=dst-jpg_e35&_nc_ht=instagram.fnjf4-2.fna.fbcdn.net&_nc_cat=1&_nc_ohc=oycSjRj6a9sAX_nOaED&edm=ANmP7GQBAAAA&ccb=7-5&ig_cache_key=MzA2OTM5NDg2Mjg1MjI0NDI3Mw%3D%3D.2-ccb7-5&oh=00_AfCX9TCTNE2BQrlkSZ3pFIC8gYlZtZNdrIy3E7DXja3D0g&oe=642636C7&_nc_sid=276363",
      media: MediaType.image,
      duration: const Duration(seconds: 5),
      user: user,
      date: DateTime.fromMillisecondsSinceEpoch(1680414718 * 1000),
      mentions: []),
  Story(
      url:
          "https://instagram.fnjf4-2.fna.fbcdn.net/v/t51.2885-15/338704839_915993872983756_4365897096147273659_n.jpg?stp=dst-jpg_e35&_nc_ht=instagram.fnjf4-2.fna.fbcdn.net&_nc_cat=1&_nc_ohc=njlftDXyPoYAX8I_r_U&edm=ANmP7GQBAAAA&ccb=7-5&ig_cache_key=MzA2OTQwMjE1ODg3NzQ2NjM4NA%3D%3D.2-ccb7-5&oh=00_AfC9cl69dJRTTbowi5VRvKvswynmhK2sdeSC6389iHl91A&oe=64269D69&_nc_sid=276363",
      media: MediaType.image,
      duration: const Duration(seconds: 10),
      user: user,
      date: DateTime.fromMillisecondsSinceEpoch(1680369048 * 1000),
      mentions: []),
  Story(
      url:
          "https://instagram.fbgw41-6.fna.fbcdn.net/o1/v/t16/f1/m78/B34209A16802B65DB3549051497C8CA8_video_dashinit.mp4?efg=eyJxZV9ncm91cHMiOiJbXCJpZ193ZWJfZGVsaXZlcnlfdnRzX290ZlwiXSIsInZlbmNvZGVfdGFnIjoidnRzX3ZvZF91cmxnZW4uNzIwLnN0b3J5LmJhc2VsaW5lIn0&_nc_ht=instagram.fbgw41-6.fna.fbcdn.net&_nc_cat=109&vs=971007053890830_3135126462&_nc_vs=HBksFQIYUWlnX3hwdl9wbGFjZW1lbnRfcGVybWFuZW50X3YyL0IzNDIwOUExNjgwMkI2NURCMzU0OTA1MTQ5N0M4Q0E4X3ZpZGVvX2Rhc2hpbml0Lm1wNBUAAsgBABUAGCRHQU52SFJUdjJFVlRYNlVBQUdFVFd4d3JkMGw2YnBrd0FBQUYVAgLIAQAoABgAGwGIB3VzZV9vaWwBMRUAACagiJrrx8u7PxUCKAJDMywXQDD3S8an754YEmRhc2hfYmFzZWxpbmVfMV92MREAdegHAA%3D%3D&ccb=9-4&oh=00_AfDsmdWBj7A6PjnsjWv-6-17CM3xrh-bMlgTdSxkr5PVWQ&oe=642BFDE8&_nc_sid=276363",
      media: MediaType.video,
      duration: const Duration(seconds: 20),
      user: user,
      date: DateTime.fromMillisecondsSinceEpoch(1680453165 * 1000),
      mentions: []),

  Story(
    url:
        "https://instagram.fnjf4-2.fna.fbcdn.net/v/t51.2885-15/338370207_2361532204046909_5336258643789702080_n.jpg?stp=dst-jpg_e35&_nc_ht=instagram.fnjf4-2.fna.fbcdn.net&_nc_cat=1&_nc_ohc=oycSjRj6a9sAX_nOaED&edm=ANmP7GQBAAAA&ccb=7-5&ig_cache_key=MzA2OTM5NDg2Mjg1MjI0NDI3Mw%3D%3D.2-ccb7-5&oh=00_AfCX9TCTNE2BQrlkSZ3pFIC8gYlZtZNdrIy3E7DXja3D0g&oe=642636C7&_nc_sid=276363",
    media: MediaType.image,
    duration: Duration(seconds: 10),
    user: user,
    mentions: [],
    date: DateTime.fromMillisecondsSinceEpoch(1680453165 * 1000),
  ),
  // Story(
  //     url:
  //         "https://instagram.fnjf4-2.fna.fbcdn.net/v/t51.2885-15/338704839_915993872983756_4365897096147273659_n.jpg?stp=dst-jpg_e35&_nc_ht=instagram.fnjf4-2.fna.fbcdn.net&_nc_cat=1&_nc_ohc=njlftDXyPoYAX8I_r_U&edm=ANmP7GQBAAAA&ccb=7-5&ig_cache_key=MzA2OTQwMjE1ODg3NzQ2NjM4NA%3D%3D.2-ccb7-5&oh=00_AfC9cl69dJRTTbowi5VRvKvswynmhK2sdeSC6389iHl91A&oe=64269D69&_nc_sid=276363",
  //     media: MediaType.image,
  //     duration: Duration(seconds: 10),
  //     user: user),
  // Story(
  //     url:
  //         "https://instagram.fnjf4-2.fna.fbcdn.net/v/t51.2885-15/338370207_2361532204046909_5336258643789702080_n.jpg?stp=dst-jpg_e35&_nc_ht=instagram.fnjf4-2.fna.fbcdn.net&_nc_cat=1&_nc_ohc=oycSjRj6a9sAX_nOaED&edm=ANmP7GQBAAAA&ccb=7-5&ig_cache_key=MzA2OTM5NDg2Mjg1MjI0NDI3Mw%3D%3D.2-ccb7-5&oh=00_AfCX9TCTNE2BQrlkSZ3pFIC8gYlZtZNdrIy3E7DXja3D0g&oe=642636C7&_nc_sid=276363",
  //     media: MediaType.image,
  //     duration: Duration(seconds: 10),
  //     user: user),
  // Story(
  //     url:
  //         "https://instagram.fnjf4-2.fna.fbcdn.net/v/t51.2885-15/338704839_915993872983756_4365897096147273659_n.jpg?stp=dst-jpg_e35&_nc_ht=instagram.fnjf4-2.fna.fbcdn.net&_nc_cat=1&_nc_ohc=njlftDXyPoYAX8I_r_U&edm=ANmP7GQBAAAA&ccb=7-5&ig_cache_key=MzA2OTQwMjE1ODg3NzQ2NjM4NA%3D%3D.2-ccb7-5&oh=00_AfC9cl69dJRTTbowi5VRvKvswynmhK2sdeSC6389iHl91A&oe=64269D69&_nc_sid=276363",
  //     media: MediaType.image,
  //     duration: Duration(seconds: 10),
  //     user: user),
  // Story(
  //     url:
  //         "https://instagram.fnjf4-2.fna.fbcdn.net/v/t51.2885-15/338370207_2361532204046909_5336258643789702080_n.jpg?stp=dst-jpg_e35&_nc_ht=instagram.fnjf4-2.fna.fbcdn.net&_nc_cat=1&_nc_ohc=oycSjRj6a9sAX_nOaED&edm=ANmP7GQBAAAA&ccb=7-5&ig_cache_key=MzA2OTM5NDg2Mjg1MjI0NDI3Mw%3D%3D.2-ccb7-5&oh=00_AfCX9TCTNE2BQrlkSZ3pFIC8gYlZtZNdrIy3E7DXja3D0g&oe=642636C7&_nc_sid=276363",
  //     media: MediaType.image,
  //     duration: Duration(seconds: 10),
  //     user: user),
  // Story(
  //     url:
  //         "https://instagram.fnjf4-2.fna.fbcdn.net/v/t51.2885-15/338704839_915993872983756_4365897096147273659_n.jpg?stp=dst-jpg_e35&_nc_ht=instagram.fnjf4-2.fna.fbcdn.net&_nc_cat=1&_nc_ohc=njlftDXyPoYAX8I_r_U&edm=ANmP7GQBAAAA&ccb=7-5&ig_cache_key=MzA2OTQwMjE1ODg3NzQ2NjM4NA%3D%3D.2-ccb7-5&oh=00_AfC9cl69dJRTTbowi5VRvKvswynmhK2sdeSC6389iHl91A&oe=64269D69&_nc_sid=276363",
  //     media: MediaType.image,
  //     duration: Duration(seconds: 10),
  //     user: user),
  // Story(
  //     url:
  //         "https://instagram.fnjf4-2.fna.fbcdn.net/v/t51.2885-15/338370207_2361532204046909_5336258643789702080_n.jpg?stp=dst-jpg_e35&_nc_ht=instagram.fnjf4-2.fna.fbcdn.net&_nc_cat=1&_nc_ohc=oycSjRj6a9sAX_nOaED&edm=ANmP7GQBAAAA&ccb=7-5&ig_cache_key=MzA2OTM5NDg2Mjg1MjI0NDI3Mw%3D%3D.2-ccb7-5&oh=00_AfCX9TCTNE2BQrlkSZ3pFIC8gYlZtZNdrIy3E7DXja3D0g&oe=642636C7&_nc_sid=276363",
  //     media: MediaType.image,
  //     duration: Duration(seconds: 10),
  //     user: user),
  // Story(
  //     url:
  //         "https://instagram.fnjf4-2.fna.fbcdn.net/v/t51.2885-15/338704839_915993872983756_4365897096147273659_n.jpg?stp=dst-jpg_e35&_nc_ht=instagram.fnjf4-2.fna.fbcdn.net&_nc_cat=1&_nc_ohc=njlftDXyPoYAX8I_r_U&edm=ANmP7GQBAAAA&ccb=7-5&ig_cache_key=MzA2OTQwMjE1ODg3NzQ2NjM4NA%3D%3D.2-ccb7-5&oh=00_AfC9cl69dJRTTbowi5VRvKvswynmhK2sdeSC6389iHl91A&oe=64269D69&_nc_sid=276363",
  //     media: MediaType.image,
  //     duration: Duration(seconds: 10),
  //     user: user),
];
