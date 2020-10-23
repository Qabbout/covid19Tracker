import 'package:covid19/app/services/api.dart';
import 'package:covid19/app/services/endpoint_data.dart';
import 'package:flutter/material.dart';

class EndpointsData {
  EndpointsData({@required this.values}) ;
  final Map<Endpoint, EndpointData> values;

  EndpointData get cases => values[Endpoint.cases];
  EndpointData get casesSuspected => values[Endpoint.casesSuspected];
  EndpointData get casesConfirmed => values[Endpoint.casesConfirmed];
  EndpointData get deaths => values[Endpoint.deaths];
  EndpointData get recovered => values[Endpoint.recovered];

  @override
  String toString() =>
      'cases: $cases, suspeceted: $casesSuspected, confirmed: $casesConfirmed, deaths: $deaths, recovered: $recovered';
}
