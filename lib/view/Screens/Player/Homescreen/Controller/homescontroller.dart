import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class Controller1 extends GetxController {
  var userEmail = ''.obs;
  var userName = ''.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    getUserProfileDeta();
    super.onInit();
  }

  Future<void> getUserProfileDeta() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final String? userId = user?.uid;
    if (userId != null) {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Player')
          .where('userId', isEqualTo: userId)
          .get();
      if (snapshot.docs.isNotEmpty) {
        final deta = snapshot.docs.first.data() as Map<String, dynamic>;
        userEmail.value = deta['email'];
        userName.value = deta['fullName'];
      }
    }
  }
}
