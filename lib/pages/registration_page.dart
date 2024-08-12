import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:roci_app/api.dart';
import 'package:roci_app/assets/roci_app_icons.dart';
import 'package:roci_app/bottom_menu.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:roci_app/header.dart';
import 'package:roci_app/pages/cast_page.dart';
import 'package:roci_app/pages/main_page.dart';
import 'package:roci_app/pages/otp_page.dart';
import 'package:roci_app/pages/profile_page.dart';

class RegistrationPage extends StatefulWidget {
  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
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
          "Регистрация",
          style: TextStyle(
              fontSize: convert_px_to_adapt_height(25),
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget nameInput(TextEditingController controller, double containerWidth) {
    return Container(
        width: containerWidth,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            fillColor: Color(0xffffffff),
            hintText: "Введите ваше имя",
            filled: true,
            focusedBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(convert_px_to_adapt_width(10)),
                borderSide: BorderSide(color: Color(0xffBAEE68))),
            enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(convert_px_to_adapt_width(10)),
                borderSide: BorderSide(color: Color(0xffBAEE68))),
            prefixIcon: Icon(
              Icons.person,
              color: Color(0xffBEBEBE),
            ),
          ),
        ));
  }

  Widget phoneInput(TextEditingController controller, double containerWidth) {
    return Container(
      width: containerWidth,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp('[0-9+]')),
          LengthLimitingTextInputFormatter(12)
        ],
        onTap: () {
          if (controller.text == '') {
            controller.text = '+7';
          }
        },
        onChanged: (String changed) {
          if (controller.text.length < 2) {
            controller.text = '+7';
          } else {
            controller.text = "+7" + changed.replaceAll('+7', '');
          }
        },
        decoration: InputDecoration(
            fillColor: Color(0xffffffff),
            hintText: "Введите номер телефона",
            filled: true,
            focusedBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(convert_px_to_adapt_width(10)),
                borderSide: BorderSide(color: Color(0xffBAEE68))),
            enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(convert_px_to_adapt_width(10)),
                borderSide: BorderSide(color: Color(0xffBAEE68))),
            prefixIcon: Icon(
              Icons.phone_iphone,
              color: Color(0xffBEBEBE),
            ),
            suffixIcon: GestureDetector(
              child: Icon(
                Icons.close,
                color: Color(0xffBEBEBE),
              ),
              onTap: () {
                phoneController.text = '+7';
              },
            )),
      ),
    );
  }

  Widget passwordInput(
      TextEditingController controller, double containerWidth) {
    return Container(
      width: containerWidth,
      child: TextField(
        controller: controller,
        obscureText: hided,
        decoration: InputDecoration(
            fillColor: Color(0xffffffff),
            hintText: "Придумайте пароль",
            filled: true,
            focusedBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(convert_px_to_adapt_width(10)),
                borderSide: BorderSide(color: Color(0xffBAEE68))),
            enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(convert_px_to_adapt_width(10)),
                borderSide: BorderSide(color: Color(0xffBAEE68))),
            prefixIcon: Icon(
              Icons.lock,
              color: Color(0xffBEBEBE),
            ),
            suffixIcon: GestureDetector(
              child: Icon(
                Icons.remove_red_eye,
                color: Color(0xffBEBEBE),
              ),
              onTap: () {
                setState(() {
                  hided = !hided;
                });
              },
            )),
      ),
    );
  }

  Widget inputs() {
    double containerWidth =
        MediaQuery.of(context).size.width - convert_px_to_adapt_width(50);
    return Padding(
      padding: EdgeInsets.only(
          top: convert_px_to_adapt_height(33),
          left: convert_px_to_adapt_width(25)),
      child: Container(
        width: containerWidth,
        child: Column(
          children: [
            nameInput(nameController, containerWidth),
            Padding(
                padding:
                    EdgeInsets.only(bottom: convert_px_to_adapt_height(20))),
            phoneInput(phoneController, containerWidth),
            Padding(
                padding:
                    EdgeInsets.only(bottom: convert_px_to_adapt_height(20))),
            passwordInput(passwordController, containerWidth)
          ],
        ),
      ),
    );
  }

  Widget enterBtn() {
    return Padding(
      padding: EdgeInsets.only(
          top: convert_px_to_adapt_height(30),
          left: convert_px_to_adapt_width(50),
          right: convert_px_to_adapt_width(50)),
      child: Container(
        width:
            MediaQuery.of(context).size.width - convert_px_to_adapt_width(100),
        height: convert_px_to_adapt_height(50),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xffBAEE68),
              foregroundColor: Colors.black12),
          onPressed: () {
            Map <String,String> body = {
              'username': nameController.text,
              "phone": phoneController.text,
              "password":passwordController.text,
              "re_password":passwordController.text,
              'type':"Регистрация"
            };
            try_to_get_registration_token(
                    nameController.text, phoneController.text)
                .then((response) {
              Map<String,dynamic> data = convert_response_to_map(response);
              if (data['status'] == "Success"){
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => OtpPage(body),
                    transitionDuration: Duration(milliseconds: 300),
                    transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
                  ),
                );
              }
            });


          },
          child: Text(
            "Зарегистрироваться",
            style: TextStyle(
                color: Color(0xff000000),
                fontWeight: FontWeight.bold,
                fontSize: convert_px_to_adapt_height(16)),
          ),
        ),
      ),
    );
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool hided = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [backButton(), enterText(), inputs(), enterBtn()],
        ),
      ),
      backgroundColor: const Color(0xffECECEC),
    );
  }
}
