import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<bool> logOut() async {
  // Logout from Instagram
  SharedPreferences pref = await SharedPreferences.getInstance();
  final String creds = pref.getString("creds")!;
  final csrfToken = creds.split("csrftoken=")[1];
  Map<String, String> headers = {
    'User-Agent':
        'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36',
    'Accept': '*/*',
    'Accept-Language': 'en-US,en;q=0.5',
    'X-CSRFToken': csrfToken,
    'X-Instagram-AJAX': '1007229919',
    'X-IG-App-ID': '936619743392459',
    // 'Accept-Encoding': 'gzip, deflate, br',
    'X-ASBD-ID': '198387',
    'X-IG-WWW-Claim': 'hmac.AR2oe-0dhxuCtw-_xLZ0A7MFfTgwaEZ0Rg42iIDwWR_rCxv6',
    'Content-Type': 'application/x-www-form-urlencoded',
    'X-Requested-With': 'XMLHttpRequest',
    'Origin': 'https://www.instagram.com',
    'Alt-Used': 'www.instagram.com',
    'Connection': 'keep-alive',
    'Referer': 'https://www.instagram.com/',
    'Cookie': creds,
    'Sec-Fetch-Dest': 'empty',
    'Sec-Fetch-Mode': 'cors',
    'Sec-Fetch-Site': 'same-origin',
  };
  final String userId = creds.split("ds_user_id=")[1].split(";")[0];
  final encoding = Encoding.getByName('utf-8');
  final Map<String, String> payload = {
    'one_tap_app_login': '0',
    'user_id': userId,
  };
  http.Response response = await http.post(
      Uri.parse('https://www.instagram.com/accounts/logout/'),
      headers: headers,
      body: payload,
      encoding: encoding);
  // var res = jsonDecode(response.body);
  return true;
  // print(jsonDecode(response.body));
}
