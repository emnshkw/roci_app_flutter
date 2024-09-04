import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:roci_app/api.dart';
import 'package:roci_app/assets/roci_app_icons.dart';
import 'package:roci_app/bottom_menu.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:roci_app/header.dart';
import 'package:roci_app/pages/cast_page.dart';
import 'package:roci_app/pages/chat_page.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainChooseState();
}

class _MainChooseState extends State<MainPage> {
  double convert_px_to_adapt_width(double px) {
    return MediaQuery.of(context).size.width / 392 * px;
  }

  double convert_px_to_adapt_height(double px) {
    return MediaQuery.of(context).size.height / 852 * px;
  }

  Widget sportTypeSwitcher() {
    double allSwitcherWidth =
        MediaQuery.of(context).size.width - convert_px_to_adapt_width(50);
    return Padding(
      padding: EdgeInsets.only(
          left: convert_px_to_adapt_width(25),
          right: convert_px_to_adapt_width(25)),
      child: Container(
        width: allSwitcherWidth,
        height: convert_px_to_adapt_height(45),
        padding: EdgeInsets.all(convert_px_to_adapt_width(3)),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(convert_px_to_adapt_width(10)),
            color: Color(0xffD9D9D9)),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  choosedType = 'Футбол';
                });
              },
              child: Container(
                alignment: Alignment.center,
                width: allSwitcherWidth / 2 - convert_px_to_adapt_width(3.08),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(convert_px_to_adapt_width(10)),
                  color: choosedType == 'Футбол'
                      ? Color(0xffBAEE68)
                      : Color(0xffD9D9D9),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Футбол"),
                    Padding(
                        padding: EdgeInsets.only(
                            right: convert_px_to_adapt_width(8))),
                    Icon(RociAppIcons.ball_icon)
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  choosedType = 'Хоккей';
                });
              },
              child: Container(
                width: allSwitcherWidth / 2 - convert_px_to_adapt_width(3.3),
                height: convert_px_to_adapt_height(45),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(convert_px_to_adapt_width(10)),
                  color: choosedType == 'Хоккей'
                      ? Color(0xffBAEE68)
                      : Color(0xffD9D9D9),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Хоккей"),
                    Padding(
                        padding: EdgeInsets.only(
                            right: convert_px_to_adapt_width(8))),
                    Icon(RociAppIcons.hockey_icon)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  CachedNetworkImage cachedImage(String imageLink) {
    return CachedNetworkImage(
      height: convert_px_to_adapt_height(50),
      width: convert_px_to_adapt_width(50),
      progressIndicatorBuilder: (context, url, downloadProgress) => Center(
        child: CircularProgressIndicator(
          value: downloadProgress.progress,
          color: Color(0xffBAEE68),
        ),
      ),
      imageUrl: imageLink,
    );
  }

  Widget contestButton(Map<String, dynamic> data, bool gotToken) {
    double btnWidth =
        MediaQuery.of(context).size.width - convert_px_to_adapt_width(50);
    return GestureDetector(
      onTap: () {
        if (data['available'] && gotToken) {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => CastPage(data['id']),
              transitionDuration: Duration(milliseconds: 300),
              transitionsBuilder: (_, a, __, c) =>
                  FadeTransition(opacity: a, child: c),
            ),
          );
        } else {
          if (!gotToken) {
            Fluttertoast.showToast(
                msg:
                    'Чтобы принять участие в конкурсе, выполните вход или зарегистрируйтесь!\nСделать это можно на странице "Профиль"',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 15,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          } else {
            Fluttertoast.showToast(
                msg: 'Данный конкурс доступен только нашим рефералам',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 15,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        }
      },
      child: Container(
        width: btnWidth,
        // height: 200,
        padding: EdgeInsets.only(
            top: convert_px_to_adapt_height(15),
            bottom: convert_px_to_adapt_height(10),
            left: convert_px_to_adapt_width(13),
            right: convert_px_to_adapt_width(13)),
        decoration: BoxDecoration(
            color: Color(0xffffffff),
            borderRadius: BorderRadius.circular(convert_px_to_adapt_width(20))),
        child: Row(
          children: [
            Icon(data['sport_type'] == 'Хоккей'
                ? RociAppIcons.hockey_icon
                : RociAppIcons.ball_icon),
            Padding(
                padding: EdgeInsets.only(right: convert_px_to_adapt_width(13))),
            Container(
              width: btnWidth - convert_px_to_adapt_width(103),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        cachedImage(data['first_team_icon']),
                        Padding(
                          padding: EdgeInsets.only(
                              right: convert_px_to_adapt_width(7)),
                        ),
                        Container(
                          width: btnWidth -
                              convert_px_to_adapt_width(105) -
                              convert_px_to_adapt_width(60),
                          child: Text(data['first_team_name']),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        cachedImage(data['second_team_icon']),
                        Padding(
                          padding: EdgeInsets.only(
                              right: convert_px_to_adapt_width(7)),
                        ),
                        Container(
                          width: btnWidth -
                              convert_px_to_adapt_width(105) -
                              convert_px_to_adapt_width(60),
                          child: Text(data['second_team_name']),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              child: CircleAvatar(
                backgroundColor: Color(0xffBAEE68),
                child: Center(
                  child: Icon(
                    data['available']
                        ? RociAppIcons.open_icon
                        : RociAppIcons.close_icon,
                    color: Color(0xff000000),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget unlockBtn() {
    return Padding(
      padding: EdgeInsets.only(top: convert_px_to_adapt_height(15)),
      child: Container(
        width:
            MediaQuery.of(context).size.width - convert_px_to_adapt_width(50),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => ChatPage(),
                transitionDuration: Duration(milliseconds: 300),
                transitionsBuilder: (_, a, __, c) =>
                    FadeTransition(opacity: a, child: c),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xffBAEE68),
              foregroundColor: Color(0xff000000)),
          child: Text(
            "Разблокировать конкурсы",
            style: TextStyle(color: Color(0xff000000)),
          ),
        ),
      ),
    );
  }

  Widget contests() {
    return FutureBuilder(
        future: getContests(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic> data = convert_snapshot_to_map(snapshot);
            List<Widget> contestBtns = [];
            bool unlockAdded = false;
            for (Map<String, dynamic> contest in data['data']) {
              if (contest['available'] == false &&
                  !unlockAdded &&
                  contest['sport_type'] == choosedType) {
                contestBtns.insert(0, unlockBtn());
                unlockAdded = true;
              }
              if (contest['isActive'] == false) {
                continue;
              } else {
                if (contest['sport_type'] == choosedType) {
                  contestBtns.add(Padding(
                    padding:
                        EdgeInsets.only(top: convert_px_to_adapt_height(12)),
                    child: contestButton(contest, data['gotToken']),
                  ));
                }
              }
            }
            if (contestBtns.length != 0) {
              return Column(
                children: contestBtns,
              );
            } else {
              return Padding(
                padding: EdgeInsets.only(top: convert_px_to_adapt_height(100)),
                child: Center(
                  child: Text("На данный вид спорта не найдены конкурсы"),
                ),
              );
            }
          } else {}
          return LinearProgressIndicator();
        });
  }

  String choosedType = 'Футбол';

  Future<void> _refresh() async {
    // Perform some asynchronous operation to update the items list
    await Future.delayed(Duration(seconds: 1));
    setState(() {});
  }

  @override
  void initState() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed){
      if (!isAllowed){
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    super.initState();
  }

  triggerNotification(var data){
    AwesomeNotifications().createNotification(content: NotificationContent(largeIcon:'resourse://@mipmap/ic_launcher',id: data['id'], channelKey: 'roci_channel',title:data['title'],body:data['text']));
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.delta.dx > 5) {
          setState(() {
            choosedType = "Футбол";
          });
        } else if (details.delta.dx < -5) {
          setState(() {
            choosedType = "Хоккей";
          });
        }
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => ChatPage(),
                transitionDuration: Duration(milliseconds: 300),
                transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
              ),
            );
          },
          child: Stack(
            children: [
              Center(
                child: Icon(
                  Icons.chat,
                  size: convert_px_to_adapt_height(35),
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                child: StreamBuilder(
                  stream: getMessageCountStream(),
                  builder: (BuildContext context,AsyncSnapshot snapshot){
                    if (snapshot.hasData){
                      Map <String,dynamic> data = convert_snapshot_to_map(snapshot);
                      if (data['message'] != 0 && data['message']!=null){
                        print(data['message']);
                        return CircleAvatar(
                          child: Text(data['message'].toString()),
                          radius: convert_px_to_adapt_width(12),
                          backgroundColor: Color(0xffff0000),
                        );
                      }
                    }
                    return Text('');

                  },
                ),
              )
            ],
          ),
        ),
        body: RefreshIndicator(
          onRefresh: _refresh,
          color: Color(0xffBAEE68),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                StreamBuilder(stream: getNotifications(), builder: (BuildContext context,AsyncSnapshot snapshot){
                  if (snapshot.hasData){
                    Map<String,dynamic> data = convert_snapshot_to_map(snapshot);
                    for (Map<String, dynamic> notificationData in data['message']) {
                      triggerNotification(notificationData);
                    }
                  }
                  return SizedBox();
                }),
                HeaderWidget(text: 'Все события'),
                Padding(
                    padding:
                        EdgeInsets.only(bottom: convert_px_to_adapt_width(15))),
                sportTypeSwitcher(),
                contests(),
              ],
            ),
          ),
        ),
        backgroundColor: const Color(0xffECECEC),
        bottomNavigationBar: BottomMenuBar(
          currentIndex: 0,
          context: context,
          page: "Все события",
        ),
      ),
    );
  }
}
