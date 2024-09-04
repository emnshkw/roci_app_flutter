import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:roci_app/api.dart';
import 'package:roci_app/assets/roci_app_icons.dart';
import 'package:roci_app/bottom_menu.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:roci_app/header.dart';
import 'package:roci_app/pages/main_page.dart';

class ConditionsPage extends StatefulWidget {

  @override
  State<ConditionsPage> createState() => _ConditionsPageState();
}

class _ConditionsPageState extends State<ConditionsPage> {

  double convert_px_to_adapt_width(double px) {
    return MediaQuery.of(context).size.width / 392 * px;
  }

  double convert_px_to_adapt_height(double px) {
    return MediaQuery.of(context).size.height / 852 * px;
  }

  Widget description() {
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
              "Условия пользования",
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
            child: Text(
                """
              «Конкурс на точный счет» – это игра, в которой вам необходимо спрогнозировать точный счет матча.

Верно спрогнозированный точный счет матча, дает вам возможность рассчитывать на приз в размере 5.000 рублей.

Правила:
1. Rocinante Group самостоятельно решает, какой матч предложить вам для прогноза.
2. В случае нескольких победителей приз будет разделен между ними ⚠️
3. Пример приема прогноза: 1-1, 2-1, 3-3.Важно что первая цифра идет к первой команде, вторая к второй
4. Прием ответов заканчивается за 30 минут до начала первого события!
5. Конкурс на точный счет проходит только в основное время матча
6. Один прогноз на одного игрока! В случае большего количества результат аннулируется! (Распространяется на все конкурсы )
7. В случае если не будет телефонного подтверждения наличия 18 лет то результат будет аннулирован.
8. Участие только для граждан РФ.
Заполнение формы:
⚠️В форме – «Ваш Tелефон» обязательно укажите свой действующий номер телефона, с помощью него Мы сможем связаться с Вами в случае победы. В случае если будет указано неверно, или мы не сможем Вас идентифицировать по Вашим указанным данным приз аннулируется 
⚠️В форме – «Ваш адрес электронной почты» можно указать (необязательно) адрес электронной почты, так вы получите результат на свой email.
8. На каждого участника полагается по 4 попытки на все конкурсы или до первого выигрыша приза (частичного)

Приз выплачивается во вторник с 12 часов по Москве

Конкурс на точный счет носит исключительно развлекательный характер!
Участие строго 18+, если вам меньше 18, то победа аннулируется. Rocinante Group  НЕ является букмекером и не ведет такую деятельность.
              """

            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderWidget(text: 'Условия'),
            Padding(padding: EdgeInsets.only(bottom: convert_px_to_adapt_height(15))),
            description(),
            Padding(padding: EdgeInsets.only(bottom: convert_px_to_adapt_height(15))),
          ],
        ),
      ),
      backgroundColor: const Color(0xffECECEC),
      bottomNavigationBar: BottomMenuBar(currentIndex: 2, context: context,page: "Условия",),
    );
  }
}
