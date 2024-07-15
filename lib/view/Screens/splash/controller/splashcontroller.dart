import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:supporthub/view/GBottomNavigation/GBotoomnavigationBar.dart';
import 'package:supporthub/view/Screens/splash/onboarding.dart';
import 'package:supporthub/view/bottomnavigation/bottomnavigation.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(seconds: 3), () {
      checkLogin();
    });
  }

  void checkLogin() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // If user is not logged in, navigate to onboarding screen
      Get.offAll(OnboardingAcreen());
    } else {
      try {
        // If user is logged in, check their role
        DocumentSnapshot petOwnerDoc = await FirebaseFirestore.instance
            .collection('Ground_Owner')
            .doc(user.uid)
            .get();
        DocumentSnapshot vetDoc = await FirebaseFirestore.instance
            .collection('Player')
            .doc(user.uid)
            .get();

        if (petOwnerDoc.exists) {
          String role = petOwnerDoc['role'];
          if (role == 'Ground_Owner') {
            Get.offAll(GroundOwnerBottomNavigation());
          } else {
            Get.offAll(OnboardingAcreen());
          }
        } else if (vetDoc.exists) {
          String role = vetDoc['role'];
          if (role == 'Player') {
            Get.offAll(BottomNavigation());
          } else {
            Get.offAll(OnboardingAcreen());
          }
        } else {
          // If user document doesn't exist in both collections, navigate to onboarding screen
          Get.offAll(OnboardingAcreen());
        }
      } catch (e) {
        // Handle errors
        print("Error checking user role: $e");
        Get.offAll(OnboardingAcreen());
      }
    }
  }
}
