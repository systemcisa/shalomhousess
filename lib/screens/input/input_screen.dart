import 'dart:typed_data';
import 'package:beamer/beamer.dart';
import 'package:extended_image/extended_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shalomhouse/constants/common_size.dart';
import 'package:shalomhouse/data/order_model.dart';
import 'package:shalomhouse/repo/image_storage.dart';
import 'package:shalomhouse/repo/order_service.dart';
import 'package:shalomhouse/screens/input/multi_image_select.dart';
import 'package:shalomhouse/states/category_notifier.dart';
import 'package:shalomhouse/states/select_image_notifier.dart';
import 'package:shalomhouse/utils/logger.dart';
import 'package:provider/provider.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
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

    final String orderKey = OrderModel.generateItemKey("");
    List<Uint8List> images = context.read<SelectImageNotifier>().images ;

    List<String> downloadUrls =
        await ImageStorage.uploadImages(images, orderKey);

    final num? price = num.tryParse(_priceController.text);

    OrderModel orderModel = OrderModel(
        orderKey: orderKey,
        userKey:  FirebaseAuth.instance.currentUser!.uid ,
        imageDownloadUrls: downloadUrls,
        orderdate: _nameController.text,
        title: _address,
        address: _addressController.text,
        category: context.read<CategoryNotifier>().currentCategoryInEng,
        price: price ?? 0,
        negotiable: _seuggestPriceSelected,
        detail: _detailController.text,
        createdDate: DateTime.now().toUtc());
    logger.d('uid - ${FirebaseAuth.instance.currentUser!.uid }');

    await OrderService().createNewOrder(orderModel.toJson(), orderKey);
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
              title: Text('시설점검 신청'),
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
                      title: Text('A동'),
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
                      title: Text('B동'),
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
                      title: Text('국생'),
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
                      EdgeInsets.symmetric(horizontal: common_padding),
                  border: _border,
                  enabledBorder: _border,
                  focusedBorder: _border),
                ),
                _divider,
                Text("자리 번호"),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CheckboxListTile(
                      title: Text('1'),
                        value: _isChecked1,
                        onChanged: (value) {
                          setState(() {
                            _isChecked1 = value;
                          });
                        }
                    ),
                    CheckboxListTile(
                        title: Text('2'),
                        value: _isChecked2,
                        onChanged: (value) {
                          setState(() {
                            _isChecked2 = value;
                          });
                        }
                    ),
                    CheckboxListTile(
                        title: Text('3'),
                        value: _isChecked2,
                        onChanged: (value) {
                          setState(() {
                            _isChecked2 = value;
                          });
                        }
                    ),
                    CheckboxListTile(
                        title: Text('4'),
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
                  maxLines: 8,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                  hintText: '''내용<구체적으로 적어주세요>
예) 김샬롬 옷장 두 번째 서랍이 안닫혀요''',
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
