import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:supporthub/appassets/color/colors.dart';
import 'package:supporthub/view/Screens/Player/Bookingscreen/bokkingscreen.dart';
import 'package:supporthub/view/Screens/Player/Chatscreen/chatscreen.dart';
import 'package:supporthub/view/Screens/Player/ProfileScreen/profilescreen.dart';
import 'package:supporthub/view/Screens/Player/homescreen/playhomescreen.dart';
import '../Screens/Player/NearbyGround/Mybookings.dart';
import '../Screens/Player/NearbyGround/nearbygroundscreen.dart';
import 'controller/controller.dart';

class BottomNavigation extends StatelessWidget {
  final NavigationController navigationController =
      Get.put(NavigationController());

  final List _widgetOptions = [
    HomeScreenPlayer(),
    MyBookings(),
    ChatScreen(),
    Profilescreen()
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
