import 'package:flutter/material.dart';

class CallsPage extends StatefulWidget {
  CallsPage({Key? key}) : super(key: key);

  @override
  _CallsPageState createState() => _CallsPageState();
}

class _CallsPageState extends State<CallsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Calls'),
      ),
    );
  }
}
