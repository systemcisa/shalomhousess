import 'package:dio/dio.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:hanoimall/constants/common_size.dart';
import 'package:hanoimall/states/user_provider.dart';
import 'package:hanoimall/utils/logger.dart';
import 'package:provider/provider.dart';

class IntroPage extends StatelessWidget {
  IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    logger.d('current user state: ${context.read<UserProvider>().userState}');
    return LayoutBuilder(
      builder: (BuildContext , BoxConstraints ) {
        Size size = MediaQuery.of(context).size;
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: common_padding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('somi mall',
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(color: Theme.of(context).colorScheme.primary)),
                    SizedBox(
                        height: size.height/1.5,
                        child: ExtendedImage.asset('assets/imgs/happy.jpg')),
                    Text('소미야 서준이랑 우리 행복하자'),
                    Text('어려움 있어도 우리 이기고 잘 살자~'),
                    SizedBox(
                      height: 18,
                    ),
                    TextButton(
                      onPressed: () async {
                        context.read<PageController>().animateToPage(1, duration: Duration(milliseconds: 500), curve: Curves.ease);

                      },
                      child: Text(
                          '         동대문 사입 시작하기         ',
                          style: Theme.of(context).textTheme.button ),
                      style: TextButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor
                      ),
                    ),
                  ],
                ),
              ),
            );
      },
    );
  }
}
