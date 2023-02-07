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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.all(DefaultProperties.defaultPadding),
                        decoration: BoxDecoration(
                            border: Border(
                          bottom: BorderSide(width: 1.0, color: Colors.black),
                        )),
                        child: Text(item.forename ?? "",
                            style: TextStyle(
                                fontSize: DefaultProperties.fontSize3)),
                      ),
                      Container(
                          padding:
                              EdgeInsets.all(DefaultProperties.defaultPadding),
                          decoration: BoxDecoration(
                              border: Border(
                            bottom: BorderSide(width: 1.0, color: Colors.black),
                          )),
                          child: Text(item.surname ?? "",
                              style: TextStyle(
                                  fontSize: DefaultProperties.fontSize3))),
                    ],
                  )
                ],
              ),
              Visibility(
                visible: item.type[1] == "B",
                child: ExpansionTile(
                  title: Text("Augen",
                      style: TextStyle(fontSize: DefaultProperties.fontSize2)),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(
                                  DefaultProperties.defaultPadding),
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom:
                                    BorderSide(width: 1.0, color: Colors.black),
                              )),
                              child: Text("Linkes Auge"),
                            ),
                            Container(
                              padding: EdgeInsets.all(
                                  DefaultProperties.defaultPadding),
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom:
                                    BorderSide(width: 1.0, color: Colors.black),
                              )),
                              child: Text("${item.sphLeft.toString()}",
                                  style: TextStyle(
                                      fontSize: DefaultProperties.fontSize3)),
                            ),
                            Container(
                              padding: EdgeInsets.all(
                                  DefaultProperties.defaultPadding),
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom:
                                    BorderSide(width: 1.0, color: Colors.black),
                              )),
                              child: Text("${item.cylLeft.toString()}",
                                  style: TextStyle(
                                      fontSize: DefaultProperties.fontSize3)),
                            ),
                            Container(
                              padding: EdgeInsets.all(
                                  DefaultProperties.defaultPadding),
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom:
                                    BorderSide(width: 1.0, color: Colors.black),
                              )),
                              child: Text("${item.pdLeft.toString()}",
                                  style: TextStyle(
                                      fontSize: DefaultProperties.fontSize3)),
                            ),
                            Container(
                              padding: EdgeInsets.all(
                                  DefaultProperties.defaultPadding),
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom:
                                    BorderSide(width: 1.0, color: Colors.black),
                              )),
                              child: Text("${item.hightLeft.toString()}",
                                  style: TextStyle(
                                      fontSize: DefaultProperties.fontSize3)),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(
                                  DefaultProperties.defaultPadding),
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom:
                                    BorderSide(width: 1.0, color: Colors.black),
                              )),
                              child: Text("Wert"),
                            ),
                            Container(
                              padding: EdgeInsets.all(
                                  DefaultProperties.defaultPadding),
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom:
                                    BorderSide(width: 1.0, color: Colors.black),
                              )),
                              child: Text("Sphäre",
                                  style: TextStyle(
                                      fontSize: DefaultProperties.fontSize3)),
                            ),
                            Container(
                              padding: EdgeInsets.all(
                                  DefaultProperties.defaultPadding),
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom:
                                    BorderSide(width: 1.0, color: Colors.black),
                              )),
                              child: Text("Zylinderwert",
                                  style: TextStyle(
                                      fontSize: DefaultProperties.fontSize3)),
                            ),
                            Container(
                              padding: EdgeInsets.all(
                                  DefaultProperties.defaultPadding),
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom:
                                    BorderSide(width: 1.0, color: Colors.black),
                              )),
                              child: Text("Pupillendistanz",
                                  style: TextStyle(
                                      fontSize: DefaultProperties.fontSize3)),
                            ),
                            Container(
                              padding: EdgeInsets.all(
                                  DefaultProperties.defaultPadding),
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom:
                                    BorderSide(width: 1.0, color: Colors.black),
                              )),
                              child: Text("Höhe",
                                  style: TextStyle(
                                      fontSize: DefaultProperties.fontSize3)),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(
                                  DefaultProperties.defaultPadding),
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom:
                                    BorderSide(width: 1.0, color: Colors.black),
                              )),
                              child: Text("Rechtes Auge"),
                            ),
                            Container(
                              padding: EdgeInsets.all(
                                  DefaultProperties.defaultPadding),
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom:
                                    BorderSide(width: 1.0, color: Colors.black),
                              )),
                              child: Text("${item.sphRight.toString()}",
                                  style: TextStyle(
                                      fontSize: DefaultProperties.fontSize3)),
                            ),
                            Container(
                              padding: EdgeInsets.all(
                                  DefaultProperties.defaultPadding),
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom:
                                    BorderSide(width: 1.0, color: Colors.black),
                              )),
                              child: Text("${item.cylRight.toString()}",
                                  style: TextStyle(
                                      fontSize: DefaultProperties.fontSize3)),
                            ),
                            Container(
                              padding: EdgeInsets.all(
                                  DefaultProperties.defaultPadding),
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom:
                                    BorderSide(width: 1.0, color: Colors.black),
                              )),
                              child: Text("${item.pdRight.toString()}",
                                  style: TextStyle(
                                      fontSize: DefaultProperties.fontSize3)),
                            ),
                            Container(
                              padding: EdgeInsets.all(
                                  DefaultProperties.defaultPadding),
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom:
                                    BorderSide(width: 1.0, color: Colors.black),
                              )),
                              child: Text("${item.hightRight.toString()}",
                                  style: TextStyle(
                                      fontSize: DefaultProperties.fontSize3)),
                            ),
                          ],
                        ),
                      ],
                    )
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(
                                  DefaultProperties.defaultPadding),
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom:
                                    BorderSide(width: 1.0, color: Colors.black),
                              )),
                              child: Text("Linkes Glas"),
                            ),
                            Container(
                              padding: EdgeInsets.all(
                                  DefaultProperties.defaultPadding),
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom:
                                    BorderSide(width: 1.0, color: Colors.black),
                              )),
                              child: Text("${item.axisLeft.toString()}",
                                  style: TextStyle(
                                      fontSize: DefaultProperties.fontSize3)),
                            ),
                            Container(
                              padding: EdgeInsets.all(
                                  DefaultProperties.defaultPadding),
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom:
                                    BorderSide(width: 1.0, color: Colors.black),
                              )),
                              child: Text("${item.addLeft.toString()}",
                                  style: TextStyle(
                                      fontSize: DefaultProperties.fontSize3)),
                            ),
                            Container(
                              padding: EdgeInsets.all(
                                  DefaultProperties.defaultPadding),
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom:
                                    BorderSide(width: 1.0, color: Colors.black),
                              )),
                              child: Text("${item.prism1Left.toString()}",
                                  style: TextStyle(
                                      fontSize: DefaultProperties.fontSize3)),
                            ),
                            Container(
                              padding: EdgeInsets.all(
                                  DefaultProperties.defaultPadding),
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom:
                                    BorderSide(width: 1.0, color: Colors.black),
                              )),
                              child: Text("${item.basis1Left.toString()}",
                                  style: TextStyle(
                                      fontSize: DefaultProperties.fontSize3)),
                            ),
                            Container(
                              padding: EdgeInsets.all(
                                  DefaultProperties.defaultPadding),
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom:
                                    BorderSide(width: 1.0, color: Colors.black),
                              )),
                              child: Text("${item.prism2Left.toString()}",
                                  style: TextStyle(
                                      fontSize: DefaultProperties.fontSize3)),
                            ),
                            Container(
                              padding: EdgeInsets.all(
                                  DefaultProperties.defaultPadding),
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom:
                                    BorderSide(width: 1.0, color: Colors.black),
                              )),
                              child: Text("${item.basis2Left.toString()}",
                                  style: TextStyle(
                                      fontSize: DefaultProperties.fontSize3)),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(
                                  DefaultProperties.defaultPadding),
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom:
                                    BorderSide(width: 1.0, color: Colors.black),
                              )),
                              child: Text("Wert"),
                            ),
                            Container(
                              padding: EdgeInsets.all(
                                  DefaultProperties.defaultPadding),
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom:
                                    BorderSide(width: 1.0, color: Colors.black),
                              )),
                              child: Text("Achse",
                                  style: TextStyle(
                                      fontSize: DefaultProperties.fontSize3)),
                            ),
                            Container(
                              padding: EdgeInsets.all(
                                  DefaultProperties.defaultPadding),
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom:
                                    BorderSide(width: 1.0, color: Colors.black),
                              )),
                              child: Text("ADD-Wert",
                                  style: TextStyle(
                                      fontSize: DefaultProperties.fontSize3)),
                            ),
                            Container(
                              padding: EdgeInsets.all(
                                  DefaultProperties.defaultPadding),
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom:
                                    BorderSide(width: 1.0, color: Colors.black),
                              )),
                              child: Text("Prisma-1",
                                  style: TextStyle(
                                      fontSize: DefaultProperties.fontSize3)),
                            ),
                            Container(
                              padding: EdgeInsets.all(
                                  DefaultProperties.defaultPadding),
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom:
                                    BorderSide(width: 1.0, color: Colors.black),
                              )),
                              child: Text("Basis-1",
                                  style: TextStyle(
                                      fontSize: DefaultProperties.fontSize3)),
                            ),
                            Container(
                              padding: EdgeInsets.all(
                                  DefaultProperties.defaultPadding),
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom:
                                    BorderSide(width: 1.0, color: Colors.black),
                              )),
                              child: Text("Prisma-2",
                                  style: TextStyle(
                                      fontSize: DefaultProperties.fontSize3)),
                            ),
                            Container(
                              padding: EdgeInsets.all(
                                  DefaultProperties.defaultPadding),
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom:
                                    BorderSide(width: 1.0, color: Colors.black),
                              )),
                              child: Text("Basis-2",
                                  style: TextStyle(
                                      fontSize: DefaultProperties.fontSize3)),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(
                                  DefaultProperties.defaultPadding),
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom:
                                    BorderSide(width: 1.0, color: Colors.black),
                              )),
                              child: Text("Rechtes Glas"),
                            ),
                            Container(
                              padding: EdgeInsets.all(
                                  DefaultProperties.defaultPadding),
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom:
                                    BorderSide(width: 1.0, color: Colors.black),
                              )),
                              child: Text("${item.axisRight.toString()}",
                                  style: TextStyle(
                                      fontSize: DefaultProperties.fontSize3)),
                            ),
                            Container(
                              padding: EdgeInsets.all(
                                  DefaultProperties.defaultPadding),
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom:
                                    BorderSide(width: 1.0, color: Colors.black),
                              )),
                              child: Text("${item.addRight.toString()}",
                                  style: TextStyle(
                                      fontSize: DefaultProperties.fontSize3)),
                            ),
                            Container(
                              padding: EdgeInsets.all(
                                  DefaultProperties.defaultPadding),
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom:
                                    BorderSide(width: 1.0, color: Colors.black),
                              )),
                              child: Text("${item.prism1Right.toString()}",
                                  style: TextStyle(
                                      fontSize: DefaultProperties.fontSize3)),
                            ),
                            Container(
                              padding: EdgeInsets.all(
                                  DefaultProperties.defaultPadding),
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom:
                                    BorderSide(width: 1.0, color: Colors.black),
                              )),
                              child: Text("${item.basis1Right.toString()}",
                                  style: TextStyle(
                                      fontSize: DefaultProperties.fontSize3)),
                            ),
                            Container(
                              padding: EdgeInsets.all(
                                  DefaultProperties.defaultPadding),
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom:
                                    BorderSide(width: 1.0, color: Colors.black),
                              )),
                              child: Text("${item.prism2Right.toString()}",
                                  style: TextStyle(
                                      fontSize: DefaultProperties.fontSize3)),
                            ),
                            Container(
                              padding: EdgeInsets.all(
                                  DefaultProperties.defaultPadding),
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom:
                                    BorderSide(width: 1.0, color: Colors.black),
                              )),
                              child: Text("${item.basis2Right.toString()}",
                                  style: TextStyle(
                                      fontSize: DefaultProperties.fontSize3)),
                            ),
                          ],
                        ),
                      ],
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
