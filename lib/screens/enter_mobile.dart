import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zinfy/screens/signin_screen.dart';
import 'package:zinfy/screens/verify_phone.dart';
import 'package:zinfy/widgets/styles.dart';

class EnterMobile extends StatefulWidget {
  @override
  _EnterMobileState createState() => _EnterMobileState();
}

class _EnterMobileState extends State<EnterMobile> {
  TextEditingController phoneController = new TextEditingController();

  String validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return "ok";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SBox(context, 0.07),
                  aimage("zaiqa_logo", context: context, height: 0.1),
                  SBox(context, 0.04),
                  heading(context,
                      text: "Create Account",
                      scale: 1.5,
                      weight: FontWeight.w600),
                  SBox(context, 0.04),
                  txtFieldLabelContainer(context,
                      controller: phoneController,
                      suffixIcon:
                          Icon(Icons.phone_iphone, color: hexColor("F15734")),
                      labelText: "Enter your mobile number*"),
                  SBox(context, 0.06),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (validateMobile(phoneController.text) == "ok") {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => VerifyPhone(
                                          mobile: phoneController.text)));
                            } else {
                              Fluttertoast.showToast(
                                  msg: validateMobile(phoneController.text),
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  fontSize: 16.0);
                            }
                          },
                          child: button1(
                              Center(
                                  child: heading(context,
                                      text: "GET OTP",
                                      weight: FontWeight.w700,
                                      color: Colors.white)),
                              25,
                              color: hexColor("F15734")),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  heading(context,
                      text: "Already have an account?",
                      weight: FontWeight.w500),
                  SizedBox(width: 5),
                  navigate(
                    context: context,
                    page: SigninScreen(),
                    child: heading(context,
                        text: "Login",
                        weight: FontWeight.w500,
                        color: Colors.orange,
                        textDecoration: TextDecoration.underline),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
