import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:roci_app/api.dart';
import 'package:roci_app/assets/roci_app_icons.dart';
import 'package:roci_app/bottom_menu.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:roci_app/header.dart';
import 'package:roci_app/pages/cast_page.dart';
import 'package:roci_app/pages/contest_info.dart';

class ArchivePage extends StatefulWidget {
  @override
  State<ArchivePage> createState() => _MainChooseState();
}

class _MainChooseState extends State<ArchivePage> {
  double convert_px_to_adapt_width(double px) {
    return MediaQuery.of(context).size.width / 392 * px;
  }

  double convert_px_to_adapt_height(double px) {
    return MediaQuery.of(context).size.height / 852 * px;
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
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => ArchiveContestPage(data['id'].toString()),
            transitionDuration: Duration(milliseconds: 300),
            transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
          ),
        );
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
        future: getArchive(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic> data = convert_snapshot_to_map(snapshot);
            List<Widget> contestBtns = [];
            for (Map<String, dynamic> contest in data['data']) {
              if (contest['isActive'] == true) {
                continue;
              } else {
                contestBtns.add(Padding(
                  padding:
                  EdgeInsets.only(top: convert_px_to_adapt_height(12)),
                  child: contestButton(contest),
                ));
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
          }
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refresh,
        color: Color(0xffBAEE68),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              HeaderWidget(text: 'Архив конкурсов'),
              Padding(
                  padding: EdgeInsets.only(bottom: convert_px_to_adapt_width(15))),
              contests(),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xffECECEC),
      bottomNavigationBar: BottomMenuBar(currentIndex: 2, context: context,page: "Архив конкурсов",),
    );
  }
}

