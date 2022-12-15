import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opticianapp/default_properties.dart';
import 'package:opticianapp/widget/stateful/login.dart';
import 'package:opticianapp/widget/stateless/about.dart';
import 'package:opticianapp/widget/stateless/faq.dart';
import 'package:opticianapp/widget/stateless/feedback.dart';
import 'package:opticianapp/widget/stateless/imprint.dart';

class InformationView extends StatelessWidget {
  const InformationView({super.key});

  @override
  Widget build(BuildContext context) {
    var tabText = Text("Informationen",
        style: TextStyle(fontSize: DefaultProperties.fontSize1));
    var tab = Row(
      children: [
        Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: DefaultProperties.blueColor,
                    width: 5,
                  ),
                ),
              ),
              child: tabText,
            ),
            IconButton(
              icon: Icon(Icons.local_shipping_outlined, size: 0),
              onPressed: null,
            ),
          ],
        ),
      ],
    );
    return Padding(
      padding: EdgeInsets.only(top: DefaultProperties.defaultPadding),
      child: Padding(
        padding: EdgeInsets.all(DefaultProperties.morePadding),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          tab,
          Padding(
            padding: EdgeInsets.only(top: DefaultProperties.defaultPadding),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.25),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 10.0)),
                ],
              ),
              child: Column(
                children: [
                  InformationItemView(
                      "FAQ Kontaktlinsen",
                      Icon(Icons.message_outlined, color: Colors.black),
                      FaqContactLensesView(),
                      true,
                      false,
                      Colors.black),
                  InformationItemView(
                      "FAQ Brillen",
                      Icon(Icons.message_outlined, color: Colors.black),
                      FaqGlassesView(),
                      false,
                      false,
                      Colors.black),
                  InformationItemView(
                      "Impressum",
                      Icon(Icons.book_outlined, color: Colors.black),
                      ImprintView(),
                      false,
                      false,
                      Colors.black),
                  InformationItemView(
                      "Über Optics",
                      Icon(Icons.circle_outlined, color: Colors.black),
                      AboutView(),
                      false,
                      false,
                      Colors.black),
                  InformationItemView(
                      "Feedback",
                      Icon(Icons.face_outlined, color: Colors.black),
                      FeedbackView(),
                      false,
                      false,
                      Colors.black),
                  InformationItemView(
                      "Logout",
                      Icon(Icons.logout_outlined,
                          color: DefaultProperties.blueColor),
                      LoginView(),
                      false,
                      true,
                      DefaultProperties.blueColor),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class InformationItemView extends StatelessWidget {
  String title;
  Icon icon;
  Widget navigatorWidget;
  bool isFirstItem;
  bool isLastItem;
  Color textColor;

  InformationItemView(this.title, this.icon, this.navigatorWidget,
      this.isFirstItem, this.isLastItem, this.textColor,
      {super.key});

  @override
  Widget build(BuildContext context) {
    var borderRadius = BorderRadius.zero;
    if (isFirstItem) {
      borderRadius = BorderRadius.only(
          topLeft: Radius.circular(DefaultProperties.defaultRounded),
          topRight: Radius.circular(DefaultProperties.defaultRounded));
    }
    if (isLastItem) {
      borderRadius = BorderRadius.only(
          bottomLeft: Radius.circular(DefaultProperties.defaultRounded),
          bottomRight: Radius.circular(DefaultProperties.defaultRounded));
    }
    var itemHeight = MediaQuery.of(context).size.height / 15;

    return OutlinedButton(
      style: ButtonStyle(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor:
            MaterialStateColor.resolveWith((states) => Colors.white),
        foregroundColor:
            MaterialStateColor.resolveWith((states) => Colors.white),
        fixedSize: MaterialStateProperty.all(Size.fromHeight(itemHeight)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                side: BorderSide(color: DefaultProperties.lightGrayColor),
                borderRadius: borderRadius)),
      ),
      onPressed: () => {navigateToView(context)},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(right: DefaultProperties.defaultPadding),
            child: icon,
          ),
          Text(title, style: TextStyle(color: textColor))
        ],
      ),
    );
  }

  void navigateToView(BuildContext context) {
    if(isLastItem){
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => navigatorWidget));
    }else{
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => navigatorWidget));
    }
  }
}
