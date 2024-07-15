import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supporthub/appassets/color/colors.dart';
import 'package:supporthub/appassets/sizedbox_height.dart';
import 'package:supporthub/appassets/textstyle/textstyles.dart';
import '../GroundMainController/groundmaincontroller.dart';

class GroundBookingScreen extends StatelessWidget {
  GroundBookingScreen({super.key});
  final controller = Get.find<GroundMainController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Bookings'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              AppSizedBoxes.largeSizedBox,
              Container(
                height: 40,
                width: Get.width * 0.8,
                decoration: BoxDecoration(
                    color: CustomColors.secondary,
                    borderRadius: BorderRadius.circular(12)),
                child: Center(
                    child: Text(
                  'Booking',
                  style: AppTextStyles.medium,
                )),
              ),
              AppSizedBoxes.normalSizedBox,
              Obx(
                () => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowColor: MaterialStateColor.resolveWith((states) =>
                        CustomColors.primary), // Grey background for headers
                    headingTextStyle: TextStyle(
                        color: CustomColors.white), // White text for headers
                    columns: const <DataColumn>[
                      DataColumn(label: Text('Ground')),
                      DataColumn(label: Text('Players')),
                      DataColumn(label: Text('Date')),
                      DataColumn(label: Text('Time Slot')),
                    ],
                    rows: controller.bookings.map((booking) {
                      return DataRow(
                        cells: <DataCell>[
                          DataCell(Text(booking.ground)),
                          DataCell(Text(booking.players.toString())),
                          DataCell(Text(
                              "${booking.date.day} ${booking.date.month} ${booking.date.year}")), // Format DateTime to String
                          DataCell(Text(booking.timeSlot)),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
