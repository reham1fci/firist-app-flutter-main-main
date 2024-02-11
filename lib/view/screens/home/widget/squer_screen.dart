import 'package:betakety_app/util/dimensions.dart';
import 'package:betakety_app/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Squermain extends StatelessWidget {
  final Widget? screen;
  final String title;
  final String image;
  final double? width, height;
  const Squermain(
      {super.key,
      this.screen,
      required this.title,
      required this.image,
      this.width,
      this.height});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (screen != null) Get.to(screen);
      },
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        width: width,
        height: height,
        child: Card(
          child: ClipRRect(
            borderRadius:
                BorderRadius.circular(10), // Adjust the radius as needed
            child: Column(
              children: [
                Container(
                  width: (width! / 3) * 2,
                  padding:
                      const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                  child: Image.asset(
                    image,
                  ),
                ),
                SizedBox(
                  height: (MediaQuery.of(context).size.width / 4) * 0.3,
                  child: Center(
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: titilliumSemiBold.copyWith(
                        fontSize: Dimensions.fontSizeSmall,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
