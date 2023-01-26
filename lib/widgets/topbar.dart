import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weatherbee/api/currentapicall.dart';

class Topbar extends StatelessWidget {
  Topbar(
      {Key key,
      this.currentCity,
      this.callback,
      this.currentunit,
      this.callback2})
      : super(key: key);
  final String currentCity;
  final String currentunit;
  final Function callback;
  final Function callback2;
  String capitalize(String value) {
    var result = value[0].toUpperCase();
    bool cap = true;
    for (int i = 1; i < value.length; i++) {
      if (value[i - 1] == " " && cap == true) {
        result = result + value[i].toUpperCase();
      } else {
        result = result + value[i];
        cap = false;
      }
    }
    return result;
  }

  String controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(90.0),
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
            child: RawMaterialButton(
              fillColor: Colors.white,
              shape: const CircleBorder(),
              onPressed: () => {
                //show dialogue with a switch from metric to imperial
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Change Unit"),
                      content: StatefulBuilder(
                        builder: (context, setState) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              RadioListTile(
                                title: const Text("Metric"),
                                value: "metric",
                                groupValue: currentunit,
                                onChanged: (value) {
                                  Navigator.pop(context, callback2(value));
                                },
                              ),
                              RadioListTile(
                                title: const Text("Imperial"),
                                value: "imperial",
                                groupValue: currentunit,
                                onChanged: (value) {
                                  Navigator.pop(context, callback2(value));
                                },
                              ),
                            ],
                          );
                        },
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel"),
                        ),
                      ],
                    );
                  },
                ),
              },
              child: const Icon(
                Icons.tune,
                size: 35,
              ),
            ),
          ),
          Row(
            children: [
              const Icon(
                Icons.location_pin,
                color: Colors.red,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                capitalize(currentCity),
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(90.0),
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
            child: RawMaterialButton(
              fillColor: Colors.white,
              shape: const CircleBorder(),
              onPressed: () => {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Enter City"),
                      content: TextField(
                        onChanged: (value) {
                          controller = value;
                        },
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () async {
                            bool x;
                            if (controller != null) {
                              x = await checkCityExists(
                                  controller, currentunit);
                              if ((x == false)) {
                                Fluttertoast.showToast(
                                    msg:
                                        "City changed to ${capitalize(controller)}",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: const Color.fromARGB(
                                        255, 106, 106, 106),
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                Navigator.pop(context, callback(controller));
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Please enter a valid city name",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: const Color.fromARGB(
                                        255, 106, 106, 106),
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Please enter a valid city name",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor:
                                      const Color.fromARGB(255, 106, 106, 106),
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          },
                          child: const Text("Ok"),
                        ),
                      ],
                    );
                  },
                ),
              },
              child: const Icon(
                Icons.search,
                size: 35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
