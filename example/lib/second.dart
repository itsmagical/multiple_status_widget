
import 'package:flutter/material.dart';
import 'package:multiple_status_widget/multiple_status_widget.dart';
import 'package:multiple_status_widget/status_controller.dart';

class Second extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _SecondState();
  }

}

class _SecondState extends State<Second> {

  StatusController controller;

  @override
  void initState() {
    controller = StatusController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('second'),
        actions: [
          IconButton(icon: Icon(Icons.add), onPressed: () {
            controller.setLoading();
            Future.delayed(
              Duration(seconds: 3),
                () {
                  controller.setError();
                }
            );
          })
        ],
      ),
      body: Container(
        child: MultipleStatusWidget(
          controller: controller,
            retryingCallback: () {
//              controller.setLoading();
            },
            child: Container(
              child: Text('content'),
            ),
        ),
      ),
    );
  }

}