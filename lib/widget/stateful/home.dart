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

  HomeView(this.orders,this.appointments,this.updateView, this.isAppointmentView, {super.key});

  @override
  State<StatefulWidget> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  void updateView(bool isAppointmentView) {
    setState(() {
      widget.isAppointmentView = isAppointmentView;
      widget.updateView(isAppointmentView);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.isAppointmentView
          ? AppointmentView(widget.appointments, updateView)
          : OrderView(widget.orders, updateView),
    );
  }
}
