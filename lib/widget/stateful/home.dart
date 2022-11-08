import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opticianapp/widget/stateful/appointment.dart';
import 'package:opticianapp/widget/stateful/partnerlist.dart';
import 'package:opticianapp/widget/stateless/eyeglassPrescription.dart';
import 'package:opticianapp/widget/stateless/order.dart';
import 'package:opticianapp/widget/stateless/settings.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<StatefulWidget> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  PageController controller = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: PageView(
          controller: controller,
          onPageChanged: (page) {
            setState(() {
              pageChanged(page);
            });
          },
          children: const [
            AppointmentView(),
            OrderView(),
          ],
        ),
      ),
    );
  }

  void pageChanged(int page) {

  }
}
