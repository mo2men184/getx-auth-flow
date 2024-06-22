import 'package:get/get.dart';
import 'views/login_view.dart';
import 'views/signup_view.dart';
import 'views/home_view.dart';

class Routes {
  static const LOGIN = '/login';
  static const SIGNUP = '/signup';
  static const HOME = '/home';

  static final pages = [
    GetPage(name: LOGIN, page: () => LoginView()),
    GetPage(name: SIGNUP, page: () => SignupView()),
    GetPage(name: HOME, page: () => HomeView()),
  ];
}
