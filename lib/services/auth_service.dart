import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:facebook_auth/facebook_auth.dart';
import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:twitter_login/twitter_login.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookAuth _facebookAuth = FacebookAuth.instance;
  final TwitterLogin _twitterLogin = TwitterLogin(
    apiKey: 'your_api_key',
    apiSecretKey: 'your_api_secret_key',
    redirectURI: 'twitter_callback_url',
  );

  Stream<User?> authStateChanges() => _auth.authStateChanges();

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<GoogleSignInAccount?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _auth.signInWithCredential(credential);
    }
    return googleUser;
  }

  Future<AccessToken?> signInWithFacebook() async {
    final LoginResult result = await _facebookAuth.login();
    if (result.status == LoginStatus.success) {
      final OAuthCredential credential = FacebookAuthProvider.credential(result.accessToken!.token);
      await _auth.signInWithCredential(credential);
      return result.accessToken;
    } else {
      throw FirebaseAuthException(code: 'ERROR_FACEBOOK_LOGIN', message: 'Facebook login failed');
    }
  }

  Future<AuthorizationResult> signInWithApple() async {
    final AuthorizationResult result = await AppleSignIn.performRequests([
      AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
    ]);
    if (result.error != null) {
      throw FirebaseAuthException(code: 'ERROR_APPLE_LOGIN', message: 'Apple login failed: ${result.error}');
    } else {
      final OAuthCredential credential = OAuthProvider('apple.com').credential(
        idToken: String.fromCharCodes(result.credential!.identityToken),
        accessToken: String.fromCharCodes(result.credential!.authorizationCode),
      );
      await _auth.signInWithCredential(credential);
    }
    return result;
  }

  Future<TwitterLoginResult> signInWithTwitter() async {
    final TwitterLoginResult result = await _twitterLogin.login();
    if (result.status == TwitterLoginStatus.loggedIn) {
      final OAuthCredential credential = TwitterAuthProvider.credential(
        accessToken: result.session!.token!,
        secret: result.session!.secret!,
      );
      await _auth.signInWithCredential(credential);
    } else {
      throw FirebaseAuthException(code: 'ERROR_TWITTER_LOGIN', message: 'Twitter login failed');
    }
    return result;
  }

  // Optional: Implement phone number authentication
  Future<void> verifyPhoneNumber(String phoneNumber) async {
    // Implementation for phone number verification (not shown in detail here)
  }

  Future<void> signInWithPhoneNumber(String verificationId, String smsCode) async {
    // Implementation for signing in with phone number (not shown in detail here)
  }
}
