import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:supporthub/appassets/color/colors.dart';
import 'package:supporthub/appassets/textstyle/textstyles.dart';
import 'package:supporthub/view/Screens/splash/onboarding.dart';
import '../GroundMainController/groundmaincontroller.dart';

class GroundProfilescreen extends StatelessWidget {
  GroundProfilescreen({super.key});

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: CustomColors.primary,
          title: Text(
            'Logout',
            style: AppTextStyles.heading1,
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: AppTextStyles.medium,
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: AppTextStyles.medium.copyWith(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Logout',
                style: AppTextStyles.medium,
              ),
              onPressed: () {
                final _auth = FirebaseAuth.instance;
                _auth.signOut().then((value) => Get.offAll(OnboardingAcreen()));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  final controller = Get.find<GroundMainController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: AppTextStyles.medium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 60),
            CircleAvatar(
              radius: 50,
              backgroundColor: CustomColors.primary.withOpacity(0.1),
              child: Icon(Iconsax.user, size: 50, color: CustomColors.primary),
            ),
            SizedBox(height: 40),
            Text(
              'Name',
              style: AppTextStyles.heading1black.copyWith(fontSize: 20),
            ),
            Obx(() => Text(
                  '${controller.userName.value}',
                  style: AppTextStyles.mediumblack,
                )),
            SizedBox(height: 20),
            Text(
              'Email',
              style: AppTextStyles.heading1black.copyWith(fontSize: 20),
            ),
            Obx(() => Text(
                  '${controller.userEmail.value}',
                  style: AppTextStyles.mediumblack,
                )),
            SizedBox(height: 40),
            Divider(color: CustomColors.primary, thickness: 1),
            ListTile(
              leading: Icon(Iconsax.logout, color: Colors.red),
              title: Text(
                'Logout',
                style: AppTextStyles.heading1black
                    .copyWith(fontSize: 16, color: Colors.red),
              ),
              onTap: () => _showLogoutDialog(context),
            ),
          ],
        ),
      ),
    );
  }
}
