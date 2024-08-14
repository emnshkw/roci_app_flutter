import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:roci_app/api.dart';
import 'package:roci_app/assets/roci_app_icons.dart';
import 'package:roci_app/bottom_menu.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:roci_app/header.dart';
import 'package:roci_app/pages/archive_page.dart';
import 'package:roci_app/pages/cast_page.dart';
import 'package:roci_app/pages/chat_page.dart';
import 'package:roci_app/pages/login_page.dart';
import 'package:roci_app/pages/main_page.dart';
import 'package:roci_app/pages/registration_page.dart';
import 'package:roci_app/pages/support_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  double convert_px_to_adapt_width(double px) {
    return MediaQuery.of(context).size.width / 392 * px;
  }

  double convert_px_to_adapt_height(double px) {
    return MediaQuery.of(context).size.height / 852 * px;
  }

  String choosedType = 'Активные';

  Future<void> _refresh() async {
    // Perform some asynchronous operation to update the items list
    await Future.delayed(Duration(seconds: 1));
    setState(() {});
  }

  Widget authButtons() {
    return Padding(
      padding: EdgeInsets.only(
          top: convert_px_to_adapt_height(40),
          left: convert_px_to_adapt_width(40),
          right: convert_px_to_adapt_width(40)),
      child: Container(
        width:
            MediaQuery.of(context).size.width - convert_px_to_adapt_width(80),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: convert_px_to_adapt_width(150),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) =>RegistrationPage(),
                      transitionDuration: Duration(milliseconds: 300),
                      transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
                    ),
                  );
                },
                child: Text(
                  'Регистрация',
                  style: TextStyle(color: Color(0xff000000)),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffBAEE68),
                    foregroundColor: Colors.grey),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(right: convert_px_to_adapt_width(25))),
            Container(
              width: convert_px_to_adapt_width(125),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) =>LoginPage(),
                        transitionDuration: Duration(milliseconds: 300),
                        transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
                      ),
                    );
                  },
                  child: Text('Вход'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                            color: Color(0xffBAEE68),
                            width: convert_px_to_adapt_height(3))),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget profileButton(Icon icon, String text, double containerWidth,Function func) {
    return GestureDetector(
      onTap: (){
        func();
      },
      child: SizedBox(
        width: containerWidth - convert_px_to_adapt_width(48),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                icon,
                Padding(
                    padding:
                    EdgeInsets.only(right: convert_px_to_adapt_width(6))),
                Text(text),
              ],
            ),
            Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }

  Widget profileButtons() {
    double containerWidth =
        MediaQuery.of(context).size.width - convert_px_to_adapt_width(50);
    return Padding(
      padding: EdgeInsets.only(
          top: convert_px_to_adapt_height(33),
          left: convert_px_to_adapt_width(25),
          right: convert_px_to_adapt_width(25)),
      child: Container(
        padding: EdgeInsets.only(
            bottom: convert_px_to_adapt_height(25),
            top: convert_px_to_adapt_height(25),
            left: convert_px_to_adapt_width(24),
            right: convert_px_to_adapt_width(24)),
        width: containerWidth,
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.circular(convert_px_to_adapt_width(25)),
        ),
        child: Column(
          children: [
            profileButton(Icon(RociAppIcons.history_icon), "История прогнозов",
                containerWidth,(){}),
            Divider(color: Color(0xff949494)),
            profileButton(Icon(Icons.currency_exchange), "Архив конкурсов",
                containerWidth,(){
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => ArchivePage(),
                      transitionDuration: Duration(milliseconds: 300),
                      transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
                    ),
                  );
                }),
            // Divider(color: Color(0xff949494)),
            // profileButton(Icon(RociAppIcons.ref_icon), "Реферальный клуб",
            //     containerWidth,(){}),
            Divider(color: Color(0xff949494)),
            profileButton(Icon(RociAppIcons.profile_icon), "Личные данные",
                containerWidth,(){}),
            Divider(color: Color(0xff949494)),
            profileButton(Icon(RociAppIcons.support_icon), "Служба поддержки",
                containerWidth,(){
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => SupportPage(),
                      transitionDuration: Duration(milliseconds: 300),
                      transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
                    ),
                  );
                }),
            Divider(color: Color(0xff949494)),
            profileButton(
                Icon(RociAppIcons.info_icon), "Условия", containerWidth,(){}),
            Divider(color: Color(0xff949494)),
            profileButton(
                Icon(Icons.chat), "Связь с оператором", containerWidth,(){
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => ChatPage(),
                  transitionDuration: Duration(milliseconds: 300),
                  transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
                ),
              );
            }),
            // Divider(color: Color(0xff949494)),
            // profileButton(
            //     Icon(RociAppIcons.settings_icon), "Настройки", containerWidth,(){}),
            Divider(color: Color(0xff949494)),
            profileButton(
                Icon(Icons.exit_to_app), "Выйти из аккаунта", containerWidth,(){
                  logout();
                  delete_token();
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => MainPage(),
                      transitionDuration: Duration(milliseconds: 300),
                      transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
                    ),
                  );
                  Fluttertoast.showToast(
                      msg: 'Вы вышли из аккаунта',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 15,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0);
            }),
          ],
        ),
      ),
    );
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
              HeaderWidget(text: "Профиль"),
              FutureBuilder(
                future: get_user_data(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    Map<String, dynamic> data =
                        convert_snapshot_to_map(snapshot);
                    try {
                      String name = data['name'];
                      return SizedBox();
                    }
                    catch(e){}
                  }
                  return authButtons();
                },
              ),
              profileButtons()
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xffECECEC),
      bottomNavigationBar: BottomMenuBar(
        currentIndex: 2,
        context: context,
        page: "Профиль",
      ),
    );
  }
}
