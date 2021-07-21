import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:whatsappclone/mediaQuery/size_helpers.dart';
import 'package:whatsappclone/style/style.dart';

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
  String _phoneNumber = "";

  Widget _buildCountryPicked(Country country) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: greenColor, width: 1),
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
            backgroundColor: Colors.white,
            foregroundColor: Colors.white,
          ),
          trailing: Text(
            "+${country.phoneCode}",
            style: TextStyle(color: Colors.grey[800]),
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
                searchCursorColor: Colors.black,
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
                )),
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
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    width: 1.50,
                    color: greenColor,
                  ))),
                  width: 60,
                  height: 42,
                  alignment: Alignment.center,
                  child: Text(" + ${_selectedFilteredDialogCountry.phoneCode}"),
                ),
                // SizedBox(
                //   width: 5.0,
                // ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    height: 40,
                    child: TextField(
                      controller: _phoneAuthController,
                      decoration: InputDecoration(hintText: "Phone Number"),
                    ),
                  ),
                ),
                // Expanded(
                //   child: Align(
                //     alignment: Alignment.bottomCenter,
                //     child: MaterialButton(
                //       color: greenColor,
                //       onPressed: () {},
                //       child: Text(
                //         "Next",
                //         style: TextStyle(
                //           fontSize: 18,
                //           color: Colors.white,
                //         ),
                //       ),
                //     ),
                //   ),
                // )
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
                      FirebaseAuth auth = FirebaseAuth.instance;
                      await auth.verifyPhoneNumber(
                        phoneNumber: '+' +
                            _selectedFilteredDialogCountry.phoneCode +
                            _phoneAuthController.text,
                        verificationCompleted:
                            (PhoneAuthCredential credential) async {
                          await auth.signInWithCredential(credential);
                          print(credential);
                        },
                        verificationFailed: (FirebaseAuthException e) {
                          if (e.code == 'invalid-phone-number') {
                            print('The provided phone number is not valid.');
                          }
                        },
                        codeSent:
                            (String verificationId, int? resendToken) async {
                          // Update the UI - wait for the user to enter the SMS code
                          // String smsCode = 'xxxx';

                          // Create a PhoneAuthCredential with the code
                          // PhoneAuthCredential credential =
                          //     PhoneAuthProvider.credential(
                          //         verificationId: verificationId,
                          //         smsCode: smsCode);

                          // Sign the user in (or link) with the credential
                          //await auth.signInWithCredential(credential);
                        },
                        timeout: const Duration(seconds: 60),
                        codeAutoRetrievalTimeout: (String verificationId) {},
                      );
                      print(_selectedFilteredDialogCountry.phoneCode);
                      print(_phoneAuthController.text);
                    },
                    child: Text(
                      'NEXT',
                    )))
          ],
        ),
      ),
    );
  }
}
