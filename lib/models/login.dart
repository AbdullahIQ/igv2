// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginHandle {
  // Prefs(String val) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   pref.getString(val);
  // }

  setPrefs(String creds, String username) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('creds', creds);
    pref.setString('username', username);
  }

  Future<bool> login(String username, String password) async {
    //API Dependencies
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    String loginUrl = 'https://www.instagram.com/accounts/login/ajax/';
    http.Response csr = await http.get(Uri.parse(loginUrl));
    String csrf = csr.headers['set-cookie']!.split(';')[0].split('=')[1];
    String timeNow = timestamp.toString().replaceRange(10, null, '');
    final encoding = Encoding.getByName('utf-8');
    http.Response acc =
        await http.get(Uri.parse("https://www.instagram.com/$username/?__a=1"));
    String accID;
    try {
      accID = acc.body.split('"profile_id":"')[1].split('"')[0];
    } catch (e) {
      return false;
    }
    //Post payload
    Map<String, String> payload = {
      'username': username,
      'enc_password': '#PWD_INSTAGRAM_BROWSER:0:$timeNow:$password',
      'queryParams': '{}',
      'optIntoOneTap': 'false',
      'trustedDeviceRecords': '{}'
    };
    //Post headers
    Map<String, String> headers = {
      'authority': 'www.instagram.com',
      'accept': '*/*',
      'accept-language': 'en-US,en;q=0.9',
      'cookie': 'ds_user_id=$accID',
      'origin': 'https://www.instagram.com',
      'referer': 'https://www.instagram.com/',
      'sec-ch-prefers-color-scheme': 'light',
      'sec-ch-ua':
          '"Not_A Brand";v="99", "Google Chrome";v="109", "Chromium";v="109"',
      'sec-ch-ua-mobile': '?0',
      'sec-ch-ua-platform': '"Linux"',
      'sec-fetch-dest': 'empty',
      'sec-fetch-mode': 'cors',
      'sec-fetch-site': 'same-origin',
      'user-agent':
          'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36',
      'viewport-width': '867',
      'x-asbd-id': '198387',
      'x-csrftoken': csrf,
      'x-ig-app-id': '936619743392459',
      'x-ig-www-claim': '0',
      'x-instagram-ajax': '1006867207',
      'x-requested-with': 'XMLHttpRequest',
    };
    //Do post call
    http.Response response = await http.post(Uri.parse(loginUrl),
        headers: headers, body: payload, encoding: encoding);

    var res = jsonDecode(response.body);
    print(res);
    if (res["authenticated"] == false) {
      return false;
    } else {
      //Get session's Creds
      String sessionid =
          "sessionid=${response.headers['set-cookie']!.split('sessionid=')[1].split(';')[0]};";
      String dsUserId =
          "ds_user_id=${response.headers['set-cookie']!.split("ds_user_id=")[1].split(';')[0]};";
      String csrftoken = "csrftoken=$csrf";
      String creds = sessionid + dsUserId + csrftoken;
      setPrefs(creds, username);
      return true;
    }
  }
}
