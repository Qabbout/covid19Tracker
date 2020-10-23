import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LastUpdateDateFormatter {
  LastUpdateDateFormatter({@required this.lastUpdate});
  final DateTime lastUpdate;

  String lastUpdatedStatusText() {
    if (lastUpdate != null) {
      final formatter = DateFormat.yMd().add_Hms();
      final formatted = formatter.format(lastUpdate);
      return "Last updated: $formatted";
    }
    return '';
  }
}

class LastUpdate extends StatelessWidget {
  const LastUpdate({Key key, @required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
    );
  }
}
