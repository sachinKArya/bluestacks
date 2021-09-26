import 'package:bluestack_flutter_app/repository/dashboard_repository.dart';
import 'package:flutter/material.dart';

class Constants {
  static var internetMessage = "Internet is not working. Please check.";
  static final dashboardContentUrl =
      "http://tournaments-dot-game-tv-prod.uc.r.appspot.com/tournament/api/tournaments_list_v2";
  static final TextEditingController usernameTextController =
      TextEditingController();
  static final TextEditingController passwordTextController =
      TextEditingController();
  static final Map validCredentialsMap = {
    '9898989898': 'password123',
    '9876543210': 'password123',
  };
  static final formGlobalKey = GlobalKey<FormState>();
  static final DashboardRepository dashboardRepository = DashboardRepository();
  static var userLoggedIn = false;
}
