import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:roci_app/api.dart';
import 'package:roci_app/assets/roci_app_icons.dart';
import 'package:roci_app/bottom_menu.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:roci_app/header.dart';
import 'package:roci_app/pages/cast_page.dart';

class HistoryPage extends StatefulWidget {
  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  double convert_px_to_adapt_width(double px) {
    return MediaQuery.of(context).size.width / 392 * px;
  }

  double convert_px_to_adapt_height(double px) {
    return MediaQuery.of(context).size.height / 852 * px;
  }
  

  Widget castTypeSwitcher() {
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
                  choosedType = 'Активные';
                });
              },
              child: Container(
                alignment: Alignment.center,
                width: allSwitcherWidth / 2 - 3.1,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(convert_px_to_adapt_width(10)),
                  color: choosedType == 'Активные'
                      ? Color(0xffBAEE68)
                      : Color(0xffD9D9D9),
                ),
                child: Text("Активные"),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  choosedType = 'Завершённые';
                });
              },
              child: Container(
                width: allSwitcherWidth / 2 - 3,
                height: convert_px_to_adapt_height(45),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(convert_px_to_adapt_width(10)),
                  color: choosedType == 'Завершённые'
                      ? Color(0xffBAEE68)
                      : Color(0xffD9D9D9),
                ),
                child: Text("Завершённые"),
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

  String choosedType = 'Активные';

  Future<void> _refresh() async {
    // Perform some asynchronous operation to update the items list
    await Future.delayed(Duration(seconds: 1));
    setState(() {});
  }

  Widget castButton(String contestId, Map<String, dynamic> castData) {
    double containerWidth =
        MediaQuery.of(context).size.width - convert_px_to_adapt_width(50);
    List<Widget> lineSplitter = [];
    for (int i = 0;
        i < containerWidth - convert_px_to_adapt_width(20);
        i += 5) {
      lineSplitter.add(Container(
        height: 1,
        width: convert_px_to_adapt_width(3),
        color: Color(0xffA0A0A0),
      ));
      lineSplitter.add(Padding(
        padding: EdgeInsets.only(right: convert_px_to_adapt_width(2)),
      ));
    }
    List<String> castDateInfo = castData['time'].split('T')[0].split('-');
    String castDate =
        '${castDateInfo[2]}.${castDateInfo[1]}.${castDateInfo[0]}';
    return FutureBuilder(
        future: getContest(contestId),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic> data =
                convert_snapshot_to_map(snapshot)['data'];
            Widget castBtn = Padding(
              padding: EdgeInsets.only(top: convert_px_to_adapt_height(15)),
              child: Container(
                width: containerWidth,
                decoration: BoxDecoration(
                    color: Color(0xffffffff),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(convert_px_to_adapt_width(50)),
                        topRight:
                        Radius.circular(convert_px_to_adapt_width(50)),
                        bottomLeft:
                        Radius.circular(convert_px_to_adapt_width(20)),
                        bottomRight:
                        Radius.circular(convert_px_to_adapt_width(20)))),
                child: Column(
                  children: [
                    Container(
                      height: convert_px_to_adapt_height(30),
                      width: containerWidth,
                      decoration: BoxDecoration(
                          color: Color(0xffD9D9D9),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                  convert_px_to_adapt_width(20)),
                              topRight: Radius.circular(
                                  convert_px_to_adapt_width(20)))),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: convert_px_to_adapt_width(15)),
                          child: Text(
                            castDate,
                            style: TextStyle(color: Color(0xffB3B3B3)),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(
                                right: convert_px_to_adapt_width(15))),
                        Icon(data['sport_type'] == 'Хоккей'
                            ? RociAppIcons.hockey_icon
                            : RociAppIcons.ball_icon),
                        Padding(
                            padding: EdgeInsets.only(
                                right: convert_px_to_adapt_width(13))),
                        Container(
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
                                      width: containerWidth / 2,
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
                                      width: containerWidth / 2,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                      EdgeInsets.only(left: convert_px_to_adapt_width(10)),
                      child: Row(
                        children: lineSplitter,
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            bottom: convert_px_to_adapt_height(20))),
                    data['isActive'] ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: convert_px_to_adapt_width(12)),
                          child: Text("Прогнозируемый исход:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: convert_px_to_adapt_height(15)),),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: convert_px_to_adapt_width(10)),
                          child: Container(
                            width: convert_px_to_adapt_width(40),
                            height: convert_px_to_adapt_height(40),
                            decoration: BoxDecoration(
                                color: Color(0xffD9D9D9),
                                borderRadius: BorderRadius.circular(
                                    convert_px_to_adapt_width(7))),
                            child: Center(
                              child: Text(castData['prognoz']),
                            ),
                          ),
                        ),
                      ],
                    ) : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: convert_px_to_adapt_width(12)),
                          child: Text("Прогнозируемый исход:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: convert_px_to_adapt_height(10)),),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: convert_px_to_adapt_width(10)),
                          child: Container(
                            width: convert_px_to_adapt_width(30),
                            height: convert_px_to_adapt_height(30),
                            decoration: BoxDecoration(
                                color: castData['prognoz'] == data['result'] ? Color(0xffBAEE68) : Color(0xffEE6868),
                                borderRadius: BorderRadius.circular(
                                    convert_px_to_adapt_width(7))),
                            child: Center(
                              child: Text(castData['prognoz']),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: convert_px_to_adapt_width(12)),
                          child: Text("Исход:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: convert_px_to_adapt_height(10)),),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: convert_px_to_adapt_width(10)),
                          child: Container(
                            width: convert_px_to_adapt_width(30),
                            height: convert_px_to_adapt_height(30),
                            decoration: BoxDecoration(
                                color: Color(0xffD9D9D9),
                                borderRadius: BorderRadius.circular(
                                    convert_px_to_adapt_width(7))),
                            child: Center(
                              child: Text(data['result']),
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(bottom: convert_px_to_adapt_height(20)))
                  ],
                ),
              ),
            );

            if (choosedType == "Активные" && data['isActive']){
              return castBtn;
            }
            if (choosedType == "Завершённые" && !data['isActive']){
              return castBtn;
            }
            return Container();
          }
          return Container();
        });
  }

  Widget casts() {
    return FutureBuilder(
        future: getCasts(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic> data = convert_snapshot_to_map(snapshot);
            List<Widget> contestBtns = [];
            for (Map<String, dynamic> cast in data['data']) {
              contestBtns.add(castButton(cast['contest_id'].toString(), cast));
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
              HeaderWidget(text: "Мои прогнозы"),
              Padding(
                  padding:
                      EdgeInsets.only(bottom: convert_px_to_adapt_width(15))),
              castTypeSwitcher(),
              Padding(
                  padding:
                      EdgeInsets.only(bottom: convert_px_to_adapt_height(16))),
              casts()
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xffECECEC),
      bottomNavigationBar: BottomMenuBar(
        currentIndex: 1,
        context: context,
        page: "Мои прогнозы",
      ),
    );
  }
}
