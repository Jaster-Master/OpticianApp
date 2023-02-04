import 'package:flutter/material.dart';

class PageSliderIcon extends StatefulWidget {
  PageController controller;
  int index;
  IconData icon;
  bool isActive;
  String tooltip;

  PageSliderIcon(this.controller, this.index, this.icon, this.isActive, this.tooltip);

  @override
  State<StatefulWidget> createState() => PageIconState();
}

class PageIconState extends State<PageSliderIcon> {
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
