import 'package:flutter/material.dart';

import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../shared/compononse/components.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../shared/styles/colors/colors.dart';
import '../shop_login/shop_login_screen.dart';

class BoardingModel {
  late final String image;
  late final String title;
  late final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreen();
}

class _OnBoardingScreen extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/pepole.jpg',
        title: 'On Board 1 Title',
        body: 'On Board 1 Body'
    ),
    BoardingModel(
        image: 'assets/images/girl.jpg',
        title: 'On Board 2 Title',
        body: 'On Board 2 Body'
    ),
    BoardingModel(
        image: 'assets/images/ca.jpg',
        title: 'On Board 3 Title',
        body: 'On Board 3 Body'
    ),
  ];
  bool isLast=false;
  void submit()
  {
    CacheHelper.saveData(
        key: 'onBoarding',
        value: true,
    ).then((value) {
      if(value)
        {
          navigateAndFinish(
              context,
              ShopLoginScreen()
          );
        }
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: (){
                submit();
              },
              child: Text(
                'SKIP',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: HexColor('#E389B9'),

                ),
              ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
                controller: boardController,
                onPageChanged: (int index){
                  if(index==boarding.length-1)
                    {
                      setState(() {
                        isLast=true;
                      });
                    }
                  else
                    {
                      setState(() {
                        isLast=false;
                      });
                    }
                },
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: HexColor('#E389B9'),
                    dotHeight: 10,
                    dotWidth: 5,
                    expansionFactor: 4,
                    spacing: 5.0,
                  ),
                  count: boarding.length,
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {

                    if(isLast)
                      {
                        submit();
                      }
                    else
                      {
                        boardController.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      }

                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
          image: AssetImage(
            model.image,
          ),
        ),
      ),
      Text(
        ' ${model.title}',
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        height: 20,
      ),
      Text(
        '${model.body}',
        style: TextStyle(
          fontSize: 20.0,
        ),
      ),
    ],
  );
}
