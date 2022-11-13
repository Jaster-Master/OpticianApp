import 'package:flutter/cupertino.dart';
import 'package:opticianapp/default_properties.dart';

class EyeglassPrescriptionView extends StatelessWidget {
  const EyeglassPrescriptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(DefaultProperties.morePadding),
      child: Column(
        children: [
          Text("Brillenpass"),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
          ),
        ],
      )
    );
  }
}
