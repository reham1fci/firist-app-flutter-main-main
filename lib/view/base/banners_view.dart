import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../controllers/banner_controller.dart';
import '../../util/images.dart';

class BannersView extends StatelessWidget {
  const BannersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<BannersController>(
          builder: (a) {
            double width = MediaQuery.of(context).size.width;
            return SizedBox(
              width: width,
              height: width * 0.4,
              child: a.mainBannerList != null
                  ? a.mainBannerList.isNotEmpty
                      ? Stack(
                          fit: StackFit.expand,
                          children: [
                            CarouselSlider.builder(
                              options: CarouselOptions(
                                viewportFraction: 1,
                                autoPlay: true,
                                enlargeCenterPage: true,
                                disableCenter: true,
                                onPageChanged: (index, reason) {
                                  //  Provider.of<a>(context, listen: false).setCurrentIndex(index);
                                },
                              ),
                              itemCount: a.mainBannerList.isEmpty
                                  ? 1
                                  : a.mainBannerList.length,
                              itemBuilder: (context, index, _) {
                                return InkWell(
                                  onTap: () {},
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: FadeInImage.assetNetwork(
                                        placeholder: Images.placeholder,
                                        fit: BoxFit.cover,
                                        image: a.mainBannerList[index],
                                        imageErrorBuilder: (c, o, s) =>
                                            Image.asset(Images.placeholder_3x1,
                                                fit: BoxFit.cover),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            Positioned(
                              bottom: 5,
                              left: 0,
                              right: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: a.mainBannerList.map((banner) {
                                  int index = a.mainBannerList.indexOf(banner);
                                  return TabPageSelectorIndicator(
                                    backgroundColor: index == a.currentIndex
                                        ? Theme.of(context).primaryColor
                                        : Colors.grey,
                                    borderColor: index == a.currentIndex
                                        ? Theme.of(context).primaryColor
                                        : Colors.grey,
                                    size: 10,
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        )
                      : const Center(child: Text('No banner available'))
                  : Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      enabled: a.mainBannerList == null,
                      child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          )),
                    ),
            );
          },
        ),
        const SizedBox(height: 5),
      ],
    );
  }
}
