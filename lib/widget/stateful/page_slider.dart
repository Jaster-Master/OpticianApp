import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:opticianapp/data/json_reader.dart';
import 'package:opticianapp/default_properties.dart';
import 'package:opticianapp/model/eyeglass_prescription.dart';
import 'package:opticianapp/widget/stateful/home.dart';
import 'package:opticianapp/widget/stateful/partnerlist.dart';
import 'package:opticianapp/widget/stateless/eyeglass_prescription.dart';
import 'package:opticianapp/widget/stateless/information.dart';

class PageSlider extends StatefulWidget {
  bool isAppointmentView = true;

  PageSlider(this.isAppointmentView, {super.key});

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

  void updateView(bool isAppointmentView) {
    widget.isAppointmentView = isAppointmentView;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                overscroll.disallowIndicator();
                return true;
              },
              child: PageView(
                controller: controller,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (page) {
                  setState(() {
                    pageChanged(page);
                  });
                },
                children: [
                  HomeView(JsonReader.orders, JsonReader.appointments,
                      updateView, widget.isAppointmentView),
                  EyeglassPrescriptionView(JsonReader.eyeglassPrescriptions),
                  PartnerListView(),
                  InformationView(),
                ],
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: DefaultProperties.morePadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  PageIcon(controller, 0, Icons.home_outlined, activePages[0],
                      "Home"),
                  PageIcon(controller, 1, Icons.description_outlined,
                      activePages[1], "Brillenpass"),
                  PageIcon(controller, 2, Icons.person_outlined, activePages[2],
                      "Partnerliste"),
                  PageIcon(controller, 3, Icons.comment_outlined,
                      activePages[3], "Einstellungen"),
                ],
              ),
            ),
          ),
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
  String tooltip;

  PageIcon(this.controller, this.index, this.icon, this.isActive, this.tooltip);

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
          tooltip: widget.tooltip,
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
