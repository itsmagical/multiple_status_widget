import 'package:example/second.dart';
import 'package:flutter/material.dart';
import 'package:multiple_status_widget/multiple_status_config.dart';
import 'package:multiple_status_widget/multiple_status_widget.dart';
import 'package:multiple_status_widget/status_controller.dart';
import 'package:multiple_status_widget/status_widget/empty_status_widget.dart';
import 'package:multiple_status_widget/status_widget/error_status_widget.dart';
import 'package:multiple_status_widget/status_widget/loading_status_widget.dart';
import 'package:multiple_status_widget/status_widget_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  StatusController controller;

  @override
  void initState() {
    controller = StatusController();

    MultipleStatusConfig.instance
        .setStatusWidgetProvider(
        StatusWidgetProvider(
            getLoadingWidget: (handler) {
              return LoadingStatusWidget(context: context);
            },
            getErrorWidget: (handler) {
              return ErrorStatusWidget(handler);
            },
            getEmptyWidget: (handler) {
              return EmptyStatusWidget();
            }
        )
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(icon: Icon(Icons.add), onPressed: () {

//            bool canPop = Navigator.canPop(context);
//            Navigator.of(context, rootNavigator: true).pop();

            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Second();
            }));
          })
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: MultipleStatusWidget(
          controller: controller,
            child: Text('content')
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.setLoading();

          Future.delayed(
            Duration(seconds: 3),
            () {
              controller.setEmpty();
            }
          );
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
