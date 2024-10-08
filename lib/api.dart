import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';

final String urlStart = 'https://rociscore.ru/api/v1/';

Future<String> getToken() async {
  final token = await storage.read(key: 'auth_token');
  if (token == null) {
    return '';
  }
  return token;
}


Future<Response> try_to_get_registration_token(
    String name, String phone) async {
  final body = {'username': name, "phone": phone};

  final jsonString = json.encode(body);
  final response = await post(
      Uri.parse('https://rociscore.ru/api/v1/auth/user/get_token'),
      body: jsonString,
      headers: {
        'Content-Type': 'application/json',
        'charset': 'UTF-8',
      });
  return response;
}

Future<Response> try_to_get_reset_token(String phone) async {
  final body = {"phone": phone};
  final jsonString = json.encode(body);
  final response = await post(
      Uri.parse(
          'https://rociscore.ru/api/v1/auth/user/send_update_password_code'),
      body: jsonString,
      headers: {
        'Content-Type': 'application/json',
        'charset': 'UTF-8',
      });
  return response;
}

Future<Response> get_token(String phone, String password) async {
  final body = {'password': password, "phone": phone};

  final jsonString = json.encode(body);
  final response = await post(
      Uri.parse('https://rociscore.ru/auth/token/login'),
      body: jsonString,
      headers: {
        'Content-Type': 'application/json',
        'charset': 'UTF-8',
      });
  return response;
}

final storage = FlutterSecureStorage();

Future<void> saveToken(String token) async {
  // final storage = FlutterSecureStorage();
  await storage.write(key: 'auth_token', value: token);
}

Future<void> delete_token() async {
  await storage.delete(key: 'auth_token');
}

// https://rociscore.ru/auth/token/logout/
Future<Response> logout() async {
  final token = await getToken();
  var response = post(Uri.parse('https://rociscore.ru/auth/token/logout/'),
      headers: {
        'Content-Type': 'text/html',
        'charset': 'UTF-8',
        'Authorization': "Token $token"
      });
  delete_token();
  return response;
}

Future<Response> check_token(String token) async {
  var response = await get(Uri.parse('https://rociscore.ru/api/v1/auth/user/'),
      headers: {
        'Content-Type': 'text/html',
        'charset': 'UTF-8',
        'Authorization': "Token $token"
      });
  return response;
}

Future<Response> try_to_register(Map<String, String> data) async {
  final body = {
    'username': data['username'],
    "phone": data['phone'],
    "password": data['password'],
    'code': data['code'],
    'new_city': data['city'],
    "re_password": data['password']
  };
  final jsonString = json.encode(body);
  final response = await post(
      Uri.parse('https://rociscore.ru/api/v1/auth/user/check_token'),
      body: jsonString,
      headers: {
        'Content-Type': 'application/json',
        'charset': 'UTF-8',
      });
  return response;
}

Future<Response> try_to_reset_password(
    String phone, String password, String code) async {
  final body = {
    "phone": phone,
    "password": password,
    'code': code,
  };
  final jsonString = json.encode(body);
  final response = await post(
      Uri.parse(
          'https://rociscore.ru/api/v1/auth/user/check_update_password_code'),
      body: jsonString,
      headers: {
        'Content-Type': 'application/json',
        'charset': 'UTF-8',
      });
  return response;
}

List<dynamic> convert_snapshot_to_list(var snapshot) {
  var data = jsonDecode(utf8.decode(snapshot.data.bodyBytes).toString());
  return data['data'];
}

Map<String, dynamic> convert_snapshot_to_map(var snapshot) {
  var data = jsonDecode(utf8.decode(snapshot.data.bodyBytes).toString());
  return (data);
}

Map<String, dynamic> convert_response_to_map(Response response) {
  var data = jsonDecode(utf8.decode(response.bodyBytes).toString());
  return (data);
}

Future<Response> get_user_data() async {
  final token = await getToken();
  final response = await get(
      Uri.parse('${urlStart}auth/user/'),
      headers: {'Authorization': "Token $token"});
  return response;
}


Future<dynamic> getContests () async {
  final token = await getToken();
  if (token != '') {
    final response = await get(Uri.parse('${urlStart}contests/'),
        headers: {'Authorization': 'Token $token'});

    return response;
  }
  else{
    final response = await get(Uri.parse('${urlStart}contests/'));

    return response;
  }
}


