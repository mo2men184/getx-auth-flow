import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:facebook_auth/facebook_auth.dart';
import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:twitter_login/twitter_login.dart';
import '../services/auth_service.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();
  Rx<User?> firebaseUser = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    firebaseUser.bindStream(_authService.authStateChanges());
  }

  // Email/Password Sign In
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _authService.signInWithEmailAndPassword(email, password);
    } catch (e) {
      Get.snackbar('Error', 'Failed to sign in: $e');
    }
  }

  // Email/Password Sign Up
  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    try {
      await _authService.signUpWithEmailAndPassword(email, password);
    } catch (e) {
      Get.snackbar('Error', 'Failed to sign up: $e');
    }
  }

  // Reset Password
  Future<void> resetPassword(String email) async {
    try {
      await _authService.resetPassword(email);
      Get.snackbar('Success', 'Password reset email sent!');
    } catch (e) {
      Get.snackbar('Error', 'Failed to send reset email: $e');
    }
  }

  // Sign Out
  Future<void> signOut() async {
    try {
      await _authService.signOut();
    } catch (e) {
      Get.snackbar('Error', 'Failed to sign out: $e');
    }
  }

  // Google Sign-In
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _authService.signInWithGoogle();
      if (googleUser != null) {
        // Handle Google user authentication
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to sign in with Google: $e');
    }
  }

  // Facebook Login
  Future<void> signInWithFacebook() async {
    try {
      final AccessToken? accessToken = await _authService.signInWithFacebook();
      if (accessToken != null) {
        // Handle Facebook user authentication
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to sign in with Facebook: $e');
    }
  }

  // Apple Sign-In
  Future<void> signInWithApple() async {
    try {
      final AuthorizationResult result = await _authService.signInWithApple();
      if (result.status == AuthorizationStatus.authorized) {
        // Handle Apple user authentication
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to sign in with Apple: $e');
    }
  }

  // Twitter Sign-In
  Future<void> signInWithTwitter() async {
    try {
      final TwitterLoginResult result = await _authService.signInWithTwitter();
      if (result.status == TwitterLoginStatus.loggedIn) {
        // Handle Twitter user authentication
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to sign in with Twitter: $e');
    }
  }

  // Phone Number Verification
  Future<void> verifyPhoneNumber(String phoneNumber) async {
    try {
      await _authService.verifyPhoneNumber(phoneNumber);
      Get.toNamed('/phone-auth'); // Navigate to phone verification view
    } catch (e) {
      Get.snackbar('Error', 'Failed to verify phone number: $e');
    }
  }

  // Phone Number Sign-In
  Future<void> signInWithPhoneNumber(String verificationId, String smsCode) async {
    try {
      await _authService.signInWithPhoneNumber(verificationId, smsCode);
      Get.back(); // Close phone verification view
    } catch (e) {
      Get.snackbar('Error', 'Failed to sign in with phone number: $e');
    }
  }
}
