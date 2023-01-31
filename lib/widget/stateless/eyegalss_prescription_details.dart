import 'package:flutter/material.dart';
import 'package:opticianapp/default_properties.dart';
import 'package:opticianapp/model/eyeglass_prescription.dart';

class EyeglassPrescriptionDetailsView extends StatelessWidget {
  EyeglassPrescription item;

  EyeglassPrescriptionDetailsView(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            top: DefaultProperties.doubleMorePadding,
            bottom: DefaultProperties.doubleMorePadding),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () => {onBackButtonPress(context)},
                      icon: Icon(Icons.arrow_back)),
                  Text("Zurück",
                      style: TextStyle(fontSize: DefaultProperties.fontSize2)),
                ],
              ),
              Text(item.text ?? "",
                  style: TextStyle(fontSize: DefaultProperties.fontSize1)),
              ExpansionTile(
                title: Text("Persönlich",
                    style: TextStyle(fontSize: DefaultProperties.fontSize2)),
                children: [
                  Text(item.forename ?? "",
                      style: TextStyle(fontSize: DefaultProperties.fontSize3)),
                  Text(item.surname ?? "",
                      style: TextStyle(fontSize: DefaultProperties.fontSize3))
                ],
              ),
              Visibility(
                visible: item.type[1] == "B",
                child: ExpansionTile(
                  title: Text("Augen",
                      style: TextStyle(fontSize: DefaultProperties.fontSize2)),
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(width: 1.0, color: Colors.grey))),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1.0, color: Colors.grey))),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Left Eye",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(height: 10.0),
                                        Text("leftEye"),
                                        SizedBox(height: 10.0),
                                        Text("leftEye"),
                                        SizedBox(height: 10.0),
                                        Text("leftEye"),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 1.0,
                                  color: Colors.grey[300],
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text("Type",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(height: 10.0),
                                        Text("type"),
                                        SizedBox(height: 10.0),
                                        Text("type"),
                                        SizedBox(height: 10.0),
                                        Text("type"),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 1.0,
                                  color: Colors.grey[300],
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text("Right Eye",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(height: 10.0),
                                        Text("rightEye"),
                                        SizedBox(height: 10.0),
                                        Text("rightEye"),
                                        SizedBox(height: 10.0),
                                        Text("rightEye"),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                    /*Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Wert",
                            style: TextStyle(
                                fontSize: DefaultProperties.fontSize3)),
                        Spacer(),
                        Text("Linkes Auge | Rechtes Auge",
                            style: TextStyle(
                                fontSize: DefaultProperties.fontSize3)),
                      ],
                    ),
                    Text(""),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Sphäre",
                            style: TextStyle(
                                fontSize: DefaultProperties.fontSize3)),
                        Spacer(),
                        Text(
                            "${item.sphLeft.toString()} | ${item.sphRight.toString()}",
                            style: TextStyle(
                                fontSize: DefaultProperties.fontSize3)),
                      ],
                    ),
                    Text(""),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Zylinderwert",
                            style: TextStyle(
                                fontSize: DefaultProperties.fontSize3)),
                        Spacer(),
                        Text(
                            "${item.cylLeft.toString()} | ${item.cylRight.toString()}",
                            style: TextStyle(
                                fontSize: DefaultProperties.fontSize3)),
                      ],
                    ),
                    Text(""),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Pupillendistanz",
                            style: TextStyle(
                                fontSize: DefaultProperties.fontSize3)),
                        Spacer(),
                        Text(
                            "${item.pdLeft.toString()} | ${item.pdRight.toString()}",
                            style: TextStyle(
                                fontSize: DefaultProperties.fontSize3)),
                      ],
                    ),
                    Text("",
                        style:
                            TextStyle(fontSize: DefaultProperties.fontSize3)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Höhe",
                            style: TextStyle(
                                fontSize: DefaultProperties.fontSize3)),
                        Spacer(),
                        Text(
                            "${item.hightLeft.toString()} | ${item.hightRight.toString()}",
                            style: TextStyle(
                                fontSize: DefaultProperties.fontSize3)),
                      ],
                    )*/
                  ],
                ),
              ),
              Visibility(
                visible: item.type[1] == "B",
                child: ExpansionTile(
                  title: Text("Gläser",
                      style: TextStyle(fontSize: DefaultProperties.fontSize2)),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Wert",
                            style: TextStyle(
                                fontSize: DefaultProperties.fontSize3)),
                        Spacer(),
                        Text("Linkes Glas | Rechtes Glas",
                            style: TextStyle(
                                fontSize: DefaultProperties.fontSize3)),
                      ],
                    ),
                    Text("",
                        style:
                            TextStyle(fontSize: DefaultProperties.fontSize3)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Achse",
                            style: TextStyle(
                                fontSize: DefaultProperties.fontSize3)),
                        Spacer(),
                        Text(
                            "${item.axisLeft.toString()} | ${item.axisRight.toString()}",
                            style: TextStyle(
                                fontSize: DefaultProperties.fontSize3)),
                      ],
                    ),
                    Text("",
                        style:
                            TextStyle(fontSize: DefaultProperties.fontSize3)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("ADD-Wert",
                            style: TextStyle(
                                fontSize: DefaultProperties.fontSize3)),
                        Spacer(),
                        Text(
                            "${item.addLeft.toString()} | ${item.addRight.toString()}",
                            style: TextStyle(
                                fontSize: DefaultProperties.fontSize3)),
                      ],
                    ),
                    Text("",
                        style:
                            TextStyle(fontSize: DefaultProperties.fontSize3)),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text("Prisma-1",
                          style:
                              TextStyle(fontSize: DefaultProperties.fontSize3)),
                      Spacer(),
                      Text(
                          "${item.prism1Left.toString()} | ${item.prism1Right.toString()}",
                          style:
                              TextStyle(fontSize: DefaultProperties.fontSize3)),
                    ]),
                    Text("",
                        style:
                            TextStyle(fontSize: DefaultProperties.fontSize3)),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text("Basis-1",
                          style:
                              TextStyle(fontSize: DefaultProperties.fontSize3)),
                      Spacer(),
                      Text(
                          "${item.basis1Left.toString()} | ${item.basis1Right.toString()}",
                          style:
                              TextStyle(fontSize: DefaultProperties.fontSize3)),
                    ]),
                    Text("",
                        style:
                            TextStyle(fontSize: DefaultProperties.fontSize3)),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text("Prisma-2",
                          style:
                              TextStyle(fontSize: DefaultProperties.fontSize3)),
                      Spacer(),
                      Text(
                          "${item.prism2Left.toString()} | ${item.prism2Right.toString()}",
                          style:
                              TextStyle(fontSize: DefaultProperties.fontSize3)),
                    ]),
                    Text("",
                        style:
                            TextStyle(fontSize: DefaultProperties.fontSize3)),
                    Container(
                      margin: EdgeInsets.only(
                          bottom: DefaultProperties.tripleMorePadding),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Basis-2",
                                style: TextStyle(
                                    fontSize: DefaultProperties.fontSize3)),
                            Spacer(),
                            Text(
                                "${item.basis2Left.toString()} | ${item.basis2Right.toString()}",
                                style: TextStyle(
                                    fontSize: DefaultProperties.fontSize3)),
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

  void onBackButtonPress(BuildContext context) {
    Navigator.pop(context);
  }
}
