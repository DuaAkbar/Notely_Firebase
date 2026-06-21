import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:notes_app/auth/loginScreen.dart';
import 'package:notes_app/views/HomeScreen.dart';

class Authcontroller extends GetxController {
  RxBool isLoading = false.obs;

  Future<void> register(
    String userName,
    String userEmail,
    String userPassword,
  ) async {
    try {
      isLoading(true);
      final createUser = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: userEmail,
            password: userPassword,
          );
      await createUser.user!.updateDisplayName(userName);
      Get.offAll(() => Loginscreen());
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> login(String userEmail, String userPassword) async {
    try {
      isLoading(true);
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );

      Get.offAll(() => HomeScreen());
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    Get.offAll(() => Loginscreen());
  }
}
