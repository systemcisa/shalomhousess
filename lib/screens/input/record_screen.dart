import 'dart:typed_data';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:hanoimall/constants/common_size.dart';
import 'package:hanoimall/data/order_model.dart';
import 'package:hanoimall/data/record_model.dart';
import 'package:hanoimall/repo/image_storage.dart';
import 'package:hanoimall/repo/order_service.dart';
import 'package:hanoimall/repo/record_service.dart';
import 'package:hanoimall/router/locations.dart';
import 'package:hanoimall/screens/input/multi_image_select.dart';
import 'package:hanoimall/states/category_notifier.dart';
import 'package:hanoimall/states/select_image_notifier.dart';
import 'package:hanoimall/utils/logger.dart';
import 'package:provider/provider.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({Key? key}) : super(key: key);

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  bool _seuggestPriceSelected = false;


  var _border= UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent));

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
    List<Uint8List> images =
        context
            .read<SelectImageNotifier>()
            .images;

    List<String> downloadUrls =
    await ImageStorage.uploadImages(images, recordKey);

final num? price = num.tryParse(_priceController.text);

    RecordModel recordModel = RecordModel(
        recordKey: recordKey,
        imageDownloadUrls: downloadUrls,
        title: _nameController.text,
        address: _addressController.text,
        category: context
            .read<CategoryNotifier>()
            .currentCategoryInEng,
        price: price??0,
        negotiable: _seuggestPriceSelected,
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
        Size _size = MediaQuery
            .of(context)
            .size;
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
                    Theme
                        .of(context)
                        .appBarTheme
                        .backgroundColor),
                child: Text(
                  '뒤로',
                  style: TextStyle(
                      color: Theme
                          .of(context)
                          .appBarTheme
                          .foregroundColor),
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
                        Theme
                            .of(context)
                            .appBarTheme
                            .backgroundColor),
                    child: Text(
                      '완료',
                      style: TextStyle(
                          color: Theme
                              .of(context)
                              .appBarTheme
                              .foregroundColor),
                    ),
                    onPressed: attemptCreateItem
                ),
              ],
            ),
            body: ListView(
              children: [
                MultiImageSelect(),
                _divider,
                ListTile(
                  onTap: () {
                    context.beamToNamed(
                        '/$LOCATION_RECORD/$LOCATION_CATEGORY_RECORD');
                  },
                  dense: true,
                  title: Text(
                      context.watch<CategoryNotifier>().currentCategoryInKor),
                  trailing: Icon(Icons.navigate_next),
                ),
                _divider,
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                      hintText: '상세주소',
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: common_padding),
                      border:_border, enabledBorder: _border, focusedBorder: _border),
                ),
                _divider,

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        textAlign: TextAlign.end,
                        keyboardType: TextInputType.number,
                        controller: _priceController,
                        onChanged: (value) {
                          if (value == '0원') {
                            _priceController.clear();
                          }

                          setState(() {});
                        },
                        decoration: InputDecoration(
                            hintText: '주문가격',
                            contentPadding:
                            EdgeInsets.symmetric(horizontal: common_padding),
                            border:_border, enabledBorder: _border, focusedBorder: _border),
                      ),
                    ),
                    Text(',000원 '),
                    Container(width: 200,)
                  ],
                ),
                _divider,
              TextFormField(
                  controller: _detailController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                      hintText: '주문내용',
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: common_padding),
                      border:_border, enabledBorder: _border, focusedBorder: _border),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
