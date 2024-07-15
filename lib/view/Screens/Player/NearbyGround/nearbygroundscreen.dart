import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:supporthub/appassets/color/colors.dart';
import 'package:supporthub/appassets/sizedbox_height.dart';
import 'package:supporthub/appassets/textstyle/textstyles.dart';

import 'bookingslot.dart';
import 'controller/controller.dart';

class NearbyGroundScreen extends StatelessWidget {
  final _mapController = Get.put(GroundController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Grounds Map',
      )),
      body: Obx(() {
        if (_mapController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nearby Ground',
                style: AppTextStyles.mediumblack
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              AppSizedBoxes.normalSizedBox,
              Container(
                height: Get.height * 0.2,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(_mapController.currentPosition!.latitude,
                        _mapController.currentPosition!.longitude),
                    zoom: 12,
                  ),
                  markers: _mapController.markers.value,
                ),
              ),
              AppSizedBoxes.largeSizedBox,
              Expanded(
                flex: 1,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _mapController.groundDetails.length,
                  itemBuilder: (context, index) {
                    final groundDetail = _mapController.groundDetails[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Card(
                        color: CustomColors.primary,
                        child: ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(groundDetail.imageUrls[0]),
                              Text(
                                groundDetail.groundName,
                                style: AppTextStyles.medium
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                groundDetail.groundsize,
                                style: AppTextStyles.small
                                    .copyWith(color: CustomColors.grey1),
                              ),
                            ],
                          ),
                          subtitle: Text(
                            groundDetail.description,
                            style: AppTextStyles.small,
                          ),
                          onTap: () {
                            Get.to(
                                BookingSlotScreen(groundDetail: groundDetail));
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