Future<dynamic> getArchive () async {
  final response = await get(Uri.parse('${urlStart}contests/?archieve=yes'));

  return response;
}

Future<dynamic> getContest (String id) async {
  final token = await getToken();
  final response = await get(Uri.parse('${urlStart}contests/$id/'),headers: {'Authorization':'Token $token'});
  return response;
}


Future<dynamic> getCasts () async {
  final token = await getToken();
  final response = await get(Uri.parse('${urlStart}casts/'),headers: {'Authorization':'Token $token'});
  return response;
}


Future<dynamic> getCast (String id) async {
  final token = await getToken();
  final response = await get(Uri.parse('${urlStart}casts/$id/'),headers: {'Authorization':'Token $token'});
  return response;
}

Future<Response> sendCast(String contestId,String cast) async {
  final body = {
    'prognoz':cast
  };
  final token = await getToken();
  final jsonString = json.encode(body);
  final response = await post(
      Uri.parse('${urlStart}contests/$contestId/'),
      body: jsonString,
      headers: {
        'Content-Type': 'application/json',
        'charset': 'UTF-8',
        'Authorization':"Token $token"
      });
  return response;
}


Future<Response> sendSupport(String theme,String text) async {
  final body = {
    'theme':theme,
    'text':text
  };
  final token = await getToken();
  final jsonString = json.encode(body);
  final response = await post(
      Uri.parse('${urlStart}support/'),
      body: jsonString,
      headers: {
        'Content-Type': 'application/json',
        'charset': 'UTF-8',
        'Authorization':"Token $token"
      });
  return response;
}


Stream<Response> getMessageStream() async* {
  final token = await getToken();
  yield* Stream.periodic(const Duration(seconds: 1), (_) {
    return get(Uri.parse('${urlStart}messages/'),
        headers: {
          'Content-Type': 'text/html',
          'charset': 'UTF-8',
          'Authorization': "Token $token"
        });
  }).asyncMap((event) async => await event);
}

Stream<Response> getMessageCountStream() async* {
  final token = await getToken();
  yield* Stream.periodic(const Duration(seconds: 1), (_) {
    return get(Uri.parse('${urlStart}dialogs/'),
        headers: {
          'Content-Type': 'text/html',
          'charset': 'UTF-8',
          'Authorization': "Token $token"
        });
  }).asyncMap((event) async => await event);
}

Stream<Response> getNotifications() async* {
  final token = await getToken();
  yield* Stream.periodic(const Duration(seconds: 5), (_) {
    return get(Uri.parse('${urlStart}notifications/'),
        headers: {
          'Content-Type': 'text/html',
          'charset': 'UTF-8',
          'Authorization': "Token $token"
        });
  }).asyncMap((event) async => await event);
}

Future<Response> getNotificationsAsFuture() async {
  final token = await getToken();
  final response = await get(
      Uri.parse('${urlStart}notifications/'),
      headers: {
        'Content-Type': 'application/json',
        'charset': 'UTF-8',
        'Authorization':"Token $token"
      });
  return response;
}


Future<void> sendMessage(String text) async {
  final body = {
    'message':text
  };
  final token = await getToken();
  final jsonString = json.encode(body);
  final response = await post(
      Uri.parse('${urlStart}messages/'),
      body: jsonString,
      headers: {
        'Content-Type': 'application/json',
        'charset': 'UTF-8',
        'Authorization':"Token $token"
      });
}
// Stream<Response> get_restaurants_as_stream() async* {
//   final token = await getToken();
//   final city = await get_user_data().then((value){
//     return convert_response_to_map(value)['city'].split(';')[1];
//   });
//   yield* Stream.periodic(Duration(seconds: 5), (_) {
//     return get(Uri.parse('https://rociscore.ru/api/v1/$city'), headers: {
//       'Content-Type': 'text/html',
//       'charset': 'UTF-8',
//       'Authorization': "Token $token"
//     });
//   }).asyncMap((event) async => await event);
// }

// Stream<Response> get_bars_as_stream() async* {
//   final token = await getToken();
//   yield* Stream.periodic(Duration(seconds: 5), (_) {
//     return get(Uri.parse('https://rociscore.ru/api/v1/$city/bars'),
//         headers: {
//           'Content-Type': 'text/html',
//           'charset': 'UTF-8',
//           'Authorization': "Token $token"
//         });
//   }).asyncMap((event) async => await event);
// }
