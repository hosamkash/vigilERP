import 'package:flutter/material.dart';
import 'package:vigil_erp/screens/mainFiles/scr_Homepage.dart';
import 'package:vigil_erp/screens/mainFiles/scr_HomepageSlider.dart';
import 'package:vigil_erp/shared/enumerators.dart';
import 'package:vigil_erp/shared/sharedDesigne.dart';
import 'package:vigil_erp/shared/sharedHive.dart';
import 'package:vigil_erp/shared/shared_controls.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class scr_Boarding extends StatelessWidget {
  scr_Boarding({super.key});

  var pageController = PageController();
  List<pageItem> LstPage = [
    pageItem('فاهمين إحتياجاتك', 'assets/bording1.png', 'من خبرتنا فى السوق فهمنا إنت محتاج إيه ونوفره ليك إزاي'),
    pageItem('الجوده هدفنا', 'assets/bording2.png', 'قادرين نوفر لك أفضل منتج من حيث الجودة والسعر'),
    pageItem('هترتاح معانا', 'assets/bording3.png', 'لما تجرب منتجاتنا مش هترتاح فى أي لبس غير من عندنا')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            PageView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: 3,
              controller: pageController,
              onPageChanged: (index) {
                print(index);
              },
              itemBuilder: (context, index) {
                return buildPageItem(context, LstPage[index]);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPageItem(context, pageItem item) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              SizedBox(height: 600),
              Image(
                image: AssetImage(item.image),
                width: double.infinity,
              ),
              Positioned(
                  top: 10,
                  left: -10,
                  child: MaterialButton(
                    onPressed: () {
                      sharedHive.saveData(en_AppKey.isSkipBoarding.name, true);
                      sharedControls.navigatToAndFinish(context, scr_HomepageSlider());
                    },
                    child: Text(
                      'تخطي',
                      style: TextStyle(fontWeight: FontWeight.bold, color: sharedDesigne.primaryColor, fontSize: 20),
                    ),
                  )),
              const Positioned(
                top: 60,
                child: Text(
                  'مكة ستار',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 25),
                ),
              ),
              Positioned(
                top: 100,
                child: Text(
                  item.title,
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 35),
                ),
              ),
              Positioned(
                bottom: 120,
                child: Container(
                  width: 300,
                  child: Text(
                    textDirection: TextDirection.rtl,
                    item.body,
                    // textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
                  ),
                ),
              ),
              Positioned(
                bottom: 30,
                left: 10,
                child: Row(
                  children: [
                    MaterialButton(
                      onPressed: () {
                        if (pageController.page == 2) {
                          sharedHive.saveData(en_AppKey.isSkipBoarding.name, true);
                          sharedControls.navigatToAndFinish(context, scr_Homepage());
                        } else
                          pageController.nextPage(duration: Duration(seconds: 1), curve: Curves.linear);
                      },
                      child: const Text(
                        'التالي',
                        style: TextStyle(fontWeight: FontWeight.bold, color: sharedDesigne.primaryColor, fontSize: 20),
                      ),
                    ),
                    const Icon(Icons.arrow_forward ,color: sharedDesigne.primaryColor,size: 30,),
                  ],
                ),
              ),
              Positioned(
                bottom: 45,
                right: 10,
                child: SmoothPageIndicator(
                  effect: ExpandingDotsEffect(
                    activeDotColor: sharedDesigne.primaryColor,
                  ),
                  controller: pageController,
                  count: 3,
                  onDotClicked: (index) => ActionChip.elevated,
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}

//****************** class page item ***************************
class pageItem {
  String title;
  String image;
  String body;

  pageItem(this.title, this.image, this.body);
}
