import 'dart:async';
import 'package:covid/generated/l10n.dart';
import 'package:covid/ui/assets/colors.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';

class LicencesPage extends StatelessWidget {
  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/licence.txt');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Covid19Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          iconTheme: Theme.of(context).iconTheme.copyWith(
                color: Covid19Colors.white,
              ),
          backgroundColor: Covid19Colors.blue,
          title: Text(
            S.of(context).licencesPageTitle.toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .title
                .copyWith(color: Covid19Colors.white),
          ),
        ),
        body: FutureBuilder(
          future: loadAsset(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data);
            }
            return Text("");
          },
        ));
  }
}
