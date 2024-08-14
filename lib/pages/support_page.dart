import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:roci_app/api.dart';
import 'package:roci_app/assets/roci_app_icons.dart';
import 'package:roci_app/bottom_menu.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:roci_app/header.dart';
import 'package:roci_app/pages/cast_page.dart';
import 'package:roci_app/pages/main_page.dart';
import 'package:zoomable_photo_gallery/zoomable_photo_gallery_widget.dart';
import 'package:roci_app/pages/gallery_page.dart';

class SupportPage extends StatefulWidget {
  @override
  State<SupportPage> createState() => SupportPageState();
}

class SupportPageState extends State<SupportPage> {
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

  Widget input(TextEditingController controller, String hintText, var minLines,
      var maxLines) {
    return Padding(
      padding: EdgeInsets.only(
          left: convert_px_to_adapt_width(15),
          right: convert_px_to_adapt_width(15)),
      child: TextField(
        controller: controller,
        minLines: minLines,
        maxLines: maxLines,
        decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: Color(0xffffffff),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius:
                    BorderRadius.circular(convert_px_to_adapt_width(10))),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius:
                    BorderRadius.circular(convert_px_to_adapt_width(10)))),
      ),
    );
  }

  Future<void> _refresh() async {
    // Perform some asynchronous operation to update the items list
    await Future.delayed(Duration(seconds: 1));
    setState(() {});
  }

  Widget enterBtn() {
    return Padding(
      padding: EdgeInsets.only(left: convert_px_to_adapt_width(15)),
      child: Container(
        width: MediaQuery.of(context).size.width-convert_px_to_adapt_width(30),
        child: ElevatedButton(
          onPressed: (){
            if (themeController.text == ''){
              Fluttertoast.showToast(
                  msg: 'Укажите тему обращения',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 15,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
              return ;
            }
            if (textController.text == ''){
              Fluttertoast.showToast(
                  msg: 'Укажите текст обращения',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 15,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
              return ;
            }
            sendSupport(themeController.text, textController.text).then((response){
              Map<String,dynamic> data = convert_response_to_map(response);
              if (data['status'] == 'success'){
                Fluttertoast.showToast(
                    msg: data['message'],
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
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xffBAEE68),
            foregroundColor: Color(0xff000000)
          ),
          child: Text('ОТПРАВИТЬ',style: TextStyle(color:Color(0xff000000),fontSize: convert_px_to_adapt_height(16),fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }

  TextEditingController themeController = TextEditingController();
  TextEditingController textController = TextEditingController();

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
              HeaderWidget(text: 'Связь с поддержкой'),
              Padding(
                  padding:
                      EdgeInsets.only(bottom: convert_px_to_adapt_height(18))),
              input(themeController, "Тема", 1, 1),
              Padding(
                  padding:
                      EdgeInsets.only(bottom: convert_px_to_adapt_height(10))),
              input(textController, "Текст обращения", 10, null),
              Padding(padding: EdgeInsets.only(bottom: convert_px_to_adapt_height(30))),
              enterBtn()
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xffECECEC),
      bottomNavigationBar: BottomMenuBar(
        currentIndex: 2,
        context: context,
        page: "Завершённый конкурс",
      ),
    );
  }
}
