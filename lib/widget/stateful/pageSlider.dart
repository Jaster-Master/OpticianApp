import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opticianapp/sth.dart';
import 'package:opticianapp/widget/stateful/home.dart';
import 'package:opticianapp/widget/stateful/partnerlist.dart';
import 'package:opticianapp/widget/stateless/eyeglassPrescription.dart';
import 'package:opticianapp/widget/stateless/settings.dart';

class PageSlider extends StatefulWidget {
  const PageSlider({super.key});

  @override
  State<StatefulWidget> createState() => PageSliderState();
}

class PageSliderState extends State<PageSlider> {
  late List<bool> activePages = [true, false, false, false];
  PageController controller = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              //physics: NeverScrollableScrollPhysics(),
              controller: controller,
              onPageChanged: (page) {
                setState(() {
                  pageChanged(page);
                });
              },
              children: const [
                HomeView(),
                EyeglassPrescriptionView(),
                PartnerListView(),
                SettingsView(),
              ],
            ),
          ),
          Center(
              child: Padding(
            padding: EdgeInsets.only(bottom: Sth.morePadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PageIcon(controller, 0, Icons.home, activePages[0]),
                PageIcon(controller, 1, Icons.description, activePages[1]),
                PageIcon(controller, 2, Icons.person, activePages[2]),
                PageIcon(controller, 3, Icons.comment, activePages[3]),
              ],
            ),
          ),),
        ],
      ),
    );
  }

  void pageChanged(int page) {
    for (int i = 0; i < activePages.length; i++) {
      activePages[i] = page == i;
    }
  }
}

class PageIcon extends StatefulWidget {
  PageController controller;
  int index;
  IconData icon;
  bool isActive;

  PageIcon(this.controller, this.index, this.icon, this.isActive, {super.key});

  @override
  State<StatefulWidget> createState() => PageIconState();
}

class PageIconState extends State<PageIcon> {
  @override
  Widget build(BuildContext context) {
    Color color = widget.isActive ? Color(0xFF4525f2) : Colors.transparent;
    return Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: color,
              width: 5,
            ),
          ),
        ),
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(widget.icon, size: 40),
          onPressed: () {
            onIconPressed();
          },
        ),
      ),
    );
  }

  void onIconPressed() {
    widget.controller.jumpToPage(widget.index);
  }
}
