import 'dart:io';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> images = [
    "http://www.swu.ac.kr/ImageFileView?imgPath=banner&imgName=805_1.jpg&imgGubun=F",
    "http://www.swu.ac.kr/ImageFileView?imgPath=banner&imgName=740_1.jpg&imgGubun=F",
    "http://www.swu.ac.kr/ImageFileView?imgPath=banner&imgName=721_1.jpg&imgGubun=F"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
            children: [
        Container(
          width: double.infinity,
          height: 250,
          child: Swiper(
            onTap: null,
            autoplay: true,
            viewportFraction: 0.8,
            scale: 0.9,
            itemBuilder: (BuildContext context, int index) {
              return Image.network(
                  images[index],
                  fit: BoxFit.cover);
            },
            itemCount: images.length,
            pagination: SwiperPagination(),
            controller: SwiperController(),
          ),
        ),
              SizedBox(height: 50,),
              Text('기숙사 광고',style: TextStyle(),),
              Text('기숙사 규칙'),
              Text('기숙사 외박신청'),
              Text('기타 등등')

            ],
    ),


    );
  }
}