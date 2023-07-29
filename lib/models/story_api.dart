import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:igv2/models/mentions_model.dart';
import 'package:igv2/models/story_model.dart';
import 'package:igv2/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Story>?> getStory(String username) async {
  String? cookies = "";
  SharedPreferences pref = await SharedPreferences.getInstance();
  cookies = pref.getString('creds');
  Map<String, String> headers = {
    'Accept': '*/*',
    'Host': 'www.instagram.com',
    'User-Agent':
        'Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0',
    'Accept-Language': 'en-US,en;q=0.5',
    'Accept-Encoding': 'gzip, deflate, br',
    'X-IG-App-ID': '936619743392459',
    'X-ASBD-ID': '198387',
    'X-IG-WWW-Claim': '0',
    'X-Requested-With': 'XMLHttpRequest',
    'Alt-Used': 'www.instagram.com',
    'Connection': 'keep-alive',
    'Cookie': cookies!,
    'Sec-Fetch-Dest': 'empty',
    'Sec-Fetch-Mode': 'cors',
    'Sec-Fetch-Site': 'same-origin',
  };
//get target account's profile id.
  String accUrl = "https://www.instagram.com/$username/?__a=1";
  http.Response acc = await http.get(Uri.parse(accUrl));
  String accID = acc.body.split('"profile_id":"')[1].split('"')[0];
  http.Response story = await http.get(
      Uri.parse(
          "https://www.instagram.com/api/v1/feed/reels_media/?reel_ids=$accID"),
      headers: headers);
  //The function will return a list of stories
  List<Story>? stories = [];
  //the mentions is a subtype that will be added to the Story model if there is any
  //check if there are stories
  if (jsonDecode(story.body)['reels_media'].length == 0) {
    return stories;
  }
  //prepare user
  String name = jsonDecode(story.body)["reels"][accID]["user"]["username"];
  String profileImageUrl =
      jsonDecode(story.body)["reels"][accID]["user"]["profile_pic_url"];
  User user = User(name: name, profileImageUrl: profileImageUrl);
  //preparing the model
  for (Map<String, dynamic> i in jsonDecode(story.body)['reels_media'][0]
      ['items']) {
    List<Mentions> mentions = [];
    //check if story is a video
    if (i.containsKey("video_versions")) {
      String url = i["video_versions"][0]["url"];

      DateTime date =
          DateTime.fromMillisecondsSinceEpoch((i["taken_at"] as int) * 1000);
      if (i.containsKey("story_bloks_stickers")) {
        for (Map<String, dynamic> m in i["story_bloks_stickers"]) {
          String mentionedUser =
              m["bloks_sticker"]["sticker_data"]["ig_mention"]["username"];
          String mentionedName =
              m["bloks_sticker"]["sticker_data"]["ig_mention"]["full_name"];
          String mentionedPic = m["bloks_sticker"]["sticker_data"]["ig_mention"]
              ["profile_pic_url"];
          mentions.add(Mentions(
              mentionedUser: mentionedUser,
              mentionedName: mentionedName,
              mentionedPic: mentionedPic));
        }
      }
      stories.add(
        Story(
            url: url,
            media: MediaType.video,
            duration: const Duration(seconds: 10),
            user: user,
            date: date,
            mentions: mentions),
      );
    } else {
      //if story is image
      DateTime date =
          DateTime.fromMillisecondsSinceEpoch((i["taken_at"] as int) * 1000);
      String url = i["image_versions2"]["candidates"][0]["url"];

      if (i.containsKey("story_bloks_stickers")) {
        for (Map<String, dynamic> m in i["story_bloks_stickers"]) {
          String mentionedUser =
              m["bloks_sticker"]["sticker_data"]["ig_mention"]["username"];
          String mentionedName =
              m["bloks_sticker"]["sticker_data"]["ig_mention"]["full_name"];
          String mentionedPic = m["bloks_sticker"]["sticker_data"]["ig_mention"]
              ["profile_pic_url"];
          mentions.add(Mentions(
              mentionedUser: mentionedUser,
              mentionedName: mentionedName,
              mentionedPic: mentionedPic));
        }
      }
      stories.add(
        Story(
          url: url,
          media: MediaType.image,
          duration: const Duration(seconds: 10),
          user: user,
          date: date,
          mentions: mentions,
        ),
      );
    }
  }
  // print(stories[1].user.profileImageUrl);
  return stories;
}
