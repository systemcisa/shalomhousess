import 'dart:typed_data';
import 'package:beamer/beamer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shalomhouse/constants/common_size.dart';
import 'package:shalomhouse/data/record_model.dart';
import 'package:shalomhouse/repo/image_storage.dart';
import 'package:shalomhouse/repo/record_service.dart';
import 'package:shalomhouse/screens/input/multi_image_select.dart';
import 'package:shalomhouse/states/category_notifier.dart';
import 'package:shalomhouse/states/select_image_notifier.dart';
import 'package:shalomhouse/states/user_notifier.dart';
import 'package:shalomhouse/utils/logger.dart';
import 'package:provider/provider.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({Key? key}) : super(key: key);

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  String _address = 'A동';
  bool _isChecked1 = false;
  bool _isChecked2 = false;
  bool _isChecked3 = false;
  bool _isChecked4 = false;
  bool _isChecked5 = false;
  bool _isChecked6 = false;
  bool _isChecked7 = false;
  bool _isChecked8 = false;
  bool _isChecked9 = false;
  bool _seuggestPriceSelected = false;

  var _border =
      const UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent));

  var _divider = Divider(
    height: common_padding * 2 + 1,
    thickness: 1,
    color: Colors.grey[450],
    indent: common_padding,
    endIndent: common_padding,
  );

  bool isCreatingItem = false;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _detailController = TextEditingController();

  void attemptCreateItem() async {
    isCreatingItem = true;
    setState(() {});
    final String userKey = FirebaseAuth.instance.currentUser!.uid;
    final String recordKey = RecordModel.generateItemKey(userKey);
    List<Uint8List> images = context.read<SelectImageNotifier>().images;
    UserNotifier userNotifier = context.read<UserNotifier>();

    if (userNotifier.userModel == null) return;
    List<String> downloadUrls =
        await ImageStorage.uploadImages(images, recordKey);

    final num? price = num.tryParse(_priceController.text);

    RecordModel recordModel = RecordModel(
        recordKey: recordKey,
        userKey: userKey,
        studentname: userNotifier.userModel!.studentname,
        studentnum: userNotifier.userModel!.studentnum,
        imageDownloadUrls: downloadUrls,
        recorddate: _nameController.text,
        title: _address,
        address: _addressController.text,
        isChecked1: _isChecked1,
        isChecked2: _isChecked2,
        isChecked3: _isChecked3,
        isChecked4: _isChecked4,
        isChecked5: _isChecked5,
        isChecked6: _isChecked6,
        isChecked7: _isChecked7,
        isChecked8: _isChecked8,
        isChecked9: _isChecked9,
        category: context.read<CategoryNotifier>().currentCategoryInEng,
        price: price ?? 0,
        negotiable: _seuggestPriceSelected,
        detail: _detailController.text,
        createdDate: DateTime.now().toUtc());
    logger.d('upload finished - ${downloadUrls.toString()}');

    await RecordService()
        .createNewRecord(recordModel, recordKey, userNotifier.user!.uid);
    context.beamBack();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        Size _size = MediaQuery.of(context).size;
        return IgnorePointer(
            ignoring: isCreatingItem,
            child: Scaffold(
              appBar: AppBar(
                bottom: PreferredSize(
                    preferredSize: Size(_size.width, 2),
                    child: isCreatingItem
                        ? const LinearProgressIndicator(
                            minHeight: 2,
                          )
                        : Container()),
                leading: TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.black87,
                      backgroundColor:
                          Theme.of(context).appBarTheme.backgroundColor),
                  child: Text(
                    '뒤로',
                    style: TextStyle(
                        color: Theme.of(context).appBarTheme.foregroundColor),
                  ),
                  onPressed: () {
                    context.beamBack();
                  },
                ),
                title: const Text('전기점검 신청'),
                actions: [
                  TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.black87,
                          backgroundColor:
                              Theme.of(context).appBarTheme.backgroundColor),
                      onPressed: attemptCreateItem,
                      child: Text(
                        '완료',
                        style: TextStyle(
                            color:
                                Theme.of(context).appBarTheme.foregroundColor),
                      )),
                ],
              ),
              body: ListView(children: [
                MultiImageSelect(),
                _divider,
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      hintText: '신청 날짜 MM.DD',
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: common_padding),
                      border: _border,
                      enabledBorder: _border,
                      focusedBorder: _border),
                ),
                _divider,
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('위치'),
                    ListTile(
                      title: const Text('A동'),
                      leading: Radio(
                        value: "A동",
                        groupValue: _address,
                        onChanged: (value) {
                          setState(() {
                            _address = value.toString();
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('B동'),
                      leading: Radio(
                        value: 'B동',
                        groupValue: _address,
                        onChanged: (value) {
                          setState(() {
                            _address = value.toString();
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('국생'),
                      leading: Radio(
                        value: '국생',
                        groupValue: _address,
                        onChanged: (value) {
                          setState(() {
                            _address = value.toString();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                _divider,
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                      hintText: '호실',
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: common_padding),
                      border: _border,
                      enabledBorder: _border,
                      focusedBorder: _border),
                ),
                _divider,
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('방'),
                    CheckboxListTile(
                        title: const Text('A방'),
                        value: _isChecked1,
                        onChanged: (value) {
                          setState(() {
                            _isChecked1 = value!;
                          });
                        }),
                    CheckboxListTile(
                        title: const Text('B방'),
                        value: _isChecked2,
                        onChanged: (value) {
                          setState(() {
                            _isChecked2 = value!;
                          });
                        }),
                  ],
                ),
                _divider,
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('번'),
                    CheckboxListTile(
                        title: const Text('1'),
                        value: _isChecked3,
                        onChanged: (value) {
                          setState(() {
                            _isChecked3 = value!;
                          });
                        }),
                    CheckboxListTile(
                        title: const Text('2'),
                        value: _isChecked4,
                        onChanged: (value) {
                          setState(() {
                            _isChecked4 = value!;
                          });
                        }),
                    CheckboxListTile(
                        title: const Text('3'),
                        value: _isChecked5,
                        onChanged: (value) {
                          setState(() {
                            _isChecked5 = value!;
                          });
                        }),
                    CheckboxListTile(
                        title: const Text('4'),
                        value: _isChecked6,
                        onChanged: (value) {
                          setState(() {
                            _isChecked6 = value!;
                          });
                        }),
                  ],
                ),
                _divider,
                TextFormField(
                  controller: _detailController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                      hintText: ''''내용<구체적으로 적어주세요>
    예) 김샬롬 옷장 두 번째 서랍이 안닫혀요''',
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: common_padding),
                      border: _border,
                      enabledBorder: _border,
                      focusedBorder: _border),
                ),
                _divider,
                const Text('''전기작업만 희망 시간 체크
*같은 호실 학생들과 조율 필수*
-체크한 시간에 랜덤 방문
-관리자가 신청 폼 확인하는 시간 기준으로 함
(오전 9시)
-중복체크 가능'''),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CheckboxListTile(
                        title: const Text('''당일 오후(1시~4시20분 사이 / 오전11시 30
분까지 접수 가능)'''),
                        value: _isChecked7,
                        onChanged: (value) {
                          setState(() {
                            _isChecked7 = value!;
                          });
                        }),
                    CheckboxListTile(
                        title: const Text('다음날 오전'),
                        value: _isChecked8,
                        onChanged: (value) {
                          setState(() {
                            _isChecked8 = value!;
                          });
                        }),
                    CheckboxListTile(
                        title: const Text('다음날 오후'),
                        value: _isChecked9,
                        onChanged: (value) {
                          setState(() {
                            _isChecked9 = value!;
                          });
                        }),
                  ],
                ),
              ]),
            ));
      },
    );
  }

  void showToast(String value) {
    Fluttertoast.showToast(
        msg: "$value 선택",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM);
  }
}
