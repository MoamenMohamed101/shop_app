import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';
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
      title: 'Many gifts',
      body: 'Always try to take advantage of offers and discounts',
      image: 'assets/images/11.jpg',
    ),
    BoardingModel(
      title: 'Online shopping',
      body: 'Shop from home without any effort',
      image: 'assets/images/2.jpg',
    ),
    BoardingModel(
      title: 'Easy shopping',
      body: 'Use the easiest tools to shop',
      image: 'assets/images/3.jpg',
    ),
  ];
  bool isLast = false;
  var pageController = PageController();

  onSubmit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        NavigateAndFinsh(context: context, widget: ShopLoginScreen());
        print('done');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: onSubmit,
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
                      setState(() {
                        onSubmit;
                      });
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
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Image(
                image: AssetImage('${boardingModel.image}'),
                fit: BoxFit.cover,
              ),
            ),
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
