import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mithilesh_s_application1/presentation/Singup_page/verify.dart';
import 'package:permission_handler/permission_handler.dart';

class SignUpController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isOtpSent = true;

  ///verification function
  /// this function is called from signup screen
  /// this function is used to send otp to user
  /// if otp is sent then user is redirected to verify otp screen
  /// else error is printed on console
  Future<void> verifyPhoneNumber(phoneNumber) async {
    isOtpSent = false;
    // update();
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(minutes: 2),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
        // User is signed in automatically
        Get.offAllNamed('/home');
      },
      verificationFailed: (FirebaseAuthException e) {
        print('Failed to verify phone number: ${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        CircularProgressIndicator(
          color: Colors.green,
        );
        Get.to(
            VerifyOtpScreen(
                verificationId: verificationId, phoneNumber: phoneNumber),
            transition: Transition.fade);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-retrieval timeout callback
      },
    );
    isOtpSent = true;
    update();
  }

  ///verity otp function
  ///this function is called from verify otp screen
  ///this function is used to verify otp
  ///if otp is verified then user is redirected to home screen
  ///else error is printed on console
  void verifyOTP(smsCode, verificationId) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      // Successfully authenticated with OTP
      Get.offAllNamed('/detDefaultApp');
    } catch (e) {
      // Handle verification failure
      Get.snackbar(
        'Error',
        'Error verifying OTP: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
