import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:shalomhouse/constants/common_size.dart';
import 'package:shalomhouse/data/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final inputBorder =
      const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey));

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  UserModel? _userModel;

  @override
  void dispose() {
    _nameController.dispose();
    _numController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        SizedBox(height: 40,),
        Text('SWU 기숙사',
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: Theme.of(context).colorScheme.primary)),
        SizedBox(height: 50,),
        const Text(
          '기본 정보 입력하기',
          style: TextStyle(color: Colors.black38),
        ),
        SizedBox(height: 16,),
        TextFormField(
          controller: _nameController,
          decoration: InputDecoration(
              hintText: '이름',
              contentPadding: const EdgeInsets.symmetric(horizontal: common_padding),
              focusedBorder: inputBorder,
              border: inputBorder),
        ),
        TextFormField(
          controller: _numController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            MaskedInputFormatter("000000")
          ],
          decoration: InputDecoration(
              hintText: '학번',
              contentPadding: const EdgeInsets.symmetric(horizontal: common_padding),
              focusedBorder: inputBorder,
              border: inputBorder),
        ),
        TextField(
          controller: _codeController,
          keyboardType: TextInputType.visiblePassword,
          maxLength: 6,
          decoration: InputDecoration(
              hintText: '기숙사코드',
              contentPadding: const EdgeInsets.symmetric(horizontal: common_padding),
              focusedBorder: inputBorder,
              border: inputBorder),
        ),
        ElevatedButton(
            onPressed: () {
              if(_codeController.text=='202301') {
                _saveRegisterSP(_nameController.text, _numController.text);
                context.read<PageController>().animateToPage(3,
                    duration: const Duration(milliseconds: 500), curve: Curves.ease);
              }else {
                SnackBar snackbar = const SnackBar(
                  content: Text('코드가 틀리거나 코드를 입력해주세요!'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
              }
            },
            child: const Text('save')),
      ],
    ));
  }

  _saveRegisterSP(nameValue, numValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('studentname', nameValue);
    await prefs.setString('studentnum', numValue);
  }
}
