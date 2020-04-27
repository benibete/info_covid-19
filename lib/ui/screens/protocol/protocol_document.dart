import 'dart:async';
import 'dart:io';

import 'package:covid/ui/assets/dimensions.dart';
import 'package:covid/ui/widgets/loading.dart';
import 'package:covid/ui/assets/colors.dart';
import 'package:covid/resources/style/text_styles.dart';
import 'package:covid/ui/screens/protocol/component/PDFViewer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class ProtocolDocumentPage extends StatefulWidget {
  ProtocolDocumentPage({Key key, this.url}) : super(key: key);

  final String url;

  @override
  _ProtocolDocumentPageState createState() => _ProtocolDocumentPageState();
}

class _ProtocolDocumentPageState extends State<ProtocolDocumentPage> {
  String pathPDF = '';
  bool loading = true;

  @override
  void initState() {
    super.initState();
    createFileOfPdfUrl().then((f) {
      if(this.mounted)
      {
        setState(() {
          loading = false;
          pathPDF = f.path;
          print(pathPDF);
        });
      }
    });
  }

  Future<File> createFileOfPdfUrl() async {
    String _url = widget.url;
    final filename = _url.substring(_url.lastIndexOf('/') + 1);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    if (!await file.exists()) 
    {
      var request = await HttpClient().getUrl(Uri.parse(_url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      await file.writeAsBytes(bytes);
    } 
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme:
            Theme.of(context).iconTheme.copyWith(color: Covid19Colors.white),
        title: Text(
          'DOKUMEN PROTOKOL',
          style: TextStyles.h2(color: Covid19Colors.white),
        ),
      ),
      body: SafeArea(
        child: loading ? Loading() :
          PDFViewer(
            appBar: AppBar(
              iconTheme:
                  Theme.of(context).iconTheme.copyWith(color: Covid19Colors.white),
              title: Text(
                'DOKUMEN PROTOKOL',
                style: TextStyles.h2(color: Covid19Colors.white),
              ),
            ),
            path: pathPDF,
            paddingTop: MediaQuery.of(context).padding.top,
          ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}