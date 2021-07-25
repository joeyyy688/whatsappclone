import 'dart:async';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsappclone/mediaQuery/size_helpers.dart';
import 'package:whatsappclone/provider/appState.provider.dart';
import 'package:whatsappclone/style/style.dart';
import 'package:whatsappclone/widgets/verificationForm.dart';

class VerificationPage extends StatefulWidget {
  static const routeName = '/verficationPage';

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  late Timer _timer;
  int timerMaxSeconds = 60;
  int currentSeconds = 0;

  void startTimer({int extraTime = 0}) {
    timerMaxSeconds += extraTime;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (timerMaxSeconds == 0) {
          currentSeconds = timer.tick;
          // timerMaxSeconds = 0;
          timer.cancel();
        } else {
          setState(() {
            timerMaxSeconds--;
          });
        }
      },
    );
  }

  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}:${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

  Widget _buildDrawerOption({
    required Icon icon,
    required String title,
    required VoidCallback onTapHandler,
  }) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: ListTile(
        enabled: timerMaxSeconds == 0 ? true : false,
        dense: true,
        leading: icon,
        title: Text(
          title,
          style: TextStyle(
              color: timerMaxSeconds == 0 ? primaryColor : dividerColor,
              fontSize: 14,
              fontWeight: FontWeight.bold),
        ),
        onTap: onTapHandler,
        trailing: timerMaxSeconds == 0 ? Text("") : Text("$timerText"),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Consumer<AppState>(
          builder: (context, appStateValue, child) {
            return AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: whiteColor,
              title: Text(
                'Verify +${appStateValue.userPhoneNumber}',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'NimbusSanL',
                  color: darkPrimaryColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
              actions: [
                PopupMenuButton(
                  tooltip: "Help",
                  icon: Icon(
                    Icons.more_vert_outlined,
                    size: displayWidth(context) * 0.07,
                    color: black45,
                  ),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      child: Text(
                        "Help",
                        style: TextStyle(
                          color: blackColor,
                          fontSize: 18,
                          fontFamily: 'NimbusSanL',
                        ),
                      ),
                    ),
                  ],
                  onSelected: (value) {
                    if (value == 1) {
                      //...what should the help button do
                    }
                  },
                )
              ],
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Consumer<AppState>(
              builder: (context, appStateValue, child) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'Waiting to automatically detect an SMS sent to ',
                        style: TextStyle(
                            fontFamily: 'NimbusSanL',
                            height: 1.4,
                            color: blackColor),
                      ),
                      TextSpan(
                        text: '+${appStateValue.userPhoneNumber}. ',
                        style: TextStyle(
                            fontFamily: 'NimbusSanL',
                            height: 1.4,
                            color: blackColor,
                            fontWeight: FontWeight.bold),
                        //   recognizer: TapGestureRecognizer()
                        // ..onTap = () => navigateToRegistration(context),
                      ),
                      TextSpan(
                        text: 'Wrong number?',
                        style: TextStyle(
                          fontFamily: 'NimbusSanL',
                          height: 1.4,
                          color: lightSeaBlue,
                        ),
                        //   recognizer: TapGestureRecognizer()
                        // ..onTap = () => navigateToRegistration(context),
                      ),
                    ]),
                  ),
                );
              },
            ),
            VerificationCodeInput(
              onCompleted: (value) async {
                print(value);
                // Update the UI - wait for the user to enter the SMS code
                String smsCode = value;
                FirebaseAuth auth = FirebaseAuth.instance;
                final providerAppState =
                    Provider.of<AppState>(context, listen: false);
                //Create a PhoneAuthCredential with the code
                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                    verificationId: providerAppState.verficationId,
                    smsCode: smsCode);

                // Sign the user in (or link) with the credential
                await auth.signInWithCredential(credential);
              },
              length: 6,
              keyboardType: TextInputType.number,
              autofocus: true,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Enter 6-digit code",
                style: TextStyle(color: dividerColor),
              ),
            ),
            _buildDrawerOption(
                icon: Icon(
                  Icons.message_outlined,
                  color: timerMaxSeconds == 0 ? primaryColor : dividerColor,
                  size: 25,
                ),
                onTapHandler: () {
                  startTimer(extraTime: 60);
                  print("sss");
                },
                title: "Resend SMS"),
            Divider(
              thickness: 1,
              endIndent: 10,
              indent: 10,
              color: dividerColor,
            ),
            _buildDrawerOption(
                icon: Icon(
                  Icons.phone_sharp,
                  color: timerMaxSeconds == 0 ? primaryColor : dividerColor,
                  size: 25,
                ),
                onTapHandler: () {
                  startTimer(extraTime: 60);
                  print("sss");
                },
                title: "Call Me"),
          ],
        ),
      ),
    );
  }
}
