import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zinfy/widgets/styles.dart';
import 'package:http/http.dart' as http;
import 'enter_mobile.dart';

class SigninScreen extends StatefulWidget {
  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  bool showPass = false;
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  Future<void> signin() async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://www.zinfytechwebsolutions.com/projects/zaiquah/user-login.php'));
    request.fields.addAll({
      'username': '${usernameController.text}',
      'password': '${passwordController.text}'
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var res = jsonDecode(await response.stream.bytesToString());
      if (res["status"] == true)
        Fluttertoast.showToast(
            msg: "Sign-in success!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      else
        Fluttertoast.showToast(
            msg: "Invalid credentials!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
    } else {
      print(response.reasonPhrase);
      Fluttertoast.showToast(
          msg: "Invalid credentials!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    }
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
              SizedBox(),
              Column(
                children: [
                  aimage("zaiqa_logo", context: context, height: 0.1),
                  SBox(context, 0.04),
                  heading(context,
                      text: "Welcome", scale: 2, weight: FontWeight.w600),
                  heading(context,
                      text: "Sign into your Account", weight: FontWeight.w700),
                  SBox(context, 0.06),
                  txtFieldLabelContainer(context,
                      controller: usernameController,
                      suffixIcon: Icon(Icons.mail, color: hexColor("F15734")),
                      labelText: "Enter your email*"),
                  SBox(context, 0.04),
                  txtFieldLabelContainer(context,
                      obsecure: !showPass,
                      suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              showPass = !showPass;
                            });
                          },
                          child: Icon(
                              showPass
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: hexColor("F15734"))),
                      labelText: "Password*",
                      controller: passwordController),
                  SBox(context, 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      heading(context,
                          text: "Forgot your password?",
                          color: Colors.grey,
                          weight: FontWeight.w700)
                    ],
                  ),
                  SBox(context, 0.04),
                  Row(
                    children: [
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          signin();
                        },
                        child: button1(
                            Center(
                                child: heading(context,
                                    text: "Login",
                                    weight: FontWeight.w700,
                                    color: Colors.white)),
                            25,
                            color: hexColor("F15734")),
                      )),
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  heading(context,
                      text: "Don't have an account?", weight: FontWeight.w500),
                  SizedBox(width: 5),
                  navigate(
                    context: context,
                    page: EnterMobile(),
                    child: heading(context,
                        text: "Register Now",
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
