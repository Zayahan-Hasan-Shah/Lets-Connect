import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/src/controllers/auth_controller/forgot_password_controller/forgot_password_api_controller.dart';
import 'package:frontend/src/controllers/auth_controller/forgot_password_controller/ui_forgot_password_controller.dart';
import 'package:frontend/src/core/app_assets.dart';
import 'package:frontend/src/core/color_assets.dart';
import 'package:frontend/src/widgets/common_widgets/custom_button.dart';
import 'package:frontend/src/widgets/common_widgets/custom_snackbar.dart';
import 'package:frontend/src/widgets/common_widgets/custom_text_field.dart';
import 'package:frontend/src/widgets/common_widgets/title_text.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class ForgetPassword extends ConsumerStatefulWidget {
  const ForgetPassword({super.key});

  @override
  ConsumerState<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends ConsumerState<ForgetPassword> {
  GlobalKey<FormState> formkey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorAssets.backgroundColor,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: ColorAssets.whiteColor,
          ),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      backgroundColor: ColorAssets.backgroundColor,
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TitleText(
                title: 'Let\'s Connect',
                fontSize: 22.sp,
                color: ColorAssets.whiteColor,
                weight: FontWeight.bold,
                textAlign: TextAlign.center,
              ),
              Image.asset(
                AppAssets.logoImage,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.width * 0.8,
              ),
              TitleText(
                title: 'Forget Password?',
                textAlign: TextAlign.left,
                fontSize: 24.sp,
                color: ColorAssets.whiteColor,
                weight: FontWeight.bold,
              ),
              SizedBox(height: 1.h),
              _emailBuid(),
              SizedBox(height: 3.h),
              _forgotPasswordButton()
            ],
          ),
        ),
      )),
    );
  }

  Widget _emailBuid() {
    return Column(
      children: [
        CustomTextField(
          controller: emailController,
          hintText: 'joe@email.com',
          hintColor: ColorAssets.hintTextColor,
          fontSize: 16.sp,
        )
      ],
    );
  }

  Widget _forgotPasswordButton() {
    return SizedBox(
        height: 6.h,
        child: CustomButton(
          buttonBackgroundColor: ColorAssets.buttonColor,
          heightFactor: 1.02,
          widthFactor: 0.6,
          borderRadiusButton: 20,
          alignmentButton: Alignment.center,
          showLoader: true,
          onTap: () {},
          child: TitleText(
            title: 'Send Password',
            fontSize: 18.sp,
            textAlign: TextAlign.center,
            color: ColorAssets.whiteColor,
          ),
        ));
  }

  Future<void> onInt(String email) async {
    final forgotPasswordNorifier =
        ref.read(forgotPasswordNotifierProvider.notifier);
    try {
      forgotPasswordNorifier.setForgotPasswordButtonLoaderState(true);
      final response = await ref
          .read(forgotPasswordAuthNotifier.notifier)
          .forgotPasswordAuth(email);
      if (response != null) {
        CustomSnackbar.show(
          context: context,
          message: 'Password reset link sent to your email',
          title: 'Success',
          backgroundColor: ColorAssets.successColor,
        );
        context.pop();
      } else {
        CustomSnackbar.show(
          context: context,
          message: 'Failed to send password reset link',
          title: 'Error',
          backgroundColor: ColorAssets.errorColor,
        );
      }
    } catch (e) {
      log(e.toString());
      CustomSnackbar.show(
        context: context,
        message: 'An error occurred',
        title: 'Please try again later',
        backgroundColor: ColorAssets.errorColor,
      );
    } finally {
      // forgotPasswordNorifier.(false);
    }
  }
}
