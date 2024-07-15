import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:video_player/video_player.dart';
import '../Services/services.dart';
import 'package:http/http.dart' as http;

class GroundController extends GetxController {
  final FirestoreService _firestoreService = FirestoreService();
  var groundDetails = <GroundDetail>[].obs;
  var markers = <Marker>{}.obs;
  var isLoading = true.obs;
  Position? currentPosition;
  late VideoPlayerController videoController;
  var isVideoInitialized = false.obs;
  var selectedDate = DateTime.now().obs;
  var selectedTimeSlot = ''.obs;
  var phoneNumber = ''.obs;
  var players = 0.obs;
  var bookedSlots = <String>[].obs;
  var isPlaying = false.obs;
  @override
  void onInit() {
    super.onInit();
    _firestoreService.getGroundDetails().listen((grounds) {
      groundDetails.assignAll(grounds);
    });

    fetchBookedSlots(selectedDate.value);
    selectedDate.listen((date) {
      fetchBookedSlots(date);
    });
    _getCurrentLocation();
  }

  void initializeVideo(String videoPath) {
    videoController = VideoPlayerController.network(videoPath)
      ..initialize().then((_) {
        isVideoInitialized.value = true;
        update();
      }).catchError((error) {
        print("Video initialization failed: $error");
        isVideoInitialized.value = false;
      });
  }

  void toggleVideoPlayback() {
    if (videoController.value.isPlaying) {
      videoController.pause();
      isPlaying.value = false;
    } else {
      videoController.play();
      isPlaying.value = true;
    }
    update();
  }

  @override
  void onClose() {
    videoController.dispose();
    super.onClose();
  }

  void _getCurrentLocation() async {
    currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    _fetchGroundDetails();
    _fetchNearbyPlaygrounds();
  }

  void _fetchGroundDetails() async {
    // Fetch ground details from FirestoreService
    final fetchedGroundDetails =
        await FirestoreService().getGroundDetails().first;
    groundDetails.value = fetchedGroundDetails;
    _setMarkers();
  }

  void _fetchNearbyPlaygrounds() async {
    final String apiKey = 'AIzaSyCa-bvn_Yn-y9qBLglmPPSQ4HJRecxgd8k';
    final String url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${currentPosition!.latitude},${currentPosition!.longitude}&radius=1500&type=park&keyword=playground&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      results.forEach((result) {
        final marker = Marker(
          markerId: MarkerId(result['place_id']),
          position: LatLng(result['geometry']['location']['lat'],
              result['geometry']['location']['lng']),
          infoWindow: InfoWindow(
            title: result['name'],
            snippet: result['vicinity'],
          ),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
        );
        markers.add(marker);
      });
    } else {
      throw Exception('Failed to load nearby playgrounds');
    }
    isLoading.value = false;
  }

  void _setMarkers() {
    groundDetails.forEach((groundDetail) {
      final marker = Marker(
        markerId: MarkerId(groundDetail.groundName),
        position: LatLng(groundDetail.latitude, groundDetail.longitude),
        infoWindow: InfoWindow(
          title: groundDetail.groundName,
          snippet: groundDetail.description,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        onTap: () {
          // Get.to(NearbyGroundsScreen(groundDetail: groundDetail));
        },
      );
      markers.add(marker);
    });
  }

  void selectDate(DateTime date) {
    selectedDate.value = date;
  }

  void selectTimeSlot(String timeSlot) {
    selectedTimeSlot.value = timeSlot;
  }

  Future<void> fetchBookedSlots(DateTime date) async {
    try {
      var bookings = await FirebaseFirestore.instance
          .collection('bookings')
          .where('date',
              isEqualTo: date
                  .toIso8601String()
                  .substring(0, 10)) // Store date as string YYYY-MM-DD
          .get();

      bookedSlots.clear();
      for (var doc in bookings.docs) {
        bookedSlots.add(doc['timeSlot']);
      }
    } catch (e) {
      print("Error fetching booked slots: $e");
    }
  }

  Future<void> bookSlot(String groundName) async {
    isLoading.value = true;
    try {
      await FirebaseFirestore.instance.collection('bookingsslot').add({
        'date': selectedDate.value.toIso8601String().substring(0, 10),
        'timeSlot': selectedTimeSlot.value,
        'phoneNumber': phoneNumber.value,
        'players': players.value,
        'groundName': groundName,
      });
      Get.snackbar('Success', 'Booking Confirmed');
      // fetchBookedSlots(selectedDate.value); // Refresh booked slots
    } catch (e) {
      // Print error for debugging
      print("Error while booking slot: $e");
      // Show an error snackbar
      Get.snackbar('Error', 'Failed to book slot');
    } finally {
      isLoading.value = false;
    }
  }
}
