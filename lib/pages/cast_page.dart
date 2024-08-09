import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:roci_app/api.dart';
import 'package:roci_app/assets/roci_app_icons.dart';
import 'package:roci_app/bottom_menu.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:roci_app/pages/main_page.dart';

class CastPage extends StatefulWidget {
  int contestId;

  CastPage(this.contestId);

  @override
  State<CastPage> createState() => _CastPageState(contestId);
}

class _CastPageState extends State<CastPage> {
  late int contestId;

  _CastPageState(int contestId1) {
    contestId = contestId1;
  }

  double convert_px_to_adapt_width(double px) {
    return MediaQuery.of(context).size.width / 392 * px;
  }

  double convert_px_to_adapt_height(double px) {
    return MediaQuery.of(context).size.height / 852 * px;
  }

  Widget header() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: convert_px_to_adapt_height(120),
        color: Color(0xffBAEE68),
        child: Column(
          children: [
            SizedBox(
              height: convert_px_to_adapt_height(60),
            ),
            Row(
              children: [
                Padding(
                    padding:
                        EdgeInsets.only(right: convert_px_to_adapt_width(22))),
                Icon(
                  Icons.arrow_back_ios_outlined,
                  color: Colors.black,
                ),
                Padding(
                  padding: EdgeInsets.only(left: convert_px_to_adapt_width(10)),
                  child: Text(
                    "Все события",
                    style: TextStyle(
                        color: Color(0xff000000),
                        fontSize: convert_px_to_adapt_height(20)),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  CachedNetworkImage cachedImage(String imageLink) {
    return CachedNetworkImage(
      // height: MediaQuery.of(context).size.height/3,
      // width: MediaQuery.of(context).size.width,
      progressIndicatorBuilder: (context, url, downloadProgress) => Center(
        child: CircularProgressIndicator(
          value: downloadProgress.progress,
          color: Color(0xffBAEE68),
        ),
      ),
      imageUrl: imageLink,
      fit: BoxFit.fitWidth,
    );
  }

  Widget bannerImage(String imageLink) {
    return cachedImage(imageLink);
  }

  Widget teamLogo(String imageLink, String name, double logoWidth) {
    return Container(
      width: logoWidth / 3,
      child: Column(
        children: [
          Container(
            width: logoWidth / 3,
            height: convert_px_to_adapt_height(80),
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(convert_px_to_adapt_width(15)),
                color: Color(0xffffffff),
                border: Border.all(color: Color(0xffBAEE68))),
            child: Center(
              child: cachedImage(imageLink),
            ),
          ),
          Container(
            width: logoWidth / 3,
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  Widget teams(Map<String, dynamic> data) {
    double containerWidth =
        MediaQuery.of(context).size.width - convert_px_to_adapt_width(120);
    return Container(
      width: containerWidth,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          teamLogo(
              data['first_team_icon'], data['first_team_name'], containerWidth),
          Padding(
            padding: EdgeInsets.only(top: convert_px_to_adapt_height(25)),
            child: Icon(
              RociAppIcons.x,
              size: convert_px_to_adapt_height(30),
            ),
          ),
          teamLogo(data['second_team_icon'], data['second_team_name'],
              containerWidth),
        ],
      ),
    );
  }

  Widget description(Map<String, dynamic> data) {
    double descriptionWidth =
        MediaQuery.of(context).size.width - convert_px_to_adapt_width(50);
    return Container(
      padding: EdgeInsets.only(
          left: convert_px_to_adapt_width(25),
          right: convert_px_to_adapt_width(25)),
      width: descriptionWidth,
      decoration: BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.circular(convert_px_to_adapt_width(36))),
      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.only(bottom: convert_px_to_adapt_height(15))),
          Align(
            alignment: Alignment.center,
            child: Text(
              data['card_header'],
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: convert_px_to_adapt_height(16)),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(bottom: convert_px_to_adapt_height(25))),
          Container(
            padding: EdgeInsets.only(left: convert_px_to_adapt_width(3)),
            child: Text(data['description']),
          )
        ],
      ),
    );
  }

  Widget enterCast() {
    return Padding(
      padding: EdgeInsets.zero,
      child: Text(
        "Введите прогнозируемый счёт",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: convert_px_to_adapt_height(16)),
      ),
    );
  }

  Widget scoreInput(TextEditingController controller, String teamName) {
    return Column(
      children: [
        Container(
          width: convert_px_to_adapt_width(70),
          height: convert_px_to_adapt_height(70),
          decoration: BoxDecoration(
              color: Color(0xffffffff),
              borderRadius:
                  BorderRadius.circular(convert_px_to_adapt_width(15))),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              width: convert_px_to_adapt_width(50),
              height: convert_px_to_adapt_height(40),
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                readOnly: inputReadOnly,
                inputFormatters: [LengthLimitingTextInputFormatter(2),FilteringTextInputFormatter.allow(RegExp('[0-9.,]+'))],
                style: TextStyle(
                    fontSize: convert_px_to_adapt_height(30),
                    fontWeight: FontWeight.bold),
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
          ),
        ),
        // Container(
        //   width: convert_px_to_adapt_width(70),
        //   child: Text(teamName,textAlign: TextAlign.center,),
        // )
      ],
    );
  }

  Widget castInputs(Map<String, dynamic> data) {
    double containerWidth =
        MediaQuery.of(context).size.width - convert_px_to_adapt_width(160);

    return FutureBuilder(future: getCasts(), builder: (BuildContext context,AsyncSnapshot snapshot){
      if (snapshot.hasData){
        List<dynamic> castsData = convert_snapshot_to_map(snapshot)['data'];
        for (Map<String,dynamic> cast in castsData){
          if (cast['contest_id'] == data['id']){
            List<String> prognoz = cast['prognoz'].split('-');
            firstInputController.text = prognoz[0];
            secondInputController.text = prognoz[1];
            inputReadOnly = true;
          }
        }
      }
      return Container(
        width: containerWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            scoreInput(firstInputController, data['first_team_name']),
            Padding(
              padding: EdgeInsets.only(top: convert_px_to_adapt_height(33)),
              child: Container(
                color: Color(0xff000000),
                width: convert_px_to_adapt_width(50),
                height: convert_px_to_adapt_height(2),
              ),
            ),
            scoreInput(secondInputController, data['second_team_name'])
          ],
        ),
      );
    });
  }

