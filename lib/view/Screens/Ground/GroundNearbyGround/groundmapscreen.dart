import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:supporthub/appassets/color/colors.dart';
import 'package:supporthub/widgets/customelevatedvutton.dart';
import '../GroundMainController/groundmaincontroller.dart';

class GroundMapScreen extends StatelessWidget {
  final controller = Get.find<GroundMainController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Location'),
      ),
      body: Stack(
        children: [
          Obx(() {
            return controller.currentPosition.value == null
                ? Center(child: CircularProgressIndicator())
                : GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: controller.currentPosition.value!,
                      zoom: 15,
                    ),
                    markers: {
                      Marker(
                        markerId: MarkerId('currentLocation'),
                        position: controller.currentPosition.value!,
                      ),
                    },
                    onTap: (LatLng position) {
                      controller.currentPosition.value = position;
                    },
                  );
          }),
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: SearchPlacesWidget(
              onSelected: (LatLng position) {
                controller.currentPosition.value = position;
                Get.back(); // Go back to the previous screen
              },
            ),
          ),
          Positioned(
              top: Get.height * 0.8,
              left: 30,
              child: CustomButton(
                ontap: () {
                  Get.back();
                },
                title: 'Current Location',
                color: CustomColors.secondary,
              ))
        ],
      ),
    );
  }
}

class SearchPlacesWidget extends StatelessWidget {
  final Function(LatLng) onSelected;

  SearchPlacesWidget({required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: GooglePlaceAutoCompleteTextField(
        textEditingController: TextEditingController(),
        googleAPIKey: "AIzaSyCa-bvn_Yn-y9qBLglmPPSQ4HJRecxgd8k",
        inputDecoration: InputDecoration(
          hintText: "Search Places",
          border: InputBorder.none,
        ),
        debounceTime: 800,
        countries: ["pk"], // Add your desired country code
        isLatLngRequired: true,
        getPlaceDetailWithLatLng: (prediction) {
          if (prediction != null &&
              prediction.lat != null &&
              prediction.lng != null) {
            final lat = double.parse(prediction.lat!);
            final lng = double.parse(prediction.lng!);
            onSelected(LatLng(lat, lng));
          }
        },
        itemClick: (prediction) {
          if (prediction.lat != null && prediction.lng != null) {
            final lat = double.parse(prediction.lat!);
            final lng = double.parse(prediction.lng!);
            onSelected(LatLng(lat, lng));
          }
        },
      ),
    );
  }
}
