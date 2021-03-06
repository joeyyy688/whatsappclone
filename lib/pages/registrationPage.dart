import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsappclone/mediaQuery/size_helpers.dart';
import 'package:whatsappclone/pages/homePage.dart';
import 'package:whatsappclone/pages/verificationPage.dart';
import 'package:whatsappclone/provider/appStateProvider.dart';
import 'package:whatsappclone/style/style.dart';

import 'whatsappHomePage.dart';

class RegistrationPage extends StatefulWidget {
  static const routeName = '/registrationPage';
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  static Country _selectedFilteredDialogCountry =
      CountryPickerUtils.getCountryByPhoneCode("92");

  String _countryCode = _selectedFilteredDialogCountry.phoneCode;
  //String _phoneNumber = "";
  //late CameraController _controller;

  Widget _buildCountryPicked(Country country) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: greenColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          SizedBox(
            width: 10,
          ),
          SizedBox(
            height: 8.0,
          ),
          Text("+${country.phoneCode}"),
          SizedBox(
            width: 10,
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            "${country.name}",
            softWrap: true,
          ),
          Spacer(),
          //Icon(Icons.arrow_drop_down)
        ],
      ),
    );
  }

  progressDialogue(
      BuildContext context, Widget? content, bool actionButtonAvailable) {
    //set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: whiteColor,
      elevation: 0,
      content: content,
      actions: [
        actionButtonAvailable
            ? TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              )
            : SizedBox()
      ],
    );
    showDialog(
      //prevent outside touch
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        //prevent Back button press
        return WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: alert);
      },
    );
  }

  continuationDialog(BuildContext context, String phoneNumber,
      void Function()? continuationFunction) {
    //set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: whiteColor,
      elevation: 0,
      content: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(children: [
          TextSpan(
            text: 'You entered the phone number: \n \n',
            style: TextStyle(
                fontFamily: 'NimbusSanL', height: 1.4, color: blackColor),
          ),
          TextSpan(
            text: '$phoneNumber \n \n',
            style: TextStyle(
              fontFamily: 'NimbusSanL',
              height: 1.4,
              fontWeight: FontWeight.w700,
              color: blackColor,
            ),
          ),
          TextSpan(
            text: 'Is this OK, or would you like to edit the number?',
            style: TextStyle(
              fontFamily: 'NimbusSanL',
              //height: 1.4,
              color: blackColor,
            ),
          ),
        ]),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("EDIT"),
            ),
            TextButton(
              onPressed: continuationFunction,
              child: Text("OK"),
            )
          ],
        ),
      ],
    );
    showDialog(
      //prevent outside touch
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        //prevent Back button press
        return WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: alert);
      },
    );
  }

  Widget _buildDialogItem(Country country) {
    return Container(
        height: 40,
        //alignment: Alignment.centerLeft,
        // decoration: BoxDecoration(
        //   border: Border(
        //     bottom: BorderSide(color: greenColor, width: 1),
        //   ),
        // ),
        child: ListTile(
          leading: CircleAvatar(
            child: CountryPickerUtils.getDefaultFlagImage(country),
            backgroundColor: whiteColor,
            foregroundColor: whiteColor,
          ),
          trailing: Text(
            "+${country.phoneCode}",
            style: TextStyle(color: darkgrey800),
          ),
          title: Text("${country.name}"),
        ));
  }

  TextEditingController _phoneAuthController = TextEditingController();
  void _openFilteredCountryPickerDialog() {
    showDialog(
        context: context,
        builder: (_) => Theme(
              data: Theme.of(context).copyWith(
                primaryColor: primaryColor,
              ),
              child: CountryPickerDialog(
                titlePadding: EdgeInsets.all(8.0),
                searchCursorColor: blackColor,
                searchInputDecoration: InputDecoration(
                  hintText: "Search",
                ),
                isSearchable: true,
                title: Text("Select your phone code"),
                onValuePicked: (Country country) {
                  setState(() {
                    _selectedFilteredDialogCountry = country;
                    _countryCode = country.phoneCode;
                  });
                },
                itemBuilder: _buildDialogItem,
              ),
            ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //_controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: whiteColor,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: whiteColor,
        title: Text(
          'Enter your phone number',
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(
                    text:
                        'WhatsApp will send an SMS message to verify your phone Number. ',
                    style: TextStyle(
                        fontFamily: 'NimbusSanL',
                        height: 1.4,
                        color: blackColor),
                  ),
                  TextSpan(
                    text: 'What\'s your number?',
                    style: TextStyle(
                      fontFamily: 'NimbusSanL',
                      height: 1.4,
                      color: lightSeaBlue,
                    ),
                    //   recognizer: TapGestureRecognizer()
                    // ..onTap = () => navigateToRegistration(context),
                  )
                ]),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ListTile(
              onTap: _openFilteredCountryPickerDialog,
              title: _buildCountryPicked(_selectedFilteredDialogCountry),
            ),
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 17),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    width: 1.50,
                    color: greenColor,
                  ))),
                  width: 60,
                  height: 42,
                  alignment: Alignment.center,
                  child: Text(
                    "+ ${_selectedFilteredDialogCountry.phoneCode}",
                  ),
                ),
                // SizedBox(
                //   width: 5.0,
                // ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 18),
                    height: 40,
                    child: TextFormField(
                      controller: _phoneAuthController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: "Phone Number",
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: MaterialButton(
                      color: lightSeaBlue,
                      onPressed: () async {
                        final appStateData =
                            Provider.of<AppState>(context, listen: false);

                        // Obtain a list of the available cameras on the device.
                        final cameras = await availableCameras();

                        // Assign all available cameras to the variable
                        List<CameraDescription> availableDeviceCameras =
                            cameras;

                        appStateData.initializeAvailableCameras(
                            cameras: availableDeviceCameras);

                        appStateData.initializeCameraController(
                            appStateData.selectedCamera);

                        appStateData.initializeCameraControllerFutures();
                        Navigator.of(context)
                            .pushNamed(WhatsAppHomePage.routeName);
                      },
                      child: Text(
                        "Test Page",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 40),
              padding: EdgeInsets.only(
                  top: 20,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 10,
                  left: 10,
                  right: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: darkPrimaryColor),
                onPressed: () async {
                  //LoadingWidget();
                  print(_selectedFilteredDialogCountry.phoneCode +
                      _phoneAuthController.text);

                  if (_phoneAuthController.text.length == 0) {
                    progressDialogue(
                        context,
                        ListTile(
                          leading: null,
                          title: Text(
                            "Please enter your phone number",
                            textAlign: TextAlign.left,
                          ),
                        ),
                        true);
                    return;
                  }

                  continuationDialog(
                      context,
                      '+' +
                          _selectedFilteredDialogCountry.phoneCode +
                          _phoneAuthController.text, () async {
                    Navigator.of(context).pop();

                    //Loading screen
                    progressDialogue(
                        context,
                        ListTile(
                          leading: CircularProgressIndicator(),
                          title: Text('Connecting...'),
                        ),
                        false);

                    //firebase verify phone number
                    FirebaseAuth auth = FirebaseAuth.instance;
                    await auth.verifyPhoneNumber(
                      phoneNumber: '+' +
                          _selectedFilteredDialogCountry.phoneCode +
                          _phoneAuthController.text,
                      verificationCompleted:
                          (PhoneAuthCredential credential) async {
                        await auth.signInWithCredential(credential);
                        print('yes');
                        print(credential);
                      },
                      verificationFailed: (FirebaseAuthException error) {
                        //close alert loading dialog
                        Navigator.pop(context);

                        progressDialogue(
                            context,
                            ListTile(
                              leading: null,
                              title: Text(error.message.toString()),
                            ),
                            true);

                        // if (e.code == 'invalid-phone-number') {
                        //   print('The provided phone number is not valid.');
                        // }
                      },
                      codeSent:
                          (String verificationId, int? resendToken) async {
                        print('yes2');
                        print(verificationId);
                        print(resendToken);

                        //initilaize verfication ID
                        Provider.of<AppState>(context, listen: false)
                            .setVerficationID(verificationId);

                        //close alert loading dialog
                        Navigator.pop(context);

                        //Navigate to enter pinCode
                        Navigator.of(context)
                            .pushNamed(VerificationPage.routeName);
                      },
                      timeout: const Duration(seconds: 10),
                      codeAutoRetrievalTimeout: (String verificationId) {
                        print(verificationId);
                      },
                    );
                    // print(_selectedFilteredDialogCountry.phoneCode);
                    // print(_phoneAuthController.text);

                    //initilialize country code with phone number entered
                    Provider.of<AppState>(context, listen: false)
                        .setUserPhoneNumber(
                            _selectedFilteredDialogCountry.phoneCode +
                                _phoneAuthController.text);
                  });
                },
                child: Text(
                  'NEXT',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
