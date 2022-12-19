import 'package:dio/dio.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:shalomhouse/constants/common_size.dart';
import 'package:shalomhouse/states/user_notifier.dart';
import 'package:shalomhouse/utils/logger.dart';
import 'package:provider/provider.dart';

class IntroPage extends StatelessWidget {
  IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
 //   logger.d('current user state: ${context.read<UserNotifier>().userState}');
    return LayoutBuilder(
      builder: (BuildContext , BoxConstraints ) {
        Size size = MediaQuery.of(context).size;
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: common_padding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('shalom house',
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(color: Theme.of(context).colorScheme.primary)),
                    SizedBox(
                        height: size.height/1.5,
                        child: ExtendedImage.asset('assets/imgs/SAM_0161.jpg')),
                    Text('서로는 배려하고 존중하는 '),
                    Text('서울여자대학교 기숙사 샬롬하우스입니다'),
                    SizedBox(
                      height: 18,
                    ),
                    TextButton(
                      onPressed: () async {
                        context.read<PageController>().animateToPage(1, duration: Duration(milliseconds: 500), curve: Curves.ease);

                      },
                      child: Text(
                          '         로그인하고 앱 시작하기         ',
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
