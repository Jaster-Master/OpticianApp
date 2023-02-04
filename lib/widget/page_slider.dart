import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:opticianapp/data/json_reader.dart';
import 'package:opticianapp/default_properties.dart';
import 'package:opticianapp/model/eyeglass_prescription.dart';
import 'package:opticianapp/widget/home/home.dart';
import 'package:opticianapp/widget/page_slider_icon.dart';
import 'package:opticianapp/widget/partnerlist/partnerlist.dart';
import 'package:opticianapp/widget/eyeglass_prescription/eyeglass_prescription.dart';
import 'package:opticianapp/widget/information/information.dart';

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
                  PageSliderIcon(controller, 0, Icons.home_outlined, activePages[0],
                      "Home"),
                  PageSliderIcon(controller, 1, Icons.description_outlined,
                      activePages[1], "Brillenpass"),
                  PageSliderIcon(controller, 2, Icons.person_outlined, activePages[2],
                      "Partnerliste"),
                  PageSliderIcon(controller, 3, Icons.comment_outlined,
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