import 'dart:io';
import 'package:covid19/app/repositories/data_respository.dart';
import 'package:covid19/app/repositories/endpoints_data.dart';
import 'package:covid19/app/services/api.dart';
import 'package:covid19/app/ui/endpoint_card.dart';
import 'package:covid19/app/ui/last_update.dart';
import 'package:covid19/app/ui/show_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  EndpointsData _endpointsData;

  @override
  void initState() {
    super.initState();
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    _endpointsData = dataRepository.getAllEndpointsCachedData();
    _updateData();
  }

  Future<void> _updateData() async {
    try {
      final dataRepository =
          Provider.of<DataRepository>(context, listen: false);
      final endpointsData = await dataRepository.getAllEndpointsData();
      setState(() => _endpointsData = endpointsData);
    } on SocketException catch (_) {
      showAlertDialog(
          context: context,
          title: 'Connection Error',
          content: "Couldn't retrieve data. Please try again later.",
          defaultActionText: 'Ok');
    } catch (_) {
      showAlertDialog(
          context: context,
          title: "Unknown Error",
          content: "Please contact support or try again later",
          defaultActionText: "Ok");
    }
  }

  @override
  Widget build(BuildContext context) {
    final formatter = LastUpdateDateFormatter(
      lastUpdate: _endpointsData != null
          ? _endpointsData.values[Endpoint.cases]?.date
          : null,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Covid19 Tracker"),
      ),
      body: RefreshIndicator(
        onRefresh: _updateData,
        child: ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            LastUpdate(
              text: formatter.lastUpdatedStatusText(),
            ),
            for (var endpoint in Endpoint.values)
              EndpointCard(
                endpoint: endpoint,
                value: _endpointsData != null
                    ? _endpointsData.values[endpoint]?.value
                    : null,
              )
          ],
        ),
      ),
    );
  }
}
