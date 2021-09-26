import 'package:bluestack_flutter_app/common/shared_preference.dart';
import 'package:bluestack_flutter_app/ui/dashboard_page.dart';
import 'package:bluestack_flutter_app/ui/sign_in_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: getStringValuesSF('userLoggedIn'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData)
                return DashboardPage();
              else
                return SignIn();
            } else {
              return Scaffold(
                  body: Container(
                child: CircularProgressIndicator(),
              ));
            }
          },
        ),
      ),
    );
  }
}
