import 'package:flutter/material.dart';
import 'package:hanoimall/constants/common_size.dart';

class AddreesPage extends StatelessWidget {
  const AddreesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.all(common_padding),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(
                    Icons.search),
              hintText: '도로명으로 검색',
              hintStyle: TextStyle(color: Theme.of(context).hintColor),
              border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey),),

              prefixIconConstraints:
                BoxConstraints(minWidth: 24, minHeight: 24)
            ),
          )
        ],
      ),
    );
  }
}
