// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:dust_app/models/air_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:dust_app/main.dart';
import 'dart:convert';


void main() {
  test('http connection test',() async{
    var uri =Uri.parse('http://api.airvisual.com/v2/nearest_city?key=4808c918-ed12-4b14-8551-385c277a7d73');
    var response = await http.get(uri);

    expect(response.statusCode, 200);

    AirResult result = AirResult.fromJson(json.decode(response.body));
    expect(result.status, 'success');

  });
}
