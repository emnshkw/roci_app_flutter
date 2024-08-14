import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:roci_app/api.dart';
import 'package:roci_app/assets/roci_app_icons.dart';
import 'package:roci_app/bottom_menu.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:roci_app/header.dart';
import 'package:roci_app/pages/cast_page.dart';
import 'package:zoomable_photo_gallery/zoomable_photo_gallery_widget.dart';
import 'package:roci_app/pages/gallery_page.dart';

class ArchiveContestPage extends StatefulWidget {
  String id;
  ArchiveContestPage(this.id);
  @override
  State<ArchiveContestPage> createState() => ArchiveContestPageState(id);
}

class ArchiveContestPageState extends State<ArchiveContestPage> {
  late String id;
  ArchiveContestPageState(String id1){
    id = id1;
  }
  
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


  Widget back_button_and_place_photos(List<String> images) {
    // ZoomablePhotoController controller = ZoomablePhotoController();
    // controller.
    return Container(
      width: MediaQuery.of(context).size.width,
      height: convert_px_to_adapt_height(250),
      child: ZoomablePhotoGallery(
        maxZoom: 5,
        changePage: (int index) {
          choosedIndex = index;
        },
        minZoom: 1,
        imageList: List.generate(
          images.length,
              (index) => Image.network(
            images[index],
            fit: BoxFit.cover,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) =>
                  GalleryPage(images, choosedIndex),
              transitionDuration: Duration(milliseconds: 300),
              transitionsBuilder: (_, a, __, c) =>
                  FadeTransition(opacity: a, child: c),
            ),
          );
        },
      ),
    );
  }

  int choosedIndex = 0;
  String choosedType = 'Футбол';

  Future<void> _refresh() async {
    // Perform some asynchronous operation to update the items list
    await Future.delayed(Duration(seconds: 1));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: _refresh,
          color: Color(0xffBAEE68),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: FutureBuilder(
              future: getContest(id),
              builder: (BuildContext context,AsyncSnapshot snapshot){
                if (snapshot.hasData){
                  Map<String,dynamic> data = convert_snapshot_to_map(snapshot)['data'];
                  return Column(
                    children: [
                      HeaderWidget(text: 'Архив конкурсов'),
                      Padding(padding: EdgeInsets.only(bottom: convert_px_to_adapt_height(35))),
                      teams(data),
                      Padding(padding: EdgeInsets.only(bottom: convert_px_to_adapt_height(35))),
                      Text("Выплаты победителям",style: TextStyle(fontWeight: FontWeight.bold,fontSize: convert_px_to_adapt_height(20)),),
                      Padding(padding: EdgeInsets.only(bottom: convert_px_to_adapt_height(35))),
                      back_button_and_place_photos(data['pay_screens'].split('\n'))
                    ],
                  );
                }
                return SizedBox();
              },
            ),
          ),
        ),
        backgroundColor: const Color(0xffECECEC),
        bottomNavigationBar: BottomMenuBar(currentIndex: 2, context: context,page: "Завершённый конкурс",),
      ),
    );
  }
}

