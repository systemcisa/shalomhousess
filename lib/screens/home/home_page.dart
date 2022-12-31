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
              SizedBox(height: 50,),
              Text('모든 신청은 편집 및 삭제가 불가합니다',style: TextStyle(color: Colors.redAccent),),
              Text('관련 문의는 행정실로 연락 바랍니다. 02) 970-7903'),
              SizedBox(height: 50,),
              Text('* 시설물관리 신청시 유의사항',style: TextStyle(color: Colors.redAccent),),
              Text('모든 시설 보수는 오후 1시 이전까지 접수 받습니다 (전기는 예외)'),
              Text('모든 시설 보수는 오후 1시 이후에 작업합니다 (전기는 예외)'),
              SizedBox(height: 50,),
              Text('* 전기작업 신청시 유의사항',style: TextStyle(color: Colors.redAccent),),
              Text('희망 시간 체크 해주세요'),
              Text('희망 시간 체크 해주세요',style: TextStyle(decoration: TextDecoration.underline),),
              Text('관리자가 신청 폼 확인하는 시간 기준으로 함 (오전 9시)',style: TextStyle(decoration: TextDecoration.underline),),
              Text('시간은 중복 체크 가능'),
            ],
    ),


    );
  }
}