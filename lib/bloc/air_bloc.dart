import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dust_app/models/air_result.dart';
import 'package:rxdart/rxdart.dart';

class AirBloc {
  final _airSubject = BehaviorSubject<AirResult>();

  AirBloc() {
    fetch();
  }

  Future<AirResult> fetchData() async {
    var uri = Uri.parse(
        'http://api.airvisual.com/v2/nearest_city?key=4808c918-ed12-4b14-8551-385c277a7d73');
    var response = await http.get(uri);

    AirResult result = AirResult.fromJson(json.decode(response.body));
    return result;
  }

  void fetch() async {
    print('refresh!');
    var airResult = await fetchData();
    _airSubject.add(airResult);
  }

  Stream<AirResult> get airResult => _airSubject.stream;


}
