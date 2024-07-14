import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:supporthub/widgets/customelevatedvutton.dart';

import '../../appassets/color/colors.dart';
import '../../appassets/sizedbox_height.dart';
import '../../appassets/textstyle/textstyles.dart';
import '../../widgets/customeTextfield.dart';
import 'controller/authcontroller.dart';
import 'login.dart';

class Registerscreen extends StatelessWidget {
  final bool isPlayer;
  Registerscreen({required this.isPlayer});
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<FormState>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: Get.height * 0.8,
              color: CustomColors.primary,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 600),
              child: Container(
                height: Get.height * 0.3,
                color: CustomColors.secondary,
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 230, left: 20),
                child: Container(
                  height: Get.height * 0.7,
                  width: Get.width * 0.9,
                  decoration: AppDecoration.decorationWhite,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: key,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            AppSizedBoxes.normalSizedBox,
                            CustomTextField(
                              hintText: 'Email',
                              obscureText: false,
                              onchange: (value) =>
                                  authController.email.value = value!,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                } else if (!GetUtils.isEmail(value)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                            ),
                            AppSizedBoxes.normalSizedBox,
                            CustomTextField(
                              onchange: (value) =>
                                  authController.userName.value = value!,
                              hintText: 'Username',
                              obscureText: false,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your user username';
                                }
                                return null;
                              },
                            ),
                            AppSizedBoxes.normalSizedBox,
                            CustomTextField(
                              onchange: (value) =>
                                  authController.fullName.value = value!,
                              hintText: 'Full Name',
                              obscureText: false,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your full name';
                                }
                                return null;
                              },
                            ),
                            AppSizedBoxes.normalSizedBox,
                            isPlayer
                                ? Column(
                                    children: [
                                      CustomTextField(
                                        hintText: 'Password',
                                        onchange: (value) => authController
                                            .password.value = value!,
                                        obscureText: true,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your password';
                                          }
                                          return null;
                                        },
                                      ),
                                      AppSizedBoxes.normalSizedBox,
                                      CustomTextField(
                                        hintText: 'Repeat Password',
                                        onchange: (value) => authController
                                            .repeatPassword.value = value!,
                                        obscureText: true,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your repeat password';
                                          } else if (value !=
                                              authController.password.value) {
                                            return 'Passwords do not match';
                                          }
                                          return null;
                                        },
                                      ),
                                      AppSizedBoxes.normalSizedBox,
                                    ],
                                  )
                                : Column(
                                    children: [
                                      CustomTextField(
                                        hintText: 'Password',
                                        onchange: (value) => authController
                                            .password.value = value!,
                                        obscureText: true,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your password';
                                          }
                                          return null;
                                        },
                                      ),
                                      AppSizedBoxes.normalSizedBox,
                                      CustomTextField(
                                        hintText: 'Repeat Password',
                                        onchange: (value) => authController
                                            .repeatPassword.value = value!,
                                        obscureText: true,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your repeat password';
                                          } else if (value !=
                                              authController.password.value) {
                                            return 'Passwords do not match';
                                          }
                                          return null;
                                        },
                                      ),
                                      AppSizedBoxes.normalSizedBox,
                                      CustomTextField(
                                        onchange: (value) => authController
                                            .groundsize.value = value!,
                                        hintText: 'Ground size',
                                        obscureText: false,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your Ground Size';
                                          }
                                          return null;
                                        },
                                      )
                                    ],
                                  ),
                            AppSizedBoxes.normalSizedBox,
                            Obx(
                              () => authController.isLoading.value
                                  ? CircularProgressIndicator(
                                      color: CustomColors.primary,
                                    )
                                  : CustomButton(
                                      ontap: () {
                                        if (key.currentState!.validate()) {
                                          authController.register(isPlayer);
                                        }
                                      },
                                      title: isPlayer
                                          ? 'Register as Player'
                                          : 'Register as Ground_Owner',
                                      color: CustomColors.secondary,
                                    ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Already have an account?',
                                  style: AppTextStyles.medium
                                      .copyWith(color: CustomColors.grey),
                                ),
                                TextButton(
                                    onPressed: () {
                                      if (isPlayer == true) {
                                        Get.to(
                                            () => LoginScreen(role: 'player'));
                                      } else {
                                        Get.to(() =>
                                            LoginScreen(role: 'ground Owner'));
                                      }
                                    },
                                    child: Text('Login here!',
                                        style: AppTextStyles.mediumblack))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 70, left: 20),
              child: Text(
                isPlayer ? 'Join as a Player' : 'join as a Ground Owner',
                style: AppTextStyles.heading1.copyWith(fontSize: 46),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Padding(
//   padding: const EdgeInsets.only(top: 190),
//   child: Container(
//     width: Get.width,
//     height: Get.height,
//     decoration: const BoxDecoration(
//         borderRadius: BorderRadiusDirectional.only(
//             topEnd: Radius.circular(20),
//             topStart: Radius.circular(20)),
//         color: bgcolor // Adjust opacity as needed
//         ),
//     child: Form(
//       key: key,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: Column(
//           children: [
//             AppSizedBoxes.largeSizedBox,
//             Text(isPlayer ? 'Join as Vet' : 'Join as Pet Owner',
//                 style: AppTextStyles.heading1),
//             AppSizedBoxes.largeSizedBox,
//             isPlayer
//                 ? Column(
//                     children: [
                      
//                       AppSizedBoxes.normalSizedBox,
//                       CustomTextField(
//                         onchange: (value) => authController
//                             .clinicName.value = value!,
//                         hintText: 'Clinic Name',
//                         obscureText: false,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your clinic name';
//                           }
//                           return null;
//                         },
//                       ),
//                     ],
//                   )
//                 : Column(
//                     children: [
//                       CustomTextField(
//                         onchange: (value) =>
//                             authController.userName.value = value!,
//                         hintText: 'Username',
//                         obscureText: false,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your user name';
//                           }
//                           return null;
//                         },
//                       ),
//                       AppSizedBoxes.normalSizedBox,
//                       CustomTextField(
//                         onchange: (value) =>
//                             authController.fullName.value = value!,
//                         hintText: 'Full Name',
//                         obscureText: false,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your full name';
//                           }
//                           return null;
//                         },
//                       ),
//                     ],
//                   ),
//             AppSizedBoxes.normalSizedBox,
//             CustomTextField(
//               hintText: 'Phone',
//               onchange: (value) =>
//                   authController.phone.value = value!,
//               obscureText: false,
//               maxlength: 11, // restrict input to 11 digits
//               textInputType: TextInputType.number,
//               validator: (value) {
//                 if (value == null || value.length != 11) {
//                   return 'Please enter a valid 11-digit phone number';
//                 } else if (!GetUtils.isNumericOnly(value)) {
//                   return 'Please enter a valid phone number';
//                 }
//                 return null;
//               },
//             ),
//             AppSizedBoxes.normalSizedBox,
//             isPlayer
//                 ? Row(
//                     mainAxisAlignment:
//                         MainAxisAlignment.spaceAround,
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           authController.pickDocument(context);
//                         },
//                         child: Container(
//                           height: 53,
//                           width: Get.width * 0.44,
//                           decoration: BoxDecoration(
//                               border: Border.all(
//                                 color: Color.fromARGB(
//                                     255, 117, 115, 115),
//                               ),
//                               borderRadius:
//                                   BorderRadius.circular(12),
//                               color: Color(0xff313945)),
//                           child: Row(
//                             mainAxisAlignment:
//                                 MainAxisAlignment.spaceAround,
//                             children: [
//                               Obx(
//                                 () => Text(
//                                   authController
//                                           .documentName.isEmpty
//                                       ? 'Upload \n Documents'
//                                       : authController
//                                           .documentName.value
//                                           .substring(0, 12),
//                                   overflow: TextOverflow.fade,
//                                   style: AppTextStyles.medium,
//                                 ),
//                               ),
//                               Icon(
//                                 Iconsax.document_upload,
//                                 color: whitecolor,
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                       Container(
//                         height: 53,
//                         width: Get.width * 0.44,
//                         decoration: BoxDecoration(
//                             border: Border.all(
//                               color: Color.fromARGB(
//                                   255, 117, 115, 115),
//                             ),
//                             borderRadius: BorderRadius.circular(12),
//                             color: Color(0xff313945)),
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Obx(
//                             () => DropdownButton<String>(
//                               underline: SizedBox(),
//                               hint: Text('Select Gender'),
//                               value: authController
//                                   .selectedGender.value,
//                               onChanged: (String? newValue) {
//                                 authController.selectedGender
//                                     .value = newValue!;
//                               },
//                               dropdownColor: bgcolor,
//                               borderRadius:
//                                   BorderRadius.circular(12),
//                               items: authController.genders
//                                   .map((String gender) {
//                                 return DropdownMenuItem<String>(
//                                   value: gender,
//                                   child: Text(
//                                     gender,
//                                     style: AppTextStyles.medium,
//                                   ),
//                                 );
//                               }).toList(),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   )
//                 : Container(
//                     height: 53,
//                     width: Get.width * 0.9,
//                     decoration: BoxDecoration(
//                         border: Border.all(
//                           color: Color.fromARGB(255, 117, 115, 115),
//                         ),
//                         borderRadius: BorderRadius.circular(12),
//                         color: Color(0xff313945)),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Obx(
//                         () => DropdownButton<String>(
//                           underline: SizedBox(),
//                           hint: Text('Select Gender'),
//                           value:
//                               authController.selectedGender.value,
//                           onChanged: (String? newValue) {
//                             authController.selectedGender.value =
//                                 newValue!;
//                           },
//                           iconEnabledColor: Color(0xff313945),
//                           dropdownColor: bgcolor,
//                           borderRadius: BorderRadius.circular(12),
//                           items: authController.genders
//                               .map((String gender) {
//                             return DropdownMenuItem<String>(
//                               value: gender,
//                               child: Text(
//                                 gender,
//                                 style: AppTextStyles.medium,
//                               ),
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                     ),
//                   ),
//             AppSizedBoxes.normalSizedBox,
            

//             Obx(
//               () => authController.isLoading1.value
//                   ? CircularProgressIndicator(
//                       color: blue,
//                     )
//                   : CustomButton(
//                       ontap: () {
//                         if (key.currentState!.validate()) {
//                           authController.register(isPlayer);
//                         }
//                       },
//                       title: 'Create Account'),
//             ),
           
//           ],
//         ),
//       ),
//     ),
//   ),
// ),
// Positioned(
//   top: 160,
//   child: CircleAvatar(
//     radius: 30,
//     backgroundColor: bgcolor,
//     child: Padding(
//       padding: const EdgeInsets.all(3.0),
//       child: Container(
//         height: 50,
//         width: 50,
//         decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             border: Border.all(color: blue)),
//         child: Icon(
//           Iconsax.user,
//           color: blue,
//         ),
//       ),
//     ),
//   ),
// ),
