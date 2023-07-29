import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:igv2/models/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<ProfileModel> getprofile(String username) async {
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
  String profileUrl =
      "https://www.instagram.com/api/v1/users/web_profile_info/?username=$username";

  http.Response profileResponse =
      await http.get(Uri.parse(profileUrl), headers: headers);

  var response = jsonDecode(profileResponse.body);

  String fullName = response["data"]["user"]["full_name"];
  String bio = response["data"]["user"]["biography"];
  String profilePicture = response["data"]["user"]["profile_pic_url"];
  int followedBy = response["data"]["user"]["edge_followed_by"]["count"];
  int following = response["data"]["user"]["edge_follow"]["count"];
  int postsCount =
      response["data"]["user"]["edge_owner_to_timeline_media"]["count"];

  ProfileModel userProfile = ProfileModel(
      profilePicture: profilePicture,
      username: username,
      bio: bio,
      following: following,
      followedBy: followedBy,
      postsCount: postsCount,
      fullName: fullName);

  return userProfile;
}
