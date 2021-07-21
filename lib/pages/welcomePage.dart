import 'package:flutter/material.dart';
import 'package:whatsappclone/mediaQuery/size_helpers.dart';
import 'package:whatsappclone/pages/registrationPage.dart';
import 'package:whatsappclone/style/style.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Welcome to WhatsApp',
          style: TextStyle(
            fontSize: 25,
            fontFamily: 'NimbusSanL',
            color: darkPrimaryColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: whiteColor,
      ),
      body: Column(
        children: [
          Container(
            height: displayHeight(context) * 0.6,
            width: 290,
            child: Image.asset("assets/images/brand.png"),
          ),
          Text(
            "Read our Privacy Policy Tap, 'Agree and continue' to accept the Terms of Service",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'NimbusSanL',
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            width: 250,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: primaryColor,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(RegistrationPage.routeName);
              },
              child: Text(
                "AGREE AND CONTINUE",
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'NimbusSanL',
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
