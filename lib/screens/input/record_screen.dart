import 'dart:typed_data';
import 'package:beamer/beamer.dart';
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
import 'package:shalomhouse/utils/logger.dart';
import 'package:provider/provider.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({Key? key}) : super(key: key);

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  String _address = 'A동';
  bool? _isChecked1 = false;
  bool? _isChecked2 = false;
  bool _seuggestPriceSelected = false;

  var _border =
  UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent));

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

    final String recordKey = RecordModel.generateItemKey("");
    List<Uint8List> images = context.read<SelectImageNotifier>().images ;

    List<String> downloadUrls =
    await ImageStorage.uploadImages(images, recordKey);

    final num? price = num.tryParse(_priceController.text);

    RecordModel recordModel = RecordModel(
        recordKey: recordKey,
        imageDownloadUrls: downloadUrls,
        recorddate: _nameController.text,
        title: _address,
        address: _addressController.text,
        category: context.read<CategoryNotifier>().currentCategoryInEng,
        price: price ?? 0,
        //negotiable: _seuggestPriceSelected,
        detail: _detailController.text,
        createdDate: DateTime.now().toUtc());
    logger.d('upload finished - ${downloadUrls.toString()}');

    await RecordService().createNewRecord(recordModel.toJson(), recordKey);
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
                        ? LinearProgressIndicator(
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
                title: Text('전기점검 신청'),
                actions: [
                  TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.black87,
                          backgroundColor:
                          Theme.of(context).appBarTheme.backgroundColor),
                      child: Text(
                        '완료',
                        style: TextStyle(
                            color: Theme.of(context).appBarTheme.foregroundColor),
                      ),
                      onPressed: attemptCreateItem),
                ],
              ),
              body: ListView(
                  children: [
                    Container(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('''@최대한 자세히 작성해주세요@
@모든 시설 보수는 오후 1시 이전까지 접수 받습니 
다 (전기는 예외)@
@모든 시설 보수는 오후 1시 이후에 작업 합니다(전   
기는 예외)@'''),
                    ),
                    _divider,
                    MultiImageSelect(),
                    _divider,
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                          hintText: '신청 날짜 MM.DD',
                          contentPadding:
                          EdgeInsets.symmetric(horizontal: common_padding),
                          border: _border,
                          enabledBorder: _border,
                          focusedBorder: _border),
                    ),
                    _divider,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ListTile(
                          title: Text('샬롬A동'),
                          leading: Radio(
                            value: "샬롬A동",
                            groupValue: _address,
                            onChanged: (value) {
                              setState(() {
                                _address = value.toString();
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: Text('샬롬B동'),
                          leading: Radio(
                            value: '샬롬B동',
                            groupValue: _address,
                            onChanged: (value) {
                              setState(() {
                                _address = value.toString();
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: Text('국제생활관'),
                          leading: Radio(
                            value: '국제생활관',
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
                          hintText: '몇호',
                          contentPadding:
                          EdgeInsets.symmetric(horizontal: common_padding),
                          border: _border,
                          enabledBorder: _border,
                          focusedBorder: _border),
                    ),
                    _divider,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CheckboxListTile(
                            title: Text('A방'),
                            value: _isChecked1,
                            onChanged: (value) {
                              setState(() {
                                _isChecked1 = value;
                              });
                            }
                        ),
                        CheckboxListTile(
                            title: Text('B방'),
                            value: _isChecked2,
                            onChanged: (value) {
                              setState(() {
                                _isChecked2 = value;
                              });
                            }
                        ),
                      ],
                    ),
                    TextFormField(
                      controller: _detailController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                          hintText: '주문내용',
                          contentPadding:
                          EdgeInsets.symmetric(horizontal: common_padding),
                          border: _border,
                          enabledBorder: _border,
                          focusedBorder: _border),
                    ),
                  ]
              ),
            )
        );
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
