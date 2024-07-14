import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:supporthub/appassets/images/images.dart';

import '../../appassets/color/colors.dart';
import '../../appassets/sizedbox_height.dart';
import '../../appassets/textstyle/textstyles.dart';
import '../../widgets/customeTextfield.dart';
import '../../widgets/customelevatedvutton.dart';
import 'controller/authcontroller.dart';
import 'register.dart';

class LoginScreen extends StatelessWidget {
  final String role; // Add this line to accept a role parameter
  final AuthController authController = Get.put(AuthController());
  LoginScreen(
      {required this.role}); // Update the constructor to accept the role parameter

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<FormState>();
    return Scaffold(
      body: Stack(
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
            padding: const EdgeInsets.only(top: 450, left: 20),
            child: Container(
              height: Get.height * 0.4,
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
                        Text(
                          'Sigin as a ${role.capitalizeFirst}',
                          style: AppTextStyles.heading1black,
                        ),
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
                          hintText: 'Password',
                          onchange: (value) =>
                              authController.password.value = value!,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
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
                                      authController.login();
                                    }
                                  },
                                  title: 'Sign In Account'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Do you not have an account?',
                              style: AppTextStyles.medium
                                  .copyWith(color: CustomColors.grey),
                            ),
                            TextButton(
                                onPressed: () {
                                  if (role == 'vet') {
                                    Get.to(() => Registerscreen(
                                          isPlayer: true,
                                        ));
                                  } else {
                                    Get.to(() => Registerscreen(
                                          isPlayer: false,
                                        ));
                                  }
                                },
                                child: Text('Register here!',
                                    style: AppTextStyles.mediumblack))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 70),
              child: Image.asset(CustomImages.logo))
        ],
      ),
    );
  }
}

//  Padding(
//                 padding: const EdgeInsets.only(top: 360),
//                 child: Container(
//                   width: Get.width,
//                   height: Get.height,
//                   decoration: const BoxDecoration(
//                       borderRadius: BorderRadiusDirectional.only(
//                           topEnd: Radius.circular(20),
//                           topStart: Radius.circular(20)),
//                       color: bgcolor // Adjust opacity as needed
//                       ),
//                   child: SingleChildScrollView(
//                     child: Form(
//                       key: key,
//                       child: Column(
//                         children: [
//                           AppSizedBoxes.largeSizedBox,
//                           Text('Sign In as a ${role.capitalizeFirst}',
//                               style: AppTextStyles.heading1),
//                           SizedBox(height: 10),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 20),
//                             child: Text(
//                                 'Welcome! Please enter your information below and get started.',
//                                 textAlign: TextAlign.center,
//                                 style: AppTextStyles.medium),
//                           ),
//                           AppSizedBoxes.largeSizedBox,
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 18),
//                             child: CustomTextField(
//                               hintText: 'User Email',
//                               onchange: (value) =>
//                                   authController.email.value = value!,
//                               obscureText: false,
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please enter your email';
//                                 } else if (!GetUtils.isEmail(value)) {
//                                   return 'Please enter a valid email';
//                                 }
//                                 return null;
//                               },
//                             ),
//                           ),
//                           AppSizedBoxes.normalSizedBox,
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 18),
//                             child: CustomTextField(
//                               hintText: 'Password',
//                               onchange: (value) =>
//                                   authController.password.value = value!,
//                               obscureText: true,
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please enter your password';
//                                 }
//                                 return null;
//                               },
//                             ),
//                           ),
//                           AppSizedBoxes.smallSizedBox,
//                           Row(
//                             children: [
//                               Checkbox(
//                                   value: false,
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(5)),
//                                   onChanged: (onChanged) {
//                                     onChanged = false;
//                                   }),
//                               Text(
//                                 'Accept Terms and Conditions',
//                                 style:
//                                     AppTextStyles.medium.copyWith(fontSize: 11),
//                               )
//                             ],
//                           ),
                         
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: 330,
//                 child: CircleAvatar(
//                   radius: 30,
//                   backgroundColor: bgcolor,
//                   child: Padding(
//                     padding: const EdgeInsets.all(3.0),
//                     child: Container(
//                       height: 50,
//                       width: 50,
//                       decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           border: Border.all(color: blue)),
//                       child: Icon(
//                         Iconsax.user,
//                         color: blue,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
