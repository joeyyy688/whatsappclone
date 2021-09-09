import 'package:flutter/material.dart';
import 'package:whatsappclone/pages/home/callsPage.dart';
import 'package:whatsappclone/pages/home/cameraPage.dart';
import 'package:whatsappclone/pages/home/chatsPage.dart';
import 'package:whatsappclone/pages/home/statusPage.dart';
import 'package:whatsappclone/style/style.dart';

class WhatsAppHomePage extends StatefulWidget {
  static const routeName = '/whatsappHomePage';
  WhatsAppHomePage({Key? key}) : super(key: key);

  @override
  _WhatsAppHomePageState createState() => _WhatsAppHomePageState();
}

class _WhatsAppHomePageState extends State<WhatsAppHomePage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  Icon fabIcon = Icon(Icons.chat);

  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
    _tabController!.animation!.addStatusListener((status) {
      print(status);
      print(status);
    });
    _tabController!.animation!.addListener(() {});
    _tabController!.addListener(() {
      //i'll be back
      print("${_tabController!.index}");
      if (_tabController!.index == 2) {
        setState(() {
          fabIcon = Icon(Icons.camera_alt_sharp);
        });
      } else if (_tabController!.index == 1) {
        setState(() {
          fabIcon = Icon(Icons.chat);
        });
      } else if (_tabController!.index == 3) {
        setState(() {
          fabIcon = Icon(Icons.add_call);
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        initialIndex: 2,
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: darkPrimaryColor,
            automaticallyImplyLeading: false,
            title: Text("WhatsApp"),
            bottom: TabBar(
              isScrollable: true,
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Colors.white,
              labelPadding: EdgeInsets.symmetric(horizontal: 24.6),
              tabs: [
                Tab(icon: Icon(Icons.camera_alt)),
                Tab(
                  text: 'CHATS',
                ),
                Tab(
                  text: 'STATUS',
                ),
                Tab(
                  text: 'CALLS',
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.more_vert_outlined),
              ),
            ],
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              CameraPage(),
              ChatsPage(),
              StatusPage(),
              CallsPage(),
            ],
          ),
          floatingActionButton: FloatingActionButton(
              backgroundColor: greenColor, onPressed: () {}, child: fabIcon),
        ),
      ),
    );
  }
}
