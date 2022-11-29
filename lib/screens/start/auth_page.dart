import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:hanoimall/constants/common_size.dart';
import 'package:hanoimall/states/user_provider.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  TextEditingController _phoneNumberController = TextEditingController(text: "010");

  TextEditingController _codeController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  VerificationStatus _verificationStatus = VerificationStatus.none;

  Duration duration = Duration(microseconds: 300);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext, BoxConstraints) {
        Size size = MediaQuery.of(context).size;
        return IgnorePointer(
          ignoring: _verificationStatus == VerificationStatus.verifying,
          child: Form(
            key: _formKey,
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  'phone login',
                  style: Theme.of(context).appBarTheme.titleTextStyle,
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(common_padding),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ExtendedImage.asset(
                          'assets/imgs/padlock.png',
                          width: size.width * 0.15,
                          height: size.width * 0.15,
                        ),
                        SizedBox(width: common_padding,),
                        Text('''소미몰은 휴대폰 가입해요.
전화번호는 안전하게 보관 되며
어디에도 공개되지 않아요.''')
                      ],
                    ),
                    SizedBox(height: common_padding,),
                    TextFormField(
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [MaskedInputFormatter("000 0000 0000")],
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)
                        )
                     ),
                        validator:(phoneNumber){
                          if(phoneNumber != null && phoneNumber.length == 13){
                            return null;
                          }else{
                            return "정확한 전화번호를 입력해주세요";
                          }
                        }
                    ),
                    SizedBox(height: common_sm_padding,),
                    TextButton(
                        onPressed: (){
                      if(_formKey.currentState != null) {
                           bool passed = _formKey.currentState!.validate();
                           if(passed)
                             setState((){
                               _verificationStatus=VerificationStatus.codeSent;
                             });

                          }
                        }, child: Text('인증문자 발송')),
                    SizedBox(height: common_padding,),
                    AnimatedOpacity(
                      duration: duration,
                      curve:  Curves.easeInOut,
                      opacity: (_verificationStatus == VerificationStatus.none)?0:1,
                      child: AnimatedContainer(
                        duration: duration,
                        curve:  Curves.easeInOut,
                        height: getVerificationHeight(_verificationStatus),
                        child: TextFormField(
                          controller: _codeController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [MaskedInputFormatter("000000")],
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey)
                              )
                          ),

                        ),
                      ),
                    ),
                    SizedBox(height: common_sm_padding,),
                    AnimatedContainer(
                        duration: Duration(seconds: 1),
                        curve:  Curves.easeInOut,
                        height: getVerificationBtnHeight(_verificationStatus),
                        child: TextButton(onPressed: (){
                          attemptVerify();
                        }, child: (_verificationStatus == VerificationStatus.verifying)?CircularProgressIndicator(color: Colors.white,):Text('      인증       ')))
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  double getVerificationHeight(VerificationStatus status){
    switch(status){

      case VerificationStatus.none:
        return 0;
      case VerificationStatus.codeSent:
      case VerificationStatus.verifying:
      case VerificationStatus.verificationDone:
       return 60 + common_sm_padding;
    }
  }
  double getVerificationBtnHeight(VerificationStatus status){
    switch(status){

      case VerificationStatus.none:
        return 0;
      case VerificationStatus.codeSent:
      case VerificationStatus.verifying:
      case VerificationStatus.verificationDone:
        return 48 + common_sm_padding;
    }
  }

  void attemptVerify()async{
    setState(() {
      _verificationStatus = VerificationStatus.verifying;
    });
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _verificationStatus = VerificationStatus.verificationDone;
    });
    context.read<UserProvider>().setUserAuth(true);
  }
}
enum VerificationStatus{
  none, codeSent, verifying, verificationDone
}