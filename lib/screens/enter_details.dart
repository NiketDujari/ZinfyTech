import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zinfy/screens/signin_screen.dart';
import 'package:zinfy/screens/verify_email.dart';
import 'package:zinfy/widgets/styles.dart';
import 'package:http/http.dart' as http;

class EnterDetails extends StatefulWidget {
  @override
  _EnterDetailsState createState() => _EnterDetailsState();
}

class _EnterDetailsState extends State<EnterDetails> {
  bool showPass = false;
  bool showConfirmPass = false;
  bool checked = false;

  TextEditingController usernameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmpasswordController = new TextEditingController();

  Future<void> register() async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://www.zinfytechwebsolutions.com/projects/zaiquah/user-registration.php'));
    request.fields.addAll({
      'username': '${usernameController.text}',
      'email': '${emailController.text}',
      'password': '${passwordController.text}',
      'confirm_password': '${confirmpasswordController.text}'
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var res = jsonDecode(await response.stream.bytesToString());
      print(res.toString());
      if (res["status"] == true) {
        Fluttertoast.showToast(
            msg: "Registration success!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => VerifyEmail()));
      } else {
        Fluttertoast.showToast(
            msg: res["message"],
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      }
    } else {
      var error = jsonDecode(response.reasonPhrase!);
      Fluttertoast.showToast(
          msg: error["message"],
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
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
                      suffixIcon: Icon(Icons.person, color: hexColor("F15734")),
                      labelText: "Username*",
                      controller: usernameController),
                  SBox(context, 0.04),
                  txtFieldLabelContainer(context,
                      suffixIcon: Icon(Icons.mail, color: hexColor("F15734")),
                      labelText: "Email ID*",
                      controller: emailController),
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
                  SBox(context, 0.04),
                  txtFieldLabelContainer(context,
                      obsecure: !showConfirmPass,
                      suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              showConfirmPass = !showConfirmPass;
                            });
                          },
                          child: Icon(
                              showConfirmPass
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: hexColor("F15734"))),
                      labelText: "Password*",
                      controller: confirmpasswordController),
                  SBox(context, 0.04),
                  Row(
                    children: [
                      SizedBox(
                          height: 24.0,
                          width: 24.0,
                          child: Checkbox(
                              checkColor: Colors.black,
                              activeColor: Colors.black12,
                              value: checked,
                              onChanged: (value) {
                                setState(() {
                                  checked = value!;
                                });
                              })),
                      SizedBox(width: 10),
                      heading(
                        context,
                        text: "I Read and agree to",
                        scale: 0.9,
                      ),
                      SizedBox(width: 5),
                      heading(context,
                          text: "Terms & Conditions",
                          textDecoration: TextDecoration.underline,
                          scale: 0.9,
                          color: hexColor("F15734"))
                    ],
                  ),
                  SBox(context, 0.04),
                  Row(
                    children: [
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          if (checked)
                            register();
                          else
                            Fluttertoast.showToast(
                                msg: "Please check T&C",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.TOP,
                                timeInSecForIosWeb: 1,
                                fontSize: 16.0);
                        },
                        child: button1(
                            Center(
                                child: heading(context,
                                    text: "Register Now",
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
