import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:roci_app/api.dart';
import 'package:roci_app/assets/roci_app_icons.dart';
import 'package:roci_app/bottom_menu.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  Widget header() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: convert_px_to_adapt_height(120),
      color: Color(0xffBAEE68),
      child: Column(
        children: [
          SizedBox(height: convert_px_to_adapt_height(50)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: convert_px_to_adapt_width(25)),
                child: Text(
                  "Все события",
                  style: TextStyle(
                      color: Color(0xff000000),
                      fontWeight: FontWeight.bold,
                      fontSize: convert_px_to_adapt_height(25)),
                ),
              ),
              SizedBox(
                height: convert_px_to_adapt_height(60),
                width: convert_px_to_adapt_width(100),
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        height: convert_px_to_adapt_height(50),
                        width: convert_px_to_adapt_width(100),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                    convert_px_to_adapt_width(20.5)),
                                bottomLeft: Radius.circular(
                                    convert_px_to_adapt_width(20.5)))),
                        child: Image.asset('assets/photos/roci.png'),
                      ),
                    ),
                    Positioned(
                      child: Image.asset(
                        'assets/photos/russia.png',
                        scale: 0.9,
                      ),
                      left: 0,
                      bottom: 0,
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
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
                width: allSwitcherWidth / 2 - 3.1,
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
                width: allSwitcherWidth / 2 - 3,
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

  Widget contestButton(Map<String, dynamic> data) {
    double btnWidth =
        MediaQuery.of(context).size.width - convert_px_to_adapt_width(50);
    return GestureDetector(
      onTap: () {
        if (data['available']) {
        } else {
          Fluttertoast.showToast(
              msg: 'Данные конкурс доступен только нашим рефералам',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 15,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
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
                          child: Text(data['first_team_name']),
                          width: btnWidth -
                              convert_px_to_adapt_width(105) -
                              convert_px_to_adapt_width(60),
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
                          child: Text(data['second_team_name']),
                          width: btnWidth -
                              convert_px_to_adapt_width(105) -
                              convert_px_to_adapt_width(60),
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

  Widget contests() {
    return FutureBuilder(
        future: getContests(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic> data = convert_snapshot_to_map(snapshot);
            print(data);
            List<Widget> contestBtns = [];
            for (Map<String, dynamic> contest in data['data']) {
              if (contest['isActive'] == false) {
                continue;
              } else {
                if (contest['sport_type'] == choosedType) {
                  contestBtns.add(Padding(
                    padding:
                        EdgeInsets.only(top: convert_px_to_adapt_height(12)),
                    child: contestButton(contest),
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
          } else {
            print(snapshot);
          }
          return LinearProgressIndicator();
        });
  }


  String choosedType = 'Футбол';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            header(),
            Padding(
                padding: EdgeInsets.only(bottom: convert_px_to_adapt_width(15))),
            sportTypeSwitcher(),
            contests()
          ],
        ),
      ),
      backgroundColor: const Color(0xffECECEC),
      bottomNavigationBar: BottomMenuBar(currentIndex: 0, context: context),
    );
  }
}
