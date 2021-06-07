import 'package:dust_app/models/AirResult.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  const Main({Key key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  AirResult _result;

  Future<AirResult> fetchData() async {
    var uri = Uri.parse(
        'http://api.airvisual.com/v2/nearest_city?key=4808c918-ed12-4b14-8551-385c277a7d73');
    var response = await http.get(uri);

    AirResult result = AirResult.fromJson(json.decode(response.body));
    return result;
  }

  @override
  void initState() {
    super.initState();
    fetchData().then((airResult) {
      setState(() {
        _result = airResult;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _result == null
            ? CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '현재 위치 미세먼지',
                        style: TextStyle(fontSize: 30.0),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Card(
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Text('얼굴'),

                                  Text(
                                    '${_result.data.current.pollution.aqius}',
                                    style: TextStyle(fontSize: 50),
                                  ),
                                  Text(
                                    getString(_result),
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                              color:  getColor(_result),
                              padding: const EdgeInsets.all(8.0),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Image.network('https://airvisual.com/images/${_result.data.current.weather.ic}.png', width: 32, height: 32,),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Text(
                                          '${_result.data.current.weather.tp}'),
                                    ],
                                  ),
                                  Text(
                                      '습도 ${_result.data.current.weather.hu}%'),
                                  Text(
                                      '풍속 ${_result.data.current.weather.ws}m/s'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16,
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
      ),
    );
  }

  Color getColor(AirResult result) {
    if(result.data.current.pollution.aqius <= 50){
      return Colors.greenAccent;
    } else if(result.data.current.pollution.aqius <= 100){
      return Colors.yellow;
    }else if(result.data.current.pollution.aqius <= 150){
      return Colors.orange;
    }else{
      return Colors.red;
    }

  }

  String getString(AirResult result) {
    if(result.data.current.pollution.aqius <= 50){
      return '좋음';
    } else if(result.data.current.pollution.aqius <= 100){
      return '보통';
    }else if(result.data.current.pollution.aqius <= 150){
      return '나쁨';
    }else{
      return '최악';
    }
  }
}
