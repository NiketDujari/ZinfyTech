import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:zinfy/widgets/styles.dart';

class VerifyEmail extends StatefulWidget {
  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SBox(context, 0.02),
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: hexColor("FEFBEA")),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: aimage("mail", context: context, height: 0.1),
                ),
              ),
              SBox(context, 0.04),
              heading(context,
                  text: "Verify Your Email",
                  scale: 1.6,
                  weight: FontWeight.w600),
              SBox(context, 0.01),
              heading(context,
                  text: "Please Enter The 4 Digit Code Sent To",
                  weight: FontWeight.w600),
              heading(context, text: "abc@gmail.com", weight: FontWeight.w600),
              SBox(context, 0.04),
              OTPTextField(
                length: 4,
                width: MediaQuery.of(context).size.width * 0.8,
                fieldWidth: 40,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.underline,
                onCompleted: (pin) {
                  print("Completed: " + pin);
                },
              ),
              SBox(context, 0.05),
              heading(context,
                  text: "Resend Code",
                  textDecoration: TextDecoration.underline,
                  weight: FontWeight.w500,
                  color: hexColor("F15734")),
              SBox(context, 0.08),
              Row(
                children: [
                  Expanded(
                      child: button1(
                          Center(
                              child: heading(context,
                                  text: "Verify",
                                  weight: FontWeight.w700,
                                  color: Colors.white)),
                          25,
                          color: hexColor("F15734"))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
