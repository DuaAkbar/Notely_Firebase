import 'package:get/get.dart';
import 'package:notes_app/auth/loginScreen.dart';
import 'package:notes_app/views/HomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authcontroller extends GetxController {
  RxBool isLoading = false.obs;

  Future<void> register(
    String userName,
    String userEmail,
    String userPassword,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('name', userName);
    prefs.setString('email', userEmail);
    prefs.setString('password', userPassword);

    Get.offAll(() => Loginscreen());
  }

  Future<void> login(String userEmail, String userPassword) async {
    final prefs = await SharedPreferences.getInstance();
    String? savedEmail = prefs.getString('email');
    String? savedPassword = prefs.getString('password');

    if (userEmail == savedEmail && userPassword == savedPassword) {
      Get.offAll(() => HomeScreen());
    } else {
      Get.snackbar('Error', 'Invalid Email or Password!');
    }
  }
}
