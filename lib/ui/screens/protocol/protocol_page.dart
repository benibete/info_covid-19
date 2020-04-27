import 'package:covid/bloc/app_bloc.dart';
import 'package:covid/bloc/base_bloc.dart';
import 'package:covid/model/protocol_model.dart';
import 'package:covid/providers/protocol_provider.dart';
import 'package:covid/resources/constants.dart';
import 'package:covid/resources/style/text_styles.dart';
import 'package:covid/ui/assets/colors.dart';
import 'package:covid/ui/core/base_stream_service_screen_page.dart';
import 'package:covid/ui/widgets/loading.dart';
import 'package:covid/ui/widgets/card_border_arrow.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;

class ProtocolPage extends BasePage {
  /// Faqs page view
  ProtocolPage({Key key, this.title}) : super(key: key);

  /// Title of the page view
  final String title;

  @override
  _ProtocolPageState createState() => _ProtocolPageState();
}

class _ProtocolPageState extends BaseState<ProtocolPage, AppBloc> {
  /// For the initial list of faqs
  List<ProtocolModel> _protocol = [];

  @override
  Widget build(BuildContext context) {
    /// Gets all faqs from the Provider or the Modal Route arguments
    ///
    /// If pushing from home and faqs have initial data
    /// In case of no initial data reverts to fetch faqs
    /// and update with the Provider
    _protocol = Provider.of<ProtocolProvider>(context).protocol ??
        ModalRoute.of(context).settings.arguments;

    final ScrollController scrollController = ScrollController();

    /// Check if have any data to present, if not show [CircularProgressIndicator]
    /// while wait for data
    var hasData = _protocol != null && _protocol.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        iconTheme:
            Theme.of(context).iconTheme.copyWith(color: Covid19Colors.white),
        title: Text(
          widget.title.toUpperCase(),
          style: TextStyles.h2(color: Covid19Colors.white),
        ),
      ),
      body: Container(
        child: hasData
            ? ListView.builder(
              controller: scrollController,
              itemCount: _protocol != null ? _protocol.length : 0,
              itemBuilder: (context, index) {
                return ExpandableNotifier(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Card(
                      color: Covid19Colors.white,
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: <Widget>[
                          ScrollOnExpand(
                            scrollOnExpand: true,
                            scrollOnCollapse: false,
                            child: ExpandablePanel(
                              theme: const ExpandableThemeData(
                                headerAlignment: ExpandablePanelHeaderAlignment.center,
                                tapBodyToCollapse: true,
                                iconColor: Covid19Colors.darkGrey,
                              ),
                              header: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  _protocol[index].title,
                                  style: Theme.of(context).textTheme.display3.copyWith(
                                    color: Covid19Colors.darkGrey, letterSpacing: 0.2
                                  ),
                                )
                              ),
                              expanded: Column(
                                children: <Widget>[
                                  Html(
                                    data: _protocol[index].description.replaceAll("\\n", ""),
                                    backgroundColor: Colors.white,
                                    defaultTextStyle: Theme.of(context).textTheme.body1,
                                    linkStyle: Theme.of(context)
                                        .textTheme
                                        .body1
                                        .copyWith(color: Theme.of(context).primaryColor),
                                    customTextStyle: (dom.Node node, TextStyle baseStyle) {
                                      if (node is dom.Element) {
                                        switch (node.localName) {
                                          case "b":
                                            return TextStyles.subtitle(
                                              color: Covid19Colors.darkGrey,
                                            );
                                        }
                                      }
                                      return baseStyle;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  CardBorderArrow(
                                    text: 'Lihat Dokumen',
                                    textColor: Covid19Colors.green,
                                    borderColor: Covid19Colors.lightGrey,
                                    callback: () {
                                      Navigator.of(context).pushNamed(
                                        routeProtocolDocument,
                                        arguments: _protocol[index].url
                                      );
                                    },
                                  )
                                ],
                              ),
                              builder: (_, collapsed, expanded) {
                                return Padding(
                                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                                  child: Expandable(
                                    collapsed: collapsed,
                                    expanded: expanded,
                                    theme: const ExpandableThemeData(crossFadePoint: 0),
                                  ),
                                );
                              },
                            ),
                          )
                        ]
                      ),
                    ),
                  ),
                );
              }
            )
            : const Loading(),
      ),
    );
  }

  @override
  void initBloc(AppBloc bloc) {
    /// In case [_faqs] is null then fetch if again

    var provider = Provider.of<ProtocolProvider>(context);

    if (_protocol == null ||
        provider.protocol == null ||
        (provider.protocol != null && provider.protocol.isEmpty)) {
      bloc.getProtocol();
    }
  }

  @override
  Stream<ResultStream> get onStateListener => bloc.onListener;

  @override
  void onStateResultListener(ResultStream result) {
    if (result is ProtocolResultStream) {
      /// Updates faqs list on the provider
      Provider.of<ProtocolProvider>(context, listen: false)
          .setProtocol(result.model);

      /// Updates videos list
      _protocol = result.model;
    }
  }
}
