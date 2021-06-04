import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        primarySwatch: Colors.blue,
      ),
      home: Main(),
    );
  }
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '현재 위치 미세먼지',
                style: TextStyle(fontSize: 30.0),
              ),
              Card(
                child: Column(
                  children: <Widget>[
                    Container(

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text('얼굴'),
                          Text(
                            '80',
                            style: TextStyle(fontSize: 50),
                          ),
                          Text(
                            '보통',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      color: Colors.yellow,
                      padding: const EdgeInsets.all(8.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Row(
                            children: [
                              Text('얼굴'),
                              Text('얼굴'),
                            ],
                          ),
                          Text('80'),
                          Text('보통'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                width: 100,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
