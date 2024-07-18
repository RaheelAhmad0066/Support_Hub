import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:supporthub/appassets/color/colors.dart';
import 'package:supporthub/view/GroundBottomNavigation/groundbottomnavigationbarscreen.dart';

import '../../view/bottomnavigation/bottomnavigation.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var email = ''.obs;
  var password = ''.obs;
  var repeatPassword = ''.obs;
  var userName = ''.obs;
  var fullName = ''.obs;
  var groundsize = ''.obs;

  RxBool isLoading = false.obs;
  RxBool isLoading1 = false.obs;

  Future<void> register(bool isVet) async {
    isLoading.value = true;
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );

      if (isVet) {
        await _firestore
            .collection('Player')
            .doc(userCredential.user!.uid)
            .set({
          'email': email.value,
          'username': userName.value,
          'fullName': fullName.value,
          'userId': _auth.currentUser!.uid,
          'role': 'Player',
        });
        Get.snackbar('Success', 'Registration successful',
            colorText: CustomColors.white);
        Get.offAll(BottomNavigation());
      } else {
        await _firestore
            .collection('Ground_Owner')
            .doc(userCredential.user!.uid)
            .set({
          'email': email.value,
          'role': 'Ground_Owner',
          'userId': _auth.currentUser!.uid,
          'userName': userName.value,
          'fullName': fullName.value,
          'ground_size': groundsize.value,
        });
        Get.snackbar('Success', 'Registration successful',
            colorText: CustomColors.white);
        Get.offAll(GroundBottomNavigationBarScreen());
      }
    } catch (e) {
      Get.snackbar('Error', '$e', colorText: CustomColors.white);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> login() async {
    isLoading.value = true;

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );

      // Check if the user is a player
      DocumentSnapshot playerDoc = await _firestore
          .collection('Player')
          .doc(userCredential.user!.uid)
          .get();

      if (playerDoc.exists) {
        Get.offAll(BottomNavigation());
        Get.snackbar('Message', 'Successful Login',
            colorText: CustomColors.white);
      } else {
        // Check if the user is a ground owner
        DocumentSnapshot groundOwnerDoc = await _firestore
            .collection('Ground_Owner')
            .doc(userCredential.user!.uid)
            .get();

        if (groundOwnerDoc.exists) {
          Get.offAll(GroundBottomNavigationBarScreen());
          Get.snackbar('Message', 'Successful Login',
              colorText: CustomColors.white);
        } else {
          Get.snackbar('Error', 'No user found', colorText: CustomColors.white);
        }
      }
    } catch (e) {
      Get.snackbar('Error', '$e', colorText: CustomColors.white);
    } finally {
      isLoading.value = false;
    }
  }
}
