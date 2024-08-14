import 'package:flutter/material.dart';
import 'package:roci_app/assets/roci_app_icons.dart';

class HeaderWidget extends StatelessWidget {
  final String text;
  const HeaderWidget({super.key, required this.text});
  double convert_px_to_adapt_width(double px,BuildContext context) {
    return MediaQuery.of(context).size.width / 392 * px;
  }

  double convert_px_to_adapt_height(double px,BuildContext context) {
    return MediaQuery.of(context).size.height / 852 * px;
  }


  


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Color(0xffBAEE68),
      child: Column(
        children: [
          SizedBox(height: convert_px_to_adapt_height(50,context)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: convert_px_to_adapt_width(25,context)),
                child: Container(
                  width: MediaQuery.of(context).size.width-convert_px_to_adapt_width(130, context),
                  child: Text(
                    text,
                    style: TextStyle(
                        color: Color(0xff000000),
                        fontWeight: FontWeight.bold,
                        fontSize: convert_px_to_adapt_height(25,context)),
                  ),
                ),
              ),
              SizedBox(
                height: convert_px_to_adapt_height(60,context),
                width: convert_px_to_adapt_width(100,context),
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        height: convert_px_to_adapt_height(50,context),
                        width: convert_px_to_adapt_width(100,context),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                    convert_px_to_adapt_width(20.5,context)),
                                bottomLeft: Radius.circular(
                                    convert_px_to_adapt_width(20.5,context)))),
                        child: Icon(RociAppIcons.roci,size: convert_px_to_adapt_height(27,context),),
                      ),
                    ),
                    Positioned(
                      child: Image.asset(
                        'assets/photos/russia.png',
                        scale: 0.9,
                      ),
                      left: 0,
                      bottom: 0,
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: convert_px_to_adapt_height(30,context)),
        ],
      ),
    );
  }
}
