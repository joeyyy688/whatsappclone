import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'package:whatsappclone/mediaQuery/size_helpers.dart';

class RouteErrorPage extends StatefulWidget {
  @override
  _RouteErrorPageState createState() => _RouteErrorPageState();
}

class _RouteErrorPageState extends State<RouteErrorPage> {
  Widget _buildChild() {
    return Column(
      children: [
        Container(
            padding: EdgeInsets.only(top: 10),
            //height: 30,
            child: Image.asset(
              'assets/images/undraw_No_data_re_kwbl.png',
              //width: 10,

              /*height: 230*/
            )),
        Container(
          child: Text(
            "Page Not Available!",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: displayWidth(context) * 0.05),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Platform.isIOS
              ? Icon(
                  Icons.arrow_back_ios,
                  size: displayWidth(context) * 0.071,
                  color: Theme.of(context).primaryColor,
                )
              : Icon(
                  Icons.arrow_back,
                  size: displayWidth(context) * 0.081,
                  color: Theme.of(context).primaryColor,
                ),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Page Error',
          style: TextStyle(
            fontSize: displayWidth(context) * 0.054,
            color: Theme.of(context).primaryColor,
            //fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: _buildChild(),
      ),
    );
  }
}
