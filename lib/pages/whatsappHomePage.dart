import 'dart:ui';

import 'package:dashed_circle/dashed_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:whatsappclone/style/style.dart';
import 'package:whatsappclone/widgets/customBadgeWidget.dart';
import 'package:whatsappclone/widgets/customTabBarWidget.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/homePage';
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            primary: true,
            toolbarHeight: 40,
            snap: true,
            pinned: true,
            floating: true,
            leading: Center(
              child: FaIcon(
                FontAwesomeIcons.whatsapp,
              ),
            ),
            automaticallyImplyLeading: false,
            title: Text("WhatsApp"),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.search_rounded),
              )
            ],
            expandedHeight: 200.0,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.none,
              //titlePadding: EdgeInsetsDirectional.only(start: 100, bottom: 0),
              stretchModes: [
                StretchMode.blurBackground,
                StretchMode.zoomBackground,
                //StretchMode.fadeTitle
              ],
              background: Container(
                //color: Colors.white,
                // decoration: BoxDecoration(
                //     gradient: LinearGradient(
                //         begin: Alignment.centerLeft,
                //         end: Alignment.centerRight,
                //         colors: [darkPrimaryColor, Colors.black])),
                padding: EdgeInsets.only(top: 70),
                height: 100.0,
                child: new ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Card(
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        side: BorderSide(
                          color: Colors.black12,
                          width: 0.9,
                        ),
                      ),
                      child: new Container(
                          width: 90.0,
                          height: 50.0,
                          child: Column(
                            children: [
                              CustomBadge(
                                color: Colors.white,
                                item: Icon(
                                  Icons.add_circle_outlined,
                                  size: 22,
                                  color: Colors.blue,
                                ),
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 16),
                                  child: DashedCircle(
                                    strokeWidth: 1,
                                    dashes: 0,
                                    child: Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: CircleAvatar(
                                        radius: 25.0,
                                        backgroundImage: AssetImage(
                                            'assets/images/userAvatar.png'),
                                        backgroundColor: Colors.transparent,
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.add,
                                            color: Colors.transparent,
                                          ),
                                          onPressed: () {},
                                        ),
                                        // backgroundImage: NetworkImage(
                                        //     ''),
                                      ),
                                    ),
                                    color: Colors.deepOrangeAccent,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 20),
                                child: Text(
                                  "Create\nYour Story",
                                  style: TextStyle(fontSize: 12),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // SliverFixedExtentList(
          //   itemExtent: 100,
          //   delegate: SliverChildListDelegate([
          //     Container(
          //       height: 100.0,
          //       child: new ListView(
          //         scrollDirection: Axis.horizontal,
          //         children: new List.generate(10, (int index) {
          //           return new Card(
          //             color: Colors.blue[index * 100],
          //             child: new Container(
          //               width: 50.0,
          //               height: 50.0,
          //               child: new Text("$index"),
          //             ),
          //           );
          //         }),
          //       ),
          //     ),
          //   ]),
          // ),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              height: 700,
              child: MaterialApp(
                home: DefaultTabController(
                  length: 2,
                  child: Scaffold(
                    appBar: PreferredSize(
                      preferredSize: Size.fromHeight(30.0),
                      child: AppBar(
                        backgroundColor: Colors.white,
                        elevation: 0,
                        bottom: TabBar(
                          unselectedLabelColor: Colors.redAccent,
                          //indicatorSize: TabBarIndicatorSize.tab,
                          indicator: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Colors.redAccent,
                                Colors.orangeAccent
                              ]),
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.redAccent),
                          tabs: [
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                "Chats",
                                style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.043,
                                    color: Color(0xFF002A66),
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            Text(
                              "Group",
                              style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.043,
                                  color: Color(0xFF002A66),
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ),
                    body: TabBarView(children: [
                      Tab(
                        text: 'green',
                      ),
                      Tab(
                        text: 'green',
                      )
                    ]),
                  ),
                ),
              ),
            )
            // Container(
            //   height: 300,
            //   child: DefaultTabController(
            //       length: 2,
            //       child: Stack(
            //         children: [
            //           TabBarView(children: [
            //             Container(
            //               color: Colors.green,
            //             ),
            //             Container(
            //               color: Colors.blueAccent,
            //             )
            //           ]),
            //           Align(
            //             alignment: Alignment.bottomCenter,
            //             child: Padding(
            //               padding: EdgeInsets.all(20),
            //               child: CustomTabBar(),
            //             ),
            //           )
            //         ],
            //       )),
            // )
          ])),
        ],
      ),
    );
  }
}
