import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shoepal/models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expDate;
  String _userId;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expDate != null &&
        _expDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  Future<void> _authenticate(
    String email,
    String password,
    String urlSegment,
  ) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyCX4S8b9Rm10y5Cb6gaY8stboYZFJohT_0';

    try {
      final res = await http.post(
        url,
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );
      final data = json.decode(res.body);

      if (data['error'] != null) {
        throw HttpException(data['error']['message']);
      }

      _token = data['idToken'];
      _userId = data['localId'];
      _expDate = DateTime.now().add(
        Duration(
          seconds: int.parse(data['expiresIn']),
        ),
      );

      notifyListeners();
    } catch (err) {
      throw err;
    }
  }

  Future<void> signUp(
    String email,
    String password,
  ) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> signIn(
    String email,
    String password,
  ) async {
    return _authenticate(email, password, 'signInWithPassword');
  }
}
