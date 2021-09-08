import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        color: Colors.white,
        child: TabBar(
          tabs: [
            Tab(
              text: 'green',
            ),
            Tab(
              text: 'green',
            )
          ],
          labelPadding: EdgeInsets.symmetric(vertical: 4),
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.red,
          ),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black,
          labelStyle: TextStyle(fontSize: 30),
          unselectedLabelStyle: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
