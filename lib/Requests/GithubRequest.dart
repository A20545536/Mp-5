// ignore_for_file: non_constant_identifier_names

import 'package:http/http.dart' as http;

class Github {
  final String userName;
  final String url = 'https://api.github.com/';
  static String client_id = 'ea3a28ba65171872505c';
  static String client_secret = 'fb3dff5cba6ce84fcf4d434ac12fcc4b92c415a2';

  final String query = "?client_id=$client_id&client_secret=$client_secret";

  Github(this.userName);

  Future<http.Response> fetchUser() {
    // print('fetching user');
    var hubResponce = http.get(Uri.parse('${url}users/$userName$query'));
    //print(hubResponce);
    return hubResponce;
  }

  Future<http.Response> fetchFollowing() {
    return http.get(Uri.parse('${url}users/$userName/following$query'));
  }

  Future<http.Response> fetchFollowers() {
    return http.get(Uri.parse('${url}users/$userName/followers$query'));
  }
}
