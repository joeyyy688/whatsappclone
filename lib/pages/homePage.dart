import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:whatsappclone/animation/slidingAppBar.dart';
import 'package:whatsappclone/pages/home/callsPage.dart';
import 'package:whatsappclone/pages/home/cameraPage.dart';
import 'package:whatsappclone/pages/home/chatsPage.dart';
import 'package:whatsappclone/pages/home/statusPage.dart';
import 'package:whatsappclone/style/style.dart';

enum WhatsAppTab { Camera, Chats, Status, Calls }

class WhatsAppHomePage extends StatefulWidget {
  static const routeName = '/whatsappHomePage';
  WhatsAppHomePage({Key? key}) : super(key: key);

  @override
  _WhatsAppHomePageState createState() => _WhatsAppHomePageState();
}

class _WhatsAppHomePageState extends State<WhatsAppHomePage>
    with TickerProviderStateMixin {
  TabController? _tabController;
  Icon _fabIcon = Icon(Icons.chat);
  bool _isFabVisible = true;
  WhatsAppTab _currentViewingTab = WhatsAppTab.Chats;
  bool _isAppBarVisible = true;
  late final AnimationController _controller;

  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4, initialIndex: 1);
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 392),
    );
    // _tabController!.animation!.addStatusListener((status) {
    //   print(status);
    //   print(status);
    // });

    _tabController!.animation!.addListener(() {
      if (_tabController!.animation!.value != _tabController!.index) {
        {
          if (_tabController!.animation!.value.round() == 1) {
            setState(() {
              _fabIcon = Icon(Icons.chat);
              _isFabVisible = true;
              _isAppBarVisible = true;
              _currentViewingTab = WhatsAppTab.Chats;
            });
          } else if (_tabController!.animation!.value.round() == 2) {
            setState(() {
              _fabIcon = Icon(Icons.camera_alt_sharp);
              _isFabVisible = true;
              _isAppBarVisible = true;
              _currentViewingTab = WhatsAppTab.Status;
            });
          } else if (_tabController!.animation!.value.round() == 3) {
            setState(() {
              _fabIcon = Icon(Icons.add_call);
              _isFabVisible = true;
              _isAppBarVisible = true;
              _currentViewingTab = WhatsAppTab.Calls;
            });
          } else {
            setState(() {
              _isFabVisible = false;
              _isAppBarVisible = false;
              _currentViewingTab = WhatsAppTab.Camera;
            });
          }
        }
      }
    });
    _tabController!.addListener(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        initialIndex: 1,
        length: 4,
        child: Scaffold(
          appBar: SlidingAppBar(
              child: AppBar(
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
              controller: _controller,
              visible: _isAppBarVisible),
          body: TabBarView(
            controller: _tabController,
            children: [
              CameraPage(),
              ChatsPage(),
              StatusPage(),
              CallsPage(),
            ],
          ),
          floatingActionButton: Visibility(
            visible: _isFabVisible,
            child: FloatingActionButton(
                backgroundColor: greenColor,
                onPressed: () {
                  if (_currentViewingTab == WhatsAppTab.Chats) {
                  } else if (_currentViewingTab == WhatsAppTab.Status) {
                  } else if (_currentViewingTab == WhatsAppTab.Calls) {
                  } else {
                    return;
                  }
                },
                child: _fabIcon),
          ),
        ),
      ),
    );
  }
}