  Widget castButton() {
    return Container(
      width: MediaQuery.of(context).size.width - convert_px_to_adapt_width(150),
      height: convert_px_to_adapt_height(50),
      child: ElevatedButton(
        onPressed: () {
          sendCast(contestId.toString(), '${firstInputController.text}-${secondInputController.text}').then((response){
            Map<String,dynamic> data = convert_response_to_map(response);
            if (data['status'] == 'success'){
              Fluttertoast.showToast(
                  msg: 'Участие принято успешно!',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 15,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => MainPage(),
                  transitionDuration: Duration(milliseconds: 300),
                  transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
                ),
              );
            }
            else{
              Fluttertoast.showToast(
                  msg: data['message'],
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 15,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          });
        },
        child: Text("Учавствовать",style: TextStyle(color: Color(0xff000000)),),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xffBAEE68),
          foregroundColor: Colors.grey,
        ),
      ),
    );
  }

  bool inputReadOnly = false;

  TextEditingController firstInputController = TextEditingController();
  TextEditingController secondInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: getContest(contestId.toString()),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              Map<String, dynamic> data =
                  convert_snapshot_to_map(snapshot)['data'];
              return Column(
                children: [
                  header(),
                  bannerImage(data['banner_link']),
                  Padding(
                      padding: EdgeInsets.only(
                          bottom: convert_px_to_adapt_height(20))),
                  teams(data),
                  description(data),
                  Padding(
                      padding: EdgeInsets.only(
                          bottom: convert_px_to_adapt_height(25))),
                  enterCast(),
                  Padding(
                      padding: EdgeInsets.only(
                          bottom: convert_px_to_adapt_height(25))),
                  castInputs(data),
                  Padding(
                      padding: EdgeInsets.only(
                          bottom: convert_px_to_adapt_height(18))),
                  castButton(),
                  Padding(
                      padding: EdgeInsets.only(
                          bottom: convert_px_to_adapt_height(35)))
                ],
              );
            } else {
              return LinearProgressIndicator();
            }
          },
        ),
      ),
      backgroundColor: const Color(0xffECECEC),
      bottomNavigationBar: BottomMenuBar(currentIndex: 0, context: context,page: "Прогноз",),
    );
  }
}
