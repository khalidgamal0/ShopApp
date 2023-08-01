import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/moduels/onboarding/onboarding.dart';
import 'package:shopapp/moduels/shoploginscrren/shopLoginScreen.dart';
import 'package:shopapp/shared/netwok/local/sharedpreffernce.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/commponent/commponent.dart';
import '../../shared/style/color.dart';

class PageItem {
  @required final String ?image;
  @required final String ?title;
  @required final String ?body;

  PageItem({this.image, this.body, this.title});
}

class ShoponBoarding extends StatefulWidget {
  @override
  State<ShoponBoarding> createState() => _ShoponBoardingState();
}

class _ShoponBoardingState extends State<ShoponBoarding> {
  List<PageItem>boarding = [
    PageItem(
        image: 'assets/images/onboarding1.png',
        title: ' Screen Title 1',
        body: ' Screen Body 1'),
    PageItem(
        image: 'assets/images/onboarding1.png',
        title: ' Screen Title 2',
        body: ' Screen Body 2'),
    PageItem(
        image: 'assets/images/onboarding1.png',
        title: ' Screen Title 3',
        body: ' Screen Body 3')
  ];
  var pagecontroller = PageController();
  bool islast = false;

  void submit() {
    CacheHelper.setData(key: 'onboarding', value: true).then((value) {
      if (value) {
        Nvigateandfinish(context, ShopLoginSrceen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultextbutton(function: submit, text: 'skip'),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  controller: pagecontroller,
                  itemBuilder: (context, index) =>
                      buildboardingitem(boarding[index]),
                  itemCount: boarding.length,
                  onPageChanged: (index) {
                    if (index == boarding.length - 1) {
                      setState(() {
                        islast = true;
                      });
                    } else {
                      setState(() {
                        islast = false;
                      });
                    }
                  },
                ),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: pagecontroller,
                    count: boarding.length,
                    effect: ExpandingDotsEffect(
                      activeDotColor: defaultcolor,
                      dotWidth: 10,
                      dotHeight: 10,
                    ),
                  ),
                  Spacer(),
                  FloatingActionButton(onPressed: () {
                    islast ? submit : pagecontroller.nextPage(
                        duration: Duration(milliseconds: 750),
                        curve: Curves.linear);
                  }, child: Icon(Icons.arrow_forward_ios),)
                ],
              )
            ]),
      ),
    );
  }

  Widget buildboardingitem(PageItem x) =>
      Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Image(image: AssetImage('${x.image}'))),
            SizedBox(height: 20),
            Text('${x.title}',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
              ),),
            SizedBox(height: 15),
            Text('${x.body}',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
              ),),
            SizedBox(height: 15),
          ]);
}
