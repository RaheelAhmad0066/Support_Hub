import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:supporthub/appassets/color/colors.dart';
import 'package:supporthub/view/ScreenS/GroundOwner/GHomescreen/GroundOwnerHomeScreen.dart';
import 'package:supporthub/view/Screens/GroundOwner/GBookingscreen/GBookingscreen.dart';
import 'package:supporthub/view/Screens/GroundOwner/GChatscreen/GChatscreen.dart';
import 'package:supporthub/view/Screens/GroundOwner/GProfileScreen/GProfilescreen.dart';
import 'GController/GController.dart';

class GroundOwnerBottomNavigation extends StatelessWidget {
  final navigationController = Get.put(GNavigationController());

  final List _widgetOptions = [
    GroundOwnerHomeScreen(),
    GroundOwnerBookingScreen(),
    GroundOwnerChatScreen(),
    GroundOwnerProfilescreen()
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
