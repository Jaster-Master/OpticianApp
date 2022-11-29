import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opticianapp/default_properties.dart';
import 'package:opticianapp/model/eyeglass_prescription.dart';
import 'package:opticianapp/widget/stateless/eyeglass_prescription.dart';

class EyeglassPrescriptionView extends StatefulWidget {
  List<EyeglassPrescription> eyeglassPrescriptions;

  EyeglassPrescriptionView(this.eyeglassPrescriptions, {super.key});

  @override
  State<StatefulWidget> createState() => EyeglassPrescriptionViewState();
}

class EyeglassPrescriptionViewState extends State<EyeglassPrescriptionView> {
  int index = -1;

  @override
  Widget build(BuildContext context) {
    var tabText = Text("Brillenpass",
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

    return index == -1
        ? Padding(
            padding: EdgeInsets.only(top: DefaultProperties.defaultPadding),
            child: Padding(
              padding: EdgeInsets.all(DefaultProperties.morePadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  tab,
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(DefaultProperties.lessPadding),
                      child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white,
                              Colors.white.withOpacity(0.05)
                            ],
                            stops: [0.75, 1],
                            tileMode: TileMode.mirror,
                          ).createShader(bounds);
                        },
                        child: NotificationListener<
                            OverscrollIndicatorNotification>(
                          onNotification: (overscroll) {
                            overscroll.disallowIndicator();
                            return true;
                          },
                          child: ListView.builder(
                            itemCount: widget.eyeglassPrescriptions.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    bottom: index ==
                                            widget.eyeglassPrescriptions
                                                    .length -
                                                1
                                        ? DefaultProperties.doubleMorePadding
                                        : 0),
                                child: EyeglassPrescriptionItem(this,
                                    widget.eyeglassPrescriptions[index], index),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Colors.white.withOpacity(0.05)],
                stops: [0.75, 1],
                tileMode: TileMode.mirror,
              ).createShader(bounds);
            },
            child: EyeglassPrescriptionDetailView(
                this, widget.eyeglassPrescriptions[index]),
          );
  }
}

class EyeglassPrescriptionItem extends StatelessWidget {
  EyeglassPrescriptionViewState currentState;
  EyeglassPrescription item;
  int index;

  EyeglassPrescriptionItem(this.currentState, this.item, this.index,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: DefaultProperties.morePadding),
      child: GestureDetector(
        onTap: () => {onItemPress(context, item)},
        child: Container(
          margin: EdgeInsets.all(DefaultProperties.defaultPadding),
          padding: EdgeInsets.all(DefaultProperties.defaultPadding),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.circular(DefaultProperties.defaultRounded),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.25),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 10.0)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Brillenpass"),
              Text("vom " +
                  DefaultProperties.defaultDateFormat.format(item.date))
            ],
          ),
        ),
      ),
    );
  }

  void onItemPress(BuildContext context, EyeglassPrescription item) {
    currentState.setState(() {
      currentState.index = index;
    });
  }
}

class EyeglassPrescriptionDetailView extends StatelessWidget {
  EyeglassPrescriptionViewState currentState;
  EyeglassPrescription item;

  EyeglassPrescriptionDetailView(this.currentState, this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: DefaultProperties.doubleMorePadding,
          bottom: DefaultProperties.doubleMorePadding),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () => {onBackButtonPress()},
                      icon: Icon(Icons.arrow_back)),
                  Text("Zurück"),
                ],
              ),
              Text(item.text ?? ""),
              ExpansionTile(
                title: Text("Persönlich"),
                children: [Text(item.forename ?? ""), Text(item.surname ?? "")],
              ),
              Visibility(
                visible: item.type[1] == "B",
                child: ExpansionTile(
                  title: Text("Augen"),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Linkes Auge"),
                        Text(" <- Wert -> "),
                        Text("Rechtes Auge"),
                      ],
                    ),
                    Text(""),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(item.sphLeft.toString() ?? ""),
                        Text(" <- Sphäre -> "),
                        Text(item.sphRight.toString() ?? ""),
                      ],
                    ),
                    Text(""),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(item.cylLeft.toString() ?? ""),
                        Text(" <- Zylinderwert -> "),
                        Text(item.cylRight.toString() ?? ""),
                      ],
                    ),
                    Text(""),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(item.pdLeft.toString() ?? ""),
                        Text(" <- Pupillendistanz -> "),
                        Text(item.pdRight.toString() ?? ""),
                      ],
                    ),
                    Text(""),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(item.hightLeft.toString() ?? ""),
                        Text(" <- Höhe -> "),
                        Text(item.hightRight.toString() ?? ""),
                      ],
                    )
                  ],
                ),
              ),
              Visibility(
                visible: item.type[1] == "B",
                child: ExpansionTile(
                  title: Text("Gläser"),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Linkes Glas"),
                        Text(" <- Wert -> "),
                        Text("Rechtes Glas"),
                      ],
                    ),
                    Text(""),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(item.axisLeft.toString() ?? ""),
                        Text(" <- Achse -> "),
                        Text(item.axisRight.toString() ?? ""),
                      ],
                    ),
                    Text(""),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(item.addLeft.toString() ?? ""),
                        Text(" <- ADD-Wert -> "),
                        Text(item.addRight.toString() ?? ""),
                      ],
                    ),
                    Text(""),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(item.prism1Left.toString() ?? ""),
                      Text(" <- Prisma-1 -> "),
                      Text(item.prism1Right.toString() ?? ""),
                    ]),
                    Text(""),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(item.basis1Left.toString() ?? ""),
                      Text(" <- Basis-1 -> "),
                      Text(item.basis1Right.toString() ?? ""),
                    ]),
                    Text(""),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(item.prism2Left.toString() ?? ""),
                      Text(" <- Prisma-2 -> "),
                      Text(item.prism2Right.toString() ?? ""),
                    ]),
                    Text(""),
                    Container(
                      margin: EdgeInsets.only(
                          bottom: DefaultProperties.tripleMorePadding),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(item.basis2Left.toString() ?? ""),
                            Text(" <- Basis-2 -> "),
                            Text(item.basis2Right.toString() ?? ""),
                          ]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onBackButtonPress() {
    currentState.setState(() {
      currentState.index = -1;
    });
  }
}
