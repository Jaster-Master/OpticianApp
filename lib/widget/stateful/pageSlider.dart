import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
          PageView(
            controller: controller,
            children: const [
              HomeView(),
              EyeglassPrescriptionView(),
              PartnerListView(),
              SettingsView(),
            ],
          ),
          Row(
            children: [
              Icon(Icons.home),
              Icon(Icons.add),
              Icon(Icons.add),
              Icon(Icons.add),
            ],
          ),
        ],
      ),
    );
  }
}
