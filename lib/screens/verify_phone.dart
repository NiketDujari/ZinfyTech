import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:zinfy/screens/enter_details.dart';
import 'package:zinfy/widgets/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VerifyPhone extends StatefulWidget {
  String? mobile;
  VerifyPhone({this.mobile});
  @override
  _VerifyPhoneState createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  String otpEntered = "";

  final _auth = FirebaseAuth.instance;
  String _verificationId = "";

  @override
  void initState() {
    super.initState();
    verifyPhone();
  }

  Future<void> verifyPhone() async {
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      Fluttertoast.showToast(
          msg: "Some error occurred",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
      print(
          'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
    };
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      await _auth.signInWithCredential(phoneAuthCredential);
      print(
          "Phone number automatically verified and user signed in: ${_auth.currentUser!.uid}");
    };
    PhoneCodeSent codeSent =
        (String verificationId, [int? forceResendingToken]) async {
      Fluttertoast.showToast(
          msg: "The code has been sent",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
      print('Please check your phone for the verification code.');
      _verificationId = verificationId;
    };

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      print("verification code: " + verificationId);
      _verificationId = verificationId;
    };

    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: widget.mobile!,
          timeout: const Duration(seconds: 5),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Incorrect number entered",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
      print("Failed to Verify Phone Number: $e");
    }
  }

  void signInWithPhoneNumber() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: otpEntered,
      );

      final User? user = (await _auth.signInWithCredential(credential)).user;

      print("Successfully signed in UID: ${user!.uid}");
      Fluttertoast.showToast(
          msg: "OTP Verified!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => EnterDetails()));
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Incorrect OTP entered",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
      print("Failed to sign in: " + e.toString());
    }
  }

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
                  text: "Verify Your Phone No.",
                  scale: 1.6,
                  weight: FontWeight.w600),
              SBox(context, 0.01),
              heading(context,
                  text: "Please Enter The 6 Digit Code Sent To",
                  weight: FontWeight.w600),
              heading(context, text: widget.mobile!, weight: FontWeight.w600),
              SBox(context, 0.04),
              OTPTextField(
                length: 6,
                width: MediaQuery.of(context).size.width * 0.8,
                fieldWidth: MediaQuery.of(context).size.width * 0.1,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.underline,
                onCompleted: (pin) {
                  print("Completed: " + pin);
                  setState(() {
                    otpEntered = pin;
                  });
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
                      child: GestureDetector(
                    onTap: () {
                      signInWithPhoneNumber();
                    },
                    child: button1(
                        Center(
                            child: heading(context,
                                text: "Verify",
                                weight: FontWeight.w700,
                                color: Colors.white)),
                        25,
                        color: hexColor("F15734")),
                  )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
