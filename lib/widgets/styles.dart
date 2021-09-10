import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget heading(BuildContext context,
    {String text = "",
    Color? color,
    double opacity = 1,
    double txtSize = 15,
    int maxLines = 100,
    TextDecoration textDecoration = TextDecoration.none,
    FontWeight weight = FontWeight.w400,
    TextAlign align = TextAlign.left,
    double scale = 1}) {
  return Opacity(
    opacity: opacity,
    child: Text("$text",
        overflow: TextOverflow.ellipsis,
        textAlign: align,
        maxLines: maxLines,
        textScaleFactor: scale,
        style: TextStyle(
            decoration: textDecoration,
            fontSize: txtSize,
            color: color,
            fontWeight: weight)),
  );
}

PageController controller = PageController(
  initialPage: 0,
);

Widget button1(Widget child, double radius,
    {Color color = Colors.lightBlueAccent,
    Color borColor = Colors.transparent}) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: child,
    ),
    decoration: BoxDecoration(
        border: Border.all(color: borColor, width: 0.8),
        borderRadius: BorderRadius.circular(radius),
        color: color),
  );
}

Widget buttonText(String text,
    {Color color = Colors.lightBlueAccent,
    Color txtColor = Colors.white,
    double borRadius = 10,
    Color borColor = Colors.transparent}) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Center(
          child: Text("$text",
              textScaleFactor: 1.1,
              style: TextStyle(fontWeight: FontWeight.w800, color: txtColor))),
    ),
    decoration: BoxDecoration(
        border: Border.all(color: borColor, width: 0.8),
        borderRadius: BorderRadius.circular(borRadius),
        color: color),
  );
}

Widget SBox(BuildContext context, double hght) {
  var height = MediaQuery.of(context).size.height;
  return SizedBox(height: height * hght);
}

Widget hPadding({Widget? child}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
    child: child,
  );
}

Color hexColor(String color) {
  int c = int.parse("0xff$color");
  return Color(c);
}

Widget aimage(String name,
    {required BuildContext context,
    required double height,
    double scale = 1,
    Color? color}) {
  return Container(
    height: MediaQuery.of(context).size.height * height,
    child: Image.asset(
      "assets/$name.png",
      scale: scale,
      color: color,
    ),
  );
}

Widget navigate(
    {required BuildContext context,
    required Widget page,
    required Widget child}) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => page));
    },
    child: child,
  );
}

Widget txtFieldLabelContainer(BuildContext context,
    {required String labelText,
    String hintText = "",
    TextEditingController? controller,
    int maxLines = 1,
    bool obsecure = false,
    required Widget suffixIcon}) {
  bool isSelected = false;
  return Row(
    children: [
      Expanded(
          child: Container(
              child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: TextField(
          controller: controller,
          onTap: () {
            isSelected = true;
          },
          minLines: maxLines,
          maxLines: maxLines,
          obscureText: obsecure,
          decoration: InputDecoration(
              suffixIcon: suffixIcon,
              labelText: labelText,
              labelStyle: TextStyle(color: Colors.black38, fontSize: 20),
              hintText: hintText,
              hintStyle: TextStyle(fontWeight: FontWeight.w800)),
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      )))
    ],
  );
}

Color orangePrimaryColor = Color(0xffF15223);

// var mq = MediaQuery.of(context).size;
// var height = mq.height;
// var width = mq.width;
