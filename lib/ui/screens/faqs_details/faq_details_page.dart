import 'package:covid/model/faq_model.dart';
import 'package:covid/resources/style/text_styles.dart';
import 'package:covid/ui/assets/colors.dart';
import 'package:covid/utils/launch_url.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;

class FaqsDetails extends StatefulWidget {
  /// Faqs page view
  FaqsDetails({Key key, this.title, this.faqs}) : super(key: key);

  /// Title of the page view
  final String title;

  final List<FaqModel> faqs;

  @override
  _FaqsPageState createState() => _FaqsPageState();
}

class _FaqsPageState extends State<FaqsDetails> {
  /// ScrollController for changing the scroll position
  final ScrollController scrollController = ScrollController();

  /// Store the rows index key for calculating the height dynamically
  Map<int, GlobalKey> expands = <int, GlobalKey>{};

  @override
  Widget build(BuildContext context) {
    /// TODO: in case of slow connection show loading?

    /// Gets all faqs from the Provider or the Modal Route arguments
    ///
    /// If pushing from home and faqs have initial data
    /// In case of no initial data reverts to fetch faqs
    /// and update with the Provider

    return Scaffold(
      appBar: AppBar(
        iconTheme:
            Theme.of(context).iconTheme.copyWith(color: Covid19Colors.white),
        title: Text(
          widget.title.toUpperCase(),
          style: TextStyles.h2(color: Covid19Colors.white),
        ),
        backgroundColor: Covid19Colors.blue,
        elevation: 0.0,
      ),
      body: Scrollbar(
        child: Container(
          child: ListView.builder(
            controller: scrollController,
            itemCount: widget.faqs != null ? widget.faqs.length : 0,
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
                              iconColor: Covid19Colors.green,
                            ),
                            header: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                widget.faqs[index].question,
                                style: Theme.of(context).textTheme.display3.copyWith(
                                  color: Covid19Colors.green, letterSpacing: 0.2
                                ),
                              )
                            ),
                            expanded: Html(
                              data: widget.faqs[index].answer.replaceAll("\\n", ""),
                              backgroundColor: Colors.white,
                              onLinkTap: launchURL,
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
        )
      )
    );
  }
}
