import 'package:flutter/material.dart';
import 'package:zoomable_photo_gallery/zoomable_photo_gallery_widget.dart';



class GalleryPage extends StatefulWidget {
  List<String> images;
  int index;

  GalleryPage(this.images, this.index);

  @override
  State<GalleryPage> createState() {
    return _ChoosingTableState(this.images, this.index);
  }
}

Positioned back_button(BuildContext context) {
  return Positioned(
      top: 0.0,
      left: 0.0,
      right: 0.0,
      child: AppBar(
        title: Text(''),
        // You can add title here
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.grey),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.blue.withOpacity(0),
        //You can make this transparent
        elevation: 0.0, //No shadow
      ));
}

class _ChoosingTableState extends State<GalleryPage> {
  late List<String> images;
  late int index;

  _ChoosingTableState(List<String> imgs, int ind) {
    images = imgs;
    index = ind;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ZoomablePhotoGallery(
          backColor: const Color(0xffECECEC),
          maxZoom: 5,
          initIndex: index,
          minZoom: 0.8,
          imageList: List.generate(
              images.length,
              (index) => Image.network(images[index], loadingBuilder:
                      (BuildContext context, Widget child,
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
                  })),
          onTap: () {
            // Navigator.of(context).push(MaterialPageRoute(builder:(context)=>GalleryPage()));
          },
        ),
        back_button(context)
      ],
    );
  }
}
