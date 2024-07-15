import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:supporthub/appassets/color/colors.dart';
import 'package:supporthub/view/Screens/Ground/GroundBookingscreen/groundbookingscreen.dart';
import 'package:supporthub/view/Screens/Ground/GroundChatscreen/groundchatscreen.dart';
import 'package:supporthub/view/Screens/Ground/GroundHomescreen/groundhomescreen.dart';
import 'package:supporthub/view/Screens/Ground/GroundProfileScreen/groundprofilescreen.dart';

import 'GroundBottomNavBarController/groundbottomnavbarcontroller.dart';

class GroundBottomNavigationBarScreen extends StatelessWidget {
  final navigationController = Get.put(GroundBottomNavBarController());

  final List _widgetOptions = [
    GroundHomeScreen(),
    GroundBookingScreen(),
    GroundChatScreen(),
    GroundProfilescreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => Center(
            child: _widgetOptions
                .elementAt(navigationController.selectedIndex.value),
          )),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Iconsax.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.calendar),
                label: 'Bookings',
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.message),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.user),
                label: 'Profile',
              ),
            ],
            currentIndex: navigationController.selectedIndex.value,
            selectedItemColor: Colors.green,
            backgroundColor: CustomColors.primary,
            unselectedItemColor: Colors.grey,
            onTap: (index) {
              navigationController.changeIndex(index);
            },
          )),
    );
  }
}
