import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:roci_app/api.dart';
import 'package:roci_app/assets/roci_app_icons.dart';
import 'package:roci_app/bottom_menu.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:roci_app/header.dart';
import 'dart:math';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
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

  Widget chatWidget() {
    return Container();
  }

  Widget messageInput() {
    return TextField(
      controller: messageController,
      decoration: InputDecoration(
          hintText: "Сообщение",
          filled: true,
          fillColor: Color(0xffECECEC),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius:
                  BorderRadius.circular(convert_px_to_adapt_width(10))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius:
                  BorderRadius.circular(convert_px_to_adapt_width(10)))),
    );
  }

  Widget messageBar() {
    return Container(
      width: MediaQuery.of(context).size.width,
      // padding: EdgeInsets.only(
      //   left: convert_px_to_adapt_width(12),
      //   top: convert_px_to_adapt_height(8),
      //   right: convert_px_to_adapt_width(7)
      // ),
      color: Color(0xffffffff),
      height: convert_px_to_adapt_height(90),
      child: Stack(
        children: [
          Positioned(
              left: convert_px_to_adapt_width(12),
              top: convert_px_to_adapt_height(12),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width -
                        convert_px_to_adapt_width(67),
                    child: messageInput(),
                  ),
                  Padding(
                      padding:
                          EdgeInsets.only(right: convert_px_to_adapt_width(8))),
                  GestureDetector(
                    onTap: () {
                      sendMessage(messageController.text);
                      messageController.clear();
                    },
                    child: CircleAvatar(
                      radius: convert_px_to_adapt_width(20),
                      child: Transform.rotate(
                        angle: -90 * pi / 180,
                        child: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }

  Widget message(
      String message, bool byUser, String dateText, String timeText) {
    return Column(
      children: [
        dateText == ''
            ? SizedBox()
            : Padding(
                padding:
                    EdgeInsets.only(bottom: convert_px_to_adapt_height(15)),
                child: Text(dateText),
              ),
        Align(
          alignment: byUser ? Alignment.centerRight : Alignment.centerLeft,
          child: Padding(
            padding: byUser
                ? EdgeInsets.only(right: convert_px_to_adapt_width(18))
                : EdgeInsets.only(left: convert_px_to_adapt_width(18)),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 1.7,
                  padding: EdgeInsets.all(convert_px_to_adapt_width(12)),
                  decoration: BoxDecoration(
                      color: byUser ? Color(0xffBAEE68) : Color(0xffAAAAAA),
                      borderRadius:
                          BorderRadius.circular(convert_px_to_adapt_width(8))),
                  child: Column(
                    children: [
                      Text(message),
                      Padding(padding: EdgeInsets.only(bottom: convert_px_to_adapt_height(15))),
                      Align(
                        child: Text(timeText),
                        alignment: Alignment.centerRight,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  List<String> monthRu = [
    "января",
    "февраля",
    "марта",
    "апреля",
    "мая",
    "июня",
    "июля",
    "августа",
    "сентрября",
    "октября",
    "ноября",
    "декабря"
  ];
  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300), curve: Curves.elasticOut);
    } else {
      Timer(Duration(milliseconds: 400), () => _scrollToBottom());
    }
  }
  bool scrolledDown = false;
  bool elsAdded = false;
  TextEditingController messageController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          HeaderWidget(text: 'Связь с поддержкой'),
          Expanded(
            child: StreamBuilder(
              stream: getMessageStream(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                List<Widget> messages = [];
                List<String> dates = [];
                if (snapshot.hasData) {
                  Map<String, dynamic> data = convert_snapshot_to_map(snapshot);
                  for (int i = 0; i < data['message'].length; i++) {
                    Map<String, dynamic> messageData = data['message'][i];
                    List<String> dateInfo =
                        messageData['message_date'].split('T')[0].split('-');
                    String dateText =
                        '${dateInfo[2]} ${monthRu[int.parse(dateInfo[1]) - 1]} ${dateInfo[0]}';
                    List<String> timeInfo =
                        messageData['message_date'].split('T')[1].split(':');
                    String timeText = '${timeInfo[0]}:${timeInfo[1]}';
                    if (dates.contains(dateText)) {
                      dateText = '';
                    }
                    else{
                      dates.add(dateText);
                    }
                    messages.add(message(messageData['message'],
                        messageData['byClient'], dateText, timeText));
                    messages.add(Padding(
                        padding: EdgeInsets.only(
                            bottom: convert_px_to_adapt_height(12))));
                  }

                  if (elsAdded && !scrolledDown){
                    _scrollToBottom();
                    scrolledDown = true;
                  }
                  if (!elsAdded){
                    elsAdded = true;
                  }
                }
                return ListView(
                  children: messages,
                  dragStartBehavior: DragStartBehavior.down,

                  controller: _scrollController,
                );
              },
            ),
          ),
          messageBar()
        ],
      ),
      backgroundColor: const Color(0xffECECEC),
    );
  }
}
