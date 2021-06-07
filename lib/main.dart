import 'package:dust_app/bloc/air_bloc.dart';
import 'package:dust_app/models/air_result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}
final airBloc =AirBloc();
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






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<AirResult>(
          stream: airBloc.airResult,
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return _buildbody(snapshot.data);
            }else{
              return CircularProgressIndicator();
            }
          }
        ),
      ),
    );
  }

  Widget _buildbody(AirResult _result) {
    return Padding(
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
                        onPressed: () {
                          airBloc.fetch();
                        },
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
