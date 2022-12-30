import 'package:flutter/material.dart';
import 'package:shop_app/modules/login_screen.dart';
import 'package:shop_app/shared/componants/components.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  String? image;
  String? title;
  String? body;

  BoardingModel({this.image, this.title, this.body});
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List onBoarding = [
    BoardingModel(
      title: 'On Board 1 Title',
      body: 'On Board 1 Body',
      image: 'assets/images/1.jpg',
    ),
    BoardingModel(
      title: 'On Board 2 Title',
      body: 'On Board 2 Body',
      image: 'assets/images/2.jpg',
    ),
    BoardingModel(
      title: 'On Board 3 Title',
      body: 'On Board 3 Body',
      image: 'assets/images/3.jpg',
    ),
  ];
  bool isLast = false;

  var pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              NavigateAndFinsh(
                  context: context, widget: const ShopLoginScreen());
            },
            child: const Text(
              'Skip',
              style: TextStyle(fontSize: 20),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: pageController,
                itemBuilder: (BuildContext context, int index) =>
                    buildBoardingItem(onBoarding[index]),
                itemCount: onBoarding.length,
                onPageChanged: (index) {
                  if (index == onBoarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: onBoarding.length,
                  effect: const ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: defaultColor,
                      dotWidth: 10,
                      expansionFactor: 4,
                      dotHeight: 10,
                      spacing: 5),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast == true) {
                      NavigateAndFinsh(
                          context: context, widget: ShopLoginScreen());
                    } else {
                      pageController.nextPage(
                          duration: const Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: const Icon(Icons.arrow_forward_outlined),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

buildBoardingItem(BoardingModel boardingModel) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Image(
            image: AssetImage('${boardingModel.image}'),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          '${boardingModel.title}',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          '${boardingModel.body}',
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
