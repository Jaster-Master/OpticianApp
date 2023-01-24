import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opticianapp/model/appointment.dart';
import 'package:opticianapp/model/order.dart';
import 'package:opticianapp/widget/stateful/appointment.dart';
import 'package:opticianapp/widget/stateless/order.dart';

class HomeView extends StatefulWidget {
  List<Order> orders;
  List<Appointment> appointments;
  ValueChanged<bool> updateView;
  bool isAppointmentView;

  HomeView(
      this.orders, this.appointments, this.updateView, this.isAppointmentView,
      {super.key});

  @override
  State<StatefulWidget> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  late List<bool> activePages = [true, false];
  PageController controller = PageController(
    initialPage: 0,
  );

  void updateView(int page) {
    setState(() {
      widget.isAppointmentView = page == 0;
      widget.updateView(widget.isAppointmentView);
    });
  }

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: widget.isAppointmentView ? 0 : 1);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.addListener(() {
      if (controller.page == 0 || controller.page == 1) {
        if (controller.page != null) {
          updateView(controller.page!.toInt());
        }
      }
    });
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
                onPageChanged: (page) {
                  setState(() {
                    pageChanged(page);
                  });
                },
                children: [
                  AppointmentView(widget.appointments, controller),
                  OrderView(widget.orders, controller)
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
