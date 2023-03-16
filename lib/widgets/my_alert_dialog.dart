
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAlertDialog {

  Widget getDialog(BuildContext context){
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        const Text('About the questions...'),
        TextButton(
            onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('About the questions'),
                  content: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "You’ll be asked 2 vehicle safety questions during your car driving test.",
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "The examiner will ask you one:",
                      ),
                      Row(
                        children: const [
                          Text("● "),
                          // Text(
                          //   "\u2022",
                          //   style: TextStyle(
                          //       fontSize: 30,
                          //       color: Colors.black),
                          // ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              "‘tell me’ question (where you explain how you’d carry out a safety task) at the start of your test, before you start driving",
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: const [
                          Text("● "),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              "‘show me’ question (where you show how you’d carry out a safety task) while you’re driving",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Close'),
                      child: const Text('Close'),
                    )
                  ],
                )),
            child: const Text('Show More')),
      ],
    );
  }

}