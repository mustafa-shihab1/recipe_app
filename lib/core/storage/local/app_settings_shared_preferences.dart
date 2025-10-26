import 'package:shared_preferences/shared_preferences.dart';

class AppSettingsSharedPreferences {
  final SharedPreferences _sharedPreferences;

  AppSettingsSharedPreferences(this._sharedPreferences);

  Future<void> setOutBoardingViewed() async {
    await _sharedPreferences.setBool(
      'on_boarding_viewed',
      true,
    );
  }

  bool getOutBoardingViewed() {
    return _sharedPreferences
        .getBool(
      'on_boarding_viewed'
    )!;
  }

  Future<void> setToken(String token) async {
    await setLoggedIn();
    await _sharedPreferences.setString('token', token);
  }

  String getToken() {
    return _sharedPreferences.getString('token')!;
  }

  Future<void> setEmail(String email) async {
    await _sharedPreferences.setString('email', email);
  }

  String getEmail() {
    return _sharedPreferences.getString('email')!;
  }

  // Future<void> setPassword(String password) async {
  //   await _sharedPreferences.setString('password', password);
  // }
  //
  // String getPassword() {
  //   return _sharedPreferences.getString('password')!;
  // }

  Future<void> setLoggedIn() async {
    await _sharedPreferences.setBool('loggedIn', true);
  }

  bool loggedIn() {
    return _sharedPreferences.getBool('loggedIn')!;
  }

  void clear() {
    _sharedPreferences.clear();
  }

}