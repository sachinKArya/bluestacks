import 'package:bluestack_flutter_app/common/constants.dart';
import 'package:bluestack_flutter_app/custom_widgets/custom_text_input_field.dart';
import 'package:bluestack_flutter_app/ui/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Column(
        children: <Widget>[
          Flexible(child: topContainer(_size)),
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                key: Constants.formGlobalKey,
                child: Column(
                  children: [
                    CustomTextInputField(
                      prefixIcon: Icons.person,
                      hintText: 'Username',
                      editingController: Constants.usernameTextController,
                    ),
                    CustomTextInputField(
                      prefixIcon: Icons.lock,
                      hintText: 'Password',
                      editingController: Constants.passwordTextController,
                    ),
                    signInButton(_size, context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  signInButton(Size _size, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          height: 60,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.teal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              minimumSize: Size(_size.width, 50),
            ),
            onPressed: () async {
              if (Constants.formGlobalKey.currentState.validate()) {
                if (Constants.validCredentialsMap[
                        Constants.usernameTextController.text] ==
                    Constants.passwordTextController.text) {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setString('userLoggedIn', "Yes");
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DashboardPage(),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Username or Password is incorrect')));
                  Constants.usernameTextController.text = "";
                  Constants.passwordTextController.text = "";
                }
              }
            },
            child: Text(
              'Sign In',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container topContainer(Size _size) {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      margin: EdgeInsets.only(bottom: 20),
      height: _size.height * 0.4,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/images/login_image.jpeg'),
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 40,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Welcome',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'to BlueStacks',
                style: TextStyle(color: Colors.white, fontSize: 28),
              ),
            ),
          )
        ],
      ),
    );
  }
}
