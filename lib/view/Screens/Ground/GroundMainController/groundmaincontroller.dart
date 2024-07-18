import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import '../GroundBookingscreen/modal/bookingmodal.dart';
import '../GroundProfileScreen/groundmodal/groundmodal.dart';

class GroundMainController extends GetxController {
  var userEmail = ''.obs;
  var userName = ''.obs;
  var imagesList = <XFile>[].obs;
  final ImagePicker _picker = ImagePicker();
  var name = ''.obs;
  var groundName = ''.obs;
  var phoneNo = ''.obs;
  var groundDescription = ''.obs;
  var groundSize = ''.obs;
  var bookings = <GBooking>[].obs;
  var videoFile = Rx<XFile?>(null);
  var currentPosition = Rx<LatLng?>(null);
  var locationName = 'Select Location on Map'.obs;
  Rx<VideoPlayerController?> videoController = Rx<VideoPlayerController?>(null);
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    getCurrentLocation();
    getUserProfileDetails();
    fetchBookings();
    fetchUserData();

    super.onInit();
  }

  @override
  void onClose() {
    videoController.value?.dispose();
    super.onClose();
  }

  Future<void> getUserProfileDetails() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final String? userId = user?.uid;

    if (userId != null) {
      try {
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('Ground_Owner')
            .doc(userId)
            .get();

        if (snapshot.exists) {
          final data = snapshot.data() as Map<String, dynamic>;
          userEmail.value = data['email'];
          userName.value = data['fullName'];
        } else {
          // Handle the case when the document does not exist
          print("Document does not exist");
        }
      } catch (e) {
        // Handle any errors
        print("Error fetching user profile details: $e");
      }
    } else {
      // Handle the case when userId is null
      print("User is not logged in");
    }
  }

  void fetchBookings() async {
    var snapchot =
        await FirebaseFirestore.instance.collection('bookingsslot').get();
    var bookingDeta =
        snapchot.docs.map((doc) => GBooking.fromMap(doc.data())).toList();
    bookings.value = bookingDeta;
  }

  void removeDocument(int index) {
    imagesList.removeAt(index);
  }

  void pickDocument() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      imagesList.add(pickedImage);
    }
  }

  void pickVideo() async {
    final XFile? pickedVideo =
        await _picker.pickVideo(source: ImageSource.gallery);
    if (pickedVideo != null) {
      videoFile.value = pickedVideo;
      _initializeVideo(pickedVideo);
    }
  }

  void _initializeVideo(XFile video) {
    final controller = VideoPlayerController.file(File(video.path));
    videoController.value = controller;
    controller.initialize().then((_) {
      controller.setLooping(true);
      controller.play();
      update();
    });
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    final position = await Geolocator.getCurrentPosition();
    currentPosition.value = LatLng(position.latitude, position.longitude);
    await _getAddressFromLatLng(position.latitude, position.longitude);
  }

  Future<void> _getAddressFromLatLng(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks[0];
      locationName.value =
          "${place.locality}, ${place.postalCode}, ${place.country}";
    } catch (e) {
      print(e);
    }
  }

  Future<void> submitForm() async {
    isLoading.value = true;
    try {
      List<String> images = [];
      String? videoUrl;

      for (var doc in imagesList) {
        final urldoc = await _uploadFile(doc, 'images');
        images.add(urldoc);
      }

      if (videoFile.value != null) {
        videoUrl = await _uploadFile(videoFile.value!, 'videos');
      }

      // Store form data in Firestore
      await FirebaseFirestore.instance.collection('OwnerGroundDetails').add({
        'name': name.value,
        'groundname': groundName.value,
        'phoneno': phoneNo.value,
        'groundescription': groundDescription.value,
        'size': groundSize.value,
        'documentUrls': images,
        'videoUrl': videoUrl,
        'latitude': currentPosition.value?.latitude,
        'longitude': currentPosition.value?.longitude,
        'locationName': locationName.value,
      });

      Get.snackbar('Success', 'Form submitted successfully.');
    } catch (e) {
      Get.snackbar('Error', 'Failed to submit form: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<String> _uploadFile(XFile file, String folder) async {
    try {
      final storageRef =
          FirebaseStorage.instance.ref().child('$folder/${file.name}');
      await storageRef.putFile(File(file.path));
      return await storageRef.getDownloadURL();
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload file: $e');
      rethrow; // Re-throw the error for higher-level handling
    }
  }

  var user = UserModel().obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void fetchUserData() async {
    try {
      User? authUser = FirebaseAuth.instance.currentUser;
      if (authUser == null) {
        print('User is not authenticated');
        return;
      }

      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await _firestore.collection('users').doc(authUser.uid).get();

      if (documentSnapshot.exists && documentSnapshot.data() != null) {
        user.value = UserModel.fromMap(documentSnapshot.data()!);
      } else {
        print('Document does not exist or data is null');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> deleteAccount() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.delete();
        print('User account deleted');
        // Perform any additional cleanup or navigation if needed
      }
    } catch (e) {
      print('Failed to delete user account: $e');
    }
  }
}
