import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supporthub/appassets/color/colors.dart';
import 'package:supporthub/appassets/sizedbox_height.dart';
import 'package:supporthub/appassets/textstyle/textstyles.dart';
import 'package:supporthub/widgets/customeTextfield.dart';
import 'package:supporthub/widgets/customelevatedvutton.dart';
import 'package:table_calendar/table_calendar.dart';

import 'Services/services.dart';
import 'controller/controller.dart';

class PlayerBooking extends StatelessWidget {
  final GroundDetail groundDetail;
  const PlayerBooking({super.key, required this.groundDetail});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GroundController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Player Booking'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Choose Date',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Obx(() => TableCalendar(
                    firstDay: DateTime.utc(2020, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: controller.selectedDate.value,
                    selectedDayPredicate: (day) =>
                        isSameDay(controller.selectedDate.value, day),
                    onDaySelected: (selectedDay, focusedDay) {
                      controller.selectDate(selectedDay);
                    },
                  )),
              SizedBox(height: 16),
              Text('Available Slots',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Obx(() {
                List<String> timeSlots = [
                  "10:00 - 11:00",
                  "11:00 - 12:00",
                  "12:00 - 13:00",
                  "13:00 - 14:00",
                  "14:00 - 15:00",
                  "15:00 - 16:00",
                  "16:00 - 17:00",
                  "17:00 - 18:00",
                  "18:00 - 19:00",
                  "19:00 - 20:00",
                  "20:00 - 21:00",
                  "21:00 - 22:00",
                ];

                return Container(
                  decoration: AppDecoration.decorationBgColor,
                  width: double.infinity,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 3, vertical: 6),
                    child: Wrap(
                      runSpacing: 8,
                      spacing: 78.0,
                      children: timeSlots.map((slot) {
                        bool isBooked = controller.bookedSlots.contains(slot);
                        bool isSelected =
                            slot == controller.selectedTimeSlot.value;
                        return SizedBox(
                          height: 30,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                isBooked
                                    ? Colors.red
                                    : (isSelected
                                        ? CustomColors.secondary
                                        : Colors.white),
                              ),
                            ),
                            onPressed: isBooked
                                ? null
                                : () => controller.selectTimeSlot(slot),
                            child: Text(
                              slot,
                              style: isSelected
                                  ? AppTextStyles.medium
                                  : AppTextStyles.mediumblack,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                );
              }),
              SizedBox(height: 16),
              CustomTextField(
                hintText: 'Phone Number',
                obscureText: false,
                textInputType: TextInputType.number,
                onchange: (value) => controller.phoneNumber.value = value!,
              ),
              AppSizedBoxes.normalSizedBox,
              CustomTextField(
                  hintText: 'Number of Players',
                  obscureText: false,
                  textInputType: TextInputType.number,
                  onchange: (value) {
                    controller.players.value = int.tryParse(value!) ?? 0;
                  }),
              SizedBox(height: 16),
              Center(
                child: Obx(
                  () => controller.isLoading.value
                      ? CircularProgressIndicator()
                      : CustomButton(
                          color: CustomColors.secondary,
                          ontap: () {
                            controller
                                .bookSlot(groundDetail.groundName)
                                .then((value) => Get.back());
                            Get.snackbar('Message', 'Successfull Uploaded');
                          },
                          title: 'Book Now'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
