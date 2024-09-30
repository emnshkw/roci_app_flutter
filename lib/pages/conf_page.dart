import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:roci_app/api.dart';
import 'package:roci_app/assets/roci_app_icons.dart';
import 'package:roci_app/bottom_menu.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:roci_app/header.dart';
import 'package:roci_app/pages/main_page.dart';

class ConfPage extends StatefulWidget {

  @override
  State<ConfPage> createState() => _ConfPageState();
}

class _ConfPageState extends State<ConfPage> {

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
              "Политика конфиденциальности",
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
              Пользовательское Соглашение
Настоящее Пользовательское Соглашение (Далее Соглашение) регулирует отношения между владельцем rociscore.ru (далее roci или Администрация) с одной стороны и пользователем сайта с другой.
Сайт roci не является средством массовой информации.

Используя сайт, Вы соглашаетесь с условиями данного соглашения.
Если Вы не согласны с условиями данного соглашения, не используйте сайт roci!

Права и обязанности сторон
Пользователь имеет право:
- осуществлять поиск информации на сайте
- получать информацию на сайте
- требовать от администрации скрытия любой информации о пользователе
- использовать информацию сайта в личных некоммерческих целях

Администрация имеет право:
- по своему усмотрению и необходимости создавать, изменять, отменять правила
- ограничивать доступ к любой информации на сайте
- создавать, изменять, удалять информацию
- удалять учетные записи
- отказывать в регистрации без объяснения причин

Пользователь обязуется:
- обеспечить достоверность предоставляемой информации
- обеспечивать сохранность личных данных от доступа третьих лиц
- обновлять Персональные данные, предоставленные при регистрации, в случае их изменения
- не копировать информацию с других источников
- при копировании информации с других источников, включать в её состав информацию об авторе
- не распространять информацию, которая направлена на пропаганду войны, разжигание национальной, расовой или религиозной ненависти и вражды, а также иной информации, за распространение которой предусмотрена уголовная или административная ответственность
- не нарушать работоспособность сайта
- не создавать несколько учётных записей на Сайте, если фактически они принадлежат одному и тому же лицу
- не совершать действия, направленные на введение других Пользователей в заблуждение
- не передавать в пользование свою учетную запись и/или логин и пароль своей учетной записи третьим лицам
- не регистрировать учетную запись от имени или вместо другого лица за исключением случаев, предусмотренных законодательством РФ
- не размещать материалы рекламного, эротического, порнографического или оскорбительного характера, а также иную информацию, размещение которой запрещено или противоречит нормам действующего законодательства РФ
- не использовать скрипты (программы) для автоматизированного сбора информации и/или взаимодействия с Сайтом и его Сервисами

Администрация обязуется:
- поддерживать работоспособность сайта за исключением случаев, когда это невозможно по независящим от Администрации причинам.
- защищать информацию, распространение которой ограничено или запрещено законами путем вынесения предупреждения либо удалением учетной записи пользователя, нарушившего правила
- предоставить всю доступную информацию о Пользователе уполномоченным на то органам государственной власти в случаях, установленных законом

Ответственность сторон
- пользователь лично несет полную ответственность за распространяемую им информацию
- администрация не несет никакой ответственности за достоверность информации, скопированной из других источников
- администрация не несёт ответственность за несовпадение ожидаемых Пользователем и реально полученных услуг
- администрация не несет никакой ответственности за услуги, предоставляемые третьими лицами
- в случае возникновения форс-мажорной ситуации (боевые действия, чрезвычайное положение, стихийное бедствие и т. д.) Администрация не гарантирует сохранность информации, размещённой Пользователем, а также бесперебойную работу информационного ресурса

Условия действия Соглашения
Данное Соглашение вступает в силу при любом использовании данного сайта.
Соглашение перестает действовать при появлении его новой версии.
Администрация оставляет за собой право в одностороннем порядке изменять данное соглашение по своему усмотрению.
Администрация не оповещает пользователей об изменении в Соглашении.
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
            HeaderWidget(text: 'Политика конфиденциальности'),
            Padding(padding: EdgeInsets.only(bottom: convert_px_to_adapt_height(15))),
            description(),
            Padding(padding: EdgeInsets.only(bottom: convert_px_to_adapt_height(15))),
            Container(
              width: MediaQuery.of(context).size.width-convert_px_to_adapt_width(50),
              padding: EdgeInsets.only(left: convert_px_to_adapt_width(25),right: convert_px_to_adapt_width(25),bottom: convert_px_to_adapt_height(15)),
              child: ElevatedButton(style:ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffBAEE68),
                  foregroundColor: Color(0xff000000)
              ),onPressed: (){
                Navigator.of(context).pop();
              }, child: Text("Закрыть",style: TextStyle(color: Color(0xff000000)),)),
            )
          ],
        ),
      ),
      backgroundColor: const Color(0xffECECEC),
      bottomNavigationBar: BottomMenuBar(currentIndex: 2, context: context,page: "Условия",),
    );
  }
}
