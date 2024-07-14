import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supporthub/view/ScreenS/Player/homescreen/Weather/consts/images.dart';
import 'package:supporthub/view/ScreenS/Player/homescreen/Weather/consts/strings.dart';
import 'package:supporthub/view/ScreenS/Player/homescreen/Weather/controllers/main_controller.dart';
import 'package:supporthub/view/ScreenS/Player/homescreen/Weather/models/current_weather_model.dart';
import 'package:supporthub/view/ScreenS/Player/homescreen/Weather/models/hourly_weather_model.dart';
import 'package:velocity_x/velocity_x.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var date = DateFormat("yMMMMd").format(DateTime.now());
    var theme = Theme.of(context);
    var controller = Get.put(MainController());

    return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text('Check Weather'),
        ),
        body: Obx(
          () => controller.isloaded.value == true
              ? Container(
                  padding: const EdgeInsets.all(12),
                  child: FutureBuilder(
                    future: controller.currentWeatherData,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        CurrentWeatherData data = snapshot.data;

                        return SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "${data.name}"
                                  .text
                                  .uppercase
                                  .fontFamily("poppins_bold")
                                  .size(32)
                                  .letterSpacing(3)
                                  .color(theme.primaryColor)
                                  .make(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    "assets/images/${data.weather![0].icon}.png",
                                    width: 80,
                                    height: 80,
                                  ),
                                  RichText(
                                      text: TextSpan(
                                    children: [
                                      TextSpan(
                                          text: "${data.main!.temp}$degree",
                                          style: TextStyle(
                                            color: theme.primaryColor,
                                            fontSize: 64,
                                            fontFamily: "poppins",
                                          )),
                                      TextSpan(
                                          text: " ${data.weather![0].main}",
                                          style: TextStyle(
                                            color: theme.primaryColor,
                                            letterSpacing: 3,
                                            fontSize: 14,
                                            fontFamily: "poppins",
                                          )),
                                    ],
                                  )),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton.icon(
                                      onPressed: null,
                                      icon: Icon(Icons.expand_less_rounded,
                                          color: theme.iconTheme.color),
                                      label: "${data.main!.tempMax}$degree"
                                          .text
                                          .color(theme.iconTheme.color)
                                          .make()),
                                  TextButton.icon(
                                      onPressed: null,
                                      icon: Icon(Icons.expand_more_rounded,
                                          color: theme.iconTheme.color),
                                      label: "${data.main!.tempMin}$degree"
                                          .text
                                          .color(theme.iconTheme.color)
                                          .make())
                                ],
                              ),
                              10.heightBox,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: List.generate(3, (index) {
                                  var iconsList = [clouds, humidity, windspeed];
                                  var values = [
                                    "${data.clouds!.all}",
                                    "${data.main!.humidity}",
                                    "${data.wind!.speed} km/h"
                                  ];
                                  return Column(
                                    children: [
                                      Image.asset(
                                        iconsList[index],
                                        width: 60,
                                        height: 60,
                                      )
                                          .box
                                          .gray200
                                          .padding(const EdgeInsets.all(8))
                                          .roundedSM
                                          .make(),
                                      10.heightBox,
                                      values[index].text.gray400.make(),
                                    ],
                                  );
                                }),
                              ),
                              10.heightBox,
                              const Divider(),
                              10.heightBox,
                              FutureBuilder(
                                future: controller.hourlyWeatherData,
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    HourlyWeatherData hourlyData =
                                        snapshot.data;

                                    return SizedBox(
                                      height: 160,
                                      child: ListView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemCount: hourlyData.list!.length > 6
                                            ? 6
                                            : hourlyData.list!.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          var time = DateFormat.jm().format(
                                              DateTime
                                                  .fromMillisecondsSinceEpoch(
                                                      hourlyData
                                                              .list![index].dt!
                                                              .toInt() *
                                                          1000));

                                          return Container(
                                            padding: const EdgeInsets.all(8),
                                            margin:
                                                const EdgeInsets.only(right: 4),
                                            decoration: BoxDecoration(
                                              color: Vx.gray200,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Column(
                                              children: [
                                                time.text.make(),
                                                Image.asset(
                                                  "assets/images/${hourlyData.list![index].weather![0].icon}.png",
                                                  width: 80,
                                                ),
                                                10.heightBox,
                                                "${hourlyData.list![index].main!.temp}$degree"
                                                    .text
                                                    .make(),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  }
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              ),
                              10.heightBox,
                              const Divider(),
                              10.heightBox,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  "Next 7 Days"
                                      .text
                                      .semiBold
                                      .size(16)
                                      .color(theme.primaryColor)
                                      .make(),
                                  TextButton(
                                      onPressed: () {},
                                      child: "View All".text.make()),
                                ],
                              ),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 7,
                                itemBuilder: (BuildContext context, int index) {
                                  var day = DateFormat("EEEE").format(
                                      DateTime.now()
                                          .add(Duration(days: index + 1)));
                                  return Card(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 12),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              child: day.text.semiBold
                                                  .color(theme.primaryColor)
                                                  .make()),
                                          Expanded(
                                            child: TextButton.icon(
                                                onPressed: null,
                                                icon: Image.asset(
                                                    "assets/images/50n.png",
                                                    width: 40),
                                                label: "26$degree"
                                                    .text
                                                    .size(16)
                                                    .color(theme.primaryColor)
                                                    .make()),
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                    text: "37$degree /",
                                                    style: TextStyle(
                                                      color: theme.primaryColor,
                                                      fontFamily: "poppins",
                                                      fontSize: 16,
                                                    )),
                                                TextSpan(
                                                    text: " 26$degree",
                                                    style: TextStyle(
                                                      color:
                                                          theme.iconTheme.color,
                                                      fontFamily: "poppins",
                                                      fontSize: 16,
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ));
  }
}
