import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:roci_app/api.dart';
import 'package:roci_app/pages/main_page.dart';
import 'package:roci_app/pages/profile_page.dart';

class OtpPage extends StatefulWidget {
  Map<String,String> data;
  OtpPage(this.data);
  @override
  State<OtpPage> createState() => _OtpPageState(data);
}

class _OtpPageState extends State<OtpPage> {
  late Map<String,String> data;
  _OtpPageState(Map<String,String> data1){
    data = data1;
  }
  double convert_px_to_adapt_width(double px) {
    return MediaQuery.of(context).size.width / 392 * px;
  }

  double convert_px_to_adapt_height(double px) {
    return MediaQuery.of(context).size.height / 852 * px;
  }

  Widget backButton() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => ProfilePage(),
            transitionDuration: Duration(milliseconds: 300),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(
            left: convert_px_to_adapt_width(25),
            top: convert_px_to_adapt_height(20)),
        child: Row(
          children: [
            Icon(Icons.arrow_back_ios),
            Text(
              'Профиль',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: convert_px_to_adapt_height(16)),
            )
          ],
        ),
      ),
    );
  }

  Widget enterText() {
    return Padding(
      padding: EdgeInsets.only(top: convert_px_to_adapt_height(65)),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          "Подтверждение",
          style: TextStyle(
              fontSize: convert_px_to_adapt_height(25),
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }


  Widget otpField(){
    double containerWidth = MediaQuery.of(context).size.width-convert_px_to_adapt_width(186);
    return Padding(padding: EdgeInsets.only(top: convert_px_to_adapt_width(25)),child: Container(
      width: containerWidth,
      child: Column(
        children: [
          Text('Введите 4 последние цифры с номера, который вам позвонил',textAlign: TextAlign.center,style: TextStyle(color: Color(0xff898989)),),
          Padding(padding: EdgeInsets.only(bottom: convert_px_to_adapt_height(25))),
          otpInput(containerWidth)
        ],
      ),
    ),);
  }

  Widget otpInput(double containerWidth){
    return Container(
      width: containerWidth,
      child: TextField(
        controller: otpController,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
          LengthLimitingTextInputFormatter(4)],
        decoration: InputDecoration(
            fillColor: Color(0xffffffff),
            hintText: "Введите код",
            filled: true,
            focusedBorder: OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(convert_px_to_adapt_width(10)),
                borderSide: BorderSide(color: Color(0xffBAEE68))),
            enabledBorder: OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(convert_px_to_adapt_width(10)),
                borderSide: BorderSide(color: Color(0xffBAEE68))),),
      ),
    );
  }


  Widget acceptBtn(){

    double containerWidth = MediaQuery.of(context).size.width-convert_px_to_adapt_width(160);
    return Padding(padding: EdgeInsets.only(top: convert_px_to_adapt_height(40)),child: Container(
      width: containerWidth,
      height: convert_px_to_adapt_height(50),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xffBAEE68),
          foregroundColor: Colors.black54
        ),
        onPressed: (){
          data['code'] = otpController.text;
      try_to_register(data).then((response){
            Map<String,dynamic> resp_data = convert_response_to_map(response);
            if (resp_data['status'] == "Success"){
              Fluttertoast.showToast(
                  msg: 'Регистрация прошла успешно!',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 15,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
              saveToken(resp_data['message']);
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
                  msg: resp_data['message'],
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 15,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          });
        },
        child: Text("Подтвердить",style: TextStyle(color: Colors.black),),
      ),
    ),);
  }


  TextEditingController otpController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [backButton(), enterText(),otpField(),acceptBtn()],
        ),
      ),
      backgroundColor: const Color(0xffECECEC),
    );
  }
}
