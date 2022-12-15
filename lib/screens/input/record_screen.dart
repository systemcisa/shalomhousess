import 'dart:typed_data';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:shalomhouse/constants/common_size.dart';
import 'package:shalomhouse/data/record_model.dart';
import 'package:shalomhouse/repo/image_storage.dart';
import 'package:shalomhouse/repo/record_service.dart';
import 'package:shalomhouse/router/locations.dart';
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


  List<String> dropdownList = ['1', '2', '3'];


  var _border =
      UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent));

  var _divider = Divider(
    height: common_padding * 2 + 1,
    thickness: 1,
    color: Colors.grey[450],
    indent: common_padding,
    endIndent: common_padding,
  );
  var _Vdivider = VerticalDivider(
    color: Colors.redAccent,
    width: 80,
      indent: 10,
    endIndent: 10,
    thickness: 2,
  );

  bool isCreatingItem = false;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _priceController1 = TextEditingController();
  TextEditingController _priceController2 = TextEditingController();
  TextEditingController _priceController3 = TextEditingController();
  TextEditingController _priceController4 = TextEditingController();
  TextEditingController _priceController5 = TextEditingController();
  TextEditingController _priceController6 = TextEditingController();
  TextEditingController _priceController7 = TextEditingController();
  TextEditingController _priceController8 = TextEditingController();
  TextEditingController _priceController9 = TextEditingController();
  TextEditingController _priceController10 = TextEditingController();
  TextEditingController _priceController11 = TextEditingController();
  TextEditingController _priceController12 = TextEditingController();
  TextEditingController _addressController1 = TextEditingController();
  TextEditingController _addressController2 = TextEditingController();
  TextEditingController _addressController3 = TextEditingController();
  TextEditingController _addressController4 = TextEditingController();
  TextEditingController _addressController5 = TextEditingController();
  TextEditingController _addressController6 = TextEditingController();
  TextEditingController _addressController7 = TextEditingController();
  TextEditingController _addressController8 = TextEditingController();
  TextEditingController _addressController9 = TextEditingController();
  TextEditingController _addressController10 = TextEditingController();
  TextEditingController _addressController11 = TextEditingController();
  TextEditingController _addressController12= TextEditingController();
  TextEditingController _detailController = TextEditingController();


  void attemptCreateItem() async {
    isCreatingItem = true;
    setState(() {});

    final String recordKey = RecordModel.generateItemKey("");
    List<Uint8List> images = context.read<SelectImageNotifier>().images;

    List<String> downloadUrls =
        await ImageStorage.uploadImages(images, recordKey);

    final num? price1 = num.tryParse(_priceController1.text);
    final num? price2 = num.tryParse(_priceController2.text);
    final num? price3 = num.tryParse(_priceController3.text);
    final num? price4 = num.tryParse(_priceController4.text);
    final num? price5 = num.tryParse(_priceController5.text);
    final num? price6 = num.tryParse(_priceController6.text);
    final num? price7 = num.tryParse(_priceController7.text);
    final num? price8 = num.tryParse(_priceController8.text);
    final num? price9 = num.tryParse(_priceController9.text);
    final num? price10 = num.tryParse(_priceController10.text);
    final num? price11 = num.tryParse(_priceController11.text);
    final num? price12 = num.tryParse(_priceController12.text);

    RecordModel recordModel = RecordModel(
        recordKey: recordKey,
        //imageDownloadUrls: downloadUrls,
        title: _nameController.text,
        address1: _addressController1.text,
        address2: _addressController2.text,
        address3: _addressController3.text,
        address4: _addressController4.text,
        address5: _addressController5.text,
        address6: _addressController6.text,
        address7: _addressController7.text,
        address8: _addressController8.text,
        address9: _addressController9.text,
        address10: _addressController10.text,
        address11: _addressController11.text,
        address12: _addressController12.text,
        category1: context.read<CategoryNotifier>().currentCategoryInEng,
        price1: price1 ?? 0,
        price2: price2 ?? 0,
        price3: price3 ?? 0,
        price4: price4 ?? 0,
        price5: price5 ?? 0,
        price6: price6 ?? 0,
        price7: price7 ?? 0,
        price8: price8 ?? 0,
        price9: price9 ?? 0,
        price10: price10 ?? 0,
        price11: price11 ?? 0,
        price12: price12 ?? 0,
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
              title: Text('SOMI MALL 장끼'),

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
                // MultiImageSelect(),
                // _divider,
                // ListTile(
                //   onTap: () {
                //     context.beamToNamed(
                //         '/$LOCATION_RECORD/$LOCATION_CATEGORY_RECORD1');
                //   },
                //   dense: true,
                //   title: Text(
                //       context.watch<CategoryNotifier>().currentCategoryInKor),
                //   trailing: Icon(Icons.navigate_next),
                // ),2cmd
                _divider,
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(child:
                      Column(
                        children: [
                          Text('신발A', style: TextStyle(color: Colors.redAccent, fontSize: 20)),
                          TextFormField(
                            maxLines: 3,
                            controller: _addressController1,
                            decoration: InputDecoration(
                                hintText: '상세주소',
                                contentPadding:
                                EdgeInsets.symmetric(horizontal: common_padding),
                                border: _border,
                                enabledBorder: _border,
                                focusedBorder: _border),
                          ),
                        ],
                      )
                      ),
                      Expanded(child:
                      Column(
                        children: [
                          Text('신발B', style: TextStyle(color: Colors.orangeAccent, fontSize: 20)),
                          TextFormField(
                            maxLines: 3,
                            controller: _addressController2,
                            decoration: InputDecoration(
                                hintText: '상세주소',
                                contentPadding:
                                EdgeInsets.symmetric(horizontal: common_padding),
                                border: _border,
                                enabledBorder: _border,
                                focusedBorder: _border),
                          ),
                        ],
                      )
                      ),
                    ],
                  ),
                ),
                _divider,
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(child:
                      Column(
                        children: [
                          Text('신발C', style: TextStyle(color: Colors.deepPurple, fontSize: 20)),
                          TextFormField(
                            maxLines: 3,
                            controller: _addressController3,
                            decoration: InputDecoration(
                                hintText: '상세주소',
                                contentPadding:
                                EdgeInsets.symmetric(horizontal: common_padding),
                                border: _border,
                                enabledBorder: _border,
                                focusedBorder: _border),
                          ),
                        ],
                      )
                      ),
                      Expanded(child:
                      Column(
                        children: [
                          Text('신발D', style: TextStyle(color: Colors.greenAccent, fontSize: 20)),
                          TextFormField(
                            maxLines: 3,
                            controller: _addressController4,
                            decoration: InputDecoration(
                                hintText: '상세주소',
                                contentPadding:
                                EdgeInsets.symmetric(horizontal: common_padding),
                                border: _border,
                                enabledBorder: _border,
                                focusedBorder: _border),
                          ),
                        ],
                      )
                      )
                    ],
                  ),
                ),
                _divider,
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(child:
                      Column(
                        children: [
                          Text('NUZZON', style: TextStyle(color: Colors.blueAccent, fontSize: 20)),
                          TextFormField(
                            maxLines: 3,
                            controller: _addressController5,
                            decoration: InputDecoration(
                                hintText: '상세주소',
                                contentPadding:
                                EdgeInsets.symmetric(horizontal: common_padding),
                                border: _border,
                                enabledBorder: _border,
                                focusedBorder: _border),
                          ),
                        ],
                      )
                      ),
                    // _Vdivider,
                      Expanded(child:
                      Column(
                        children: [
                          Text('THEOT', style: TextStyle(color: Colors.redAccent, fontSize: 20)),
                          TextFormField(
                            maxLines: 3,
                            controller: _addressController6,
                            decoration: InputDecoration(
                                hintText: '상세주소',
                                contentPadding:
                                EdgeInsets.symmetric(horizontal: common_padding),
                                border: _border,
                                enabledBorder: _border,
                                focusedBorder: _border),
                          ),
                        ],
                      )
                      ),
                    ],
                  ),
                ),
                _divider,
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(child:
                      Column(
                        children: [
                          Text('DPH', style: TextStyle(color: Colors.orangeAccent, fontSize: 20)),
                          TextFormField(
                            maxLines: 3,
                            controller: _addressController7,
                            decoration: InputDecoration(
                                hintText: '상세주소',
                                contentPadding:
                                EdgeInsets.symmetric(horizontal: common_padding),
                                border: _border,
                                enabledBorder: _border,
                                focusedBorder: _border),
                          ),
                        ],
                      )
                      ),
                      Expanded(child:
                      Column(
                        children: [
                          Text('NPH', style: TextStyle(color: Colors.deepPurple, fontSize: 20)),
                          TextFormField(
                            maxLines: 3,
                            controller: _addressController8,
                            decoration: InputDecoration(
                                hintText: '상세주소',
                                contentPadding:
                                EdgeInsets.symmetric(horizontal: common_padding),
                                border: _border,
                                enabledBorder: _border,
                                focusedBorder: _border),
                          ),
                        ],
                      )
                      )
                    ],
                  ),
                ),
                _divider,
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(child:
                      Column(
                        children: [
                          Text('CPH', style: TextStyle(color: Colors.greenAccent, fontSize: 20)),
                          TextFormField(
                            maxLines: 3,
                            controller: _addressController9,
                            decoration: InputDecoration(
                                hintText: '상세주소',
                                contentPadding:
                                EdgeInsets.symmetric(horizontal: common_padding),
                                border: _border,
                                enabledBorder: _border,
                                focusedBorder: _border),
                          ),
                        ],
                      )
                      ),
                      Expanded(child:
                      Column(
                        children: [
                          Text('STUDIO W', style: TextStyle(color: Colors.blueAccent, fontSize: 20)),
                          TextFormField(
                            maxLines: 3,
                            controller: _addressController10,
                            decoration: InputDecoration(
                                hintText: '상세주소',
                                contentPadding:
                                EdgeInsets.symmetric(horizontal: common_padding),
                                border: _border,
                                enabledBorder: _border,
                                focusedBorder: _border),
                          ),
                        ],
                      )
                      ),
                    ],
                  ),
                ),
                _divider,
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(child:
                      Column(
                        children: [
                          Text('TECHNO', style: TextStyle(color: Colors.redAccent, fontSize: 20)),
                          TextFormField(
                            maxLines: 3,
                            controller: _addressController11,
                            decoration: InputDecoration(
                                hintText: '상세주소',
                                contentPadding:
                                EdgeInsets.symmetric(horizontal: common_padding),
                                border: _border,
                                enabledBorder: _border,
                                focusedBorder: _border),
                          ),
                        ],
                      )
                      ),
                      Expanded(child:
                      Column(
                        children: [
                          Text('APM', style: TextStyle(color: Colors.orangeAccent, fontSize: 20),),
                          TextFormField(
                            maxLines: 3,
                            controller: _addressController12,
                            decoration: InputDecoration(
                                hintText: '상세주소',
                                contentPadding:
                                EdgeInsets.symmetric(horizontal: common_padding),
                                border: _border,
                                enabledBorder: _border,
                                focusedBorder: _border),
                          ),
                        ],
                      )
                      )
                    ],
                  ),
                ),
                _divider,

                TextFormField(
                  controller: _detailController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                      hintText: '기타',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: common_padding),
                      border: _border,
                      enabledBorder: _border,
                      focusedBorder: _border),
                ),

              ],
            ),

          ),
        );
      },
    );
  }
}
