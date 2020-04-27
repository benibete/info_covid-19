import 'package:covid/bloc/app_bloc.dart';
import 'package:covid/bloc/base_bloc.dart';
import 'package:covid/model/video_model.dart';
import 'package:covid/providers/videos_provider.dart';
import 'package:covid/resources/constants.dart';
import 'package:covid/resources/style/text_styles.dart';
import 'package:covid/ui/assets/colors.dart';
import 'package:covid/ui/core/base_stream_service_screen_page.dart';
import 'package:covid/ui/widgets/card_video.dart';
import 'package:covid/ui/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VideosPage extends BasePage {
  /// Faqs page view
  VideosPage({Key key, this.title}) : super(key: key);

  /// Title of the page view
  final String title;

  @override
  _VideosPageState createState() => _VideosPageState();
}

class _VideosPageState extends BaseState<VideosPage, AppBloc> {
  /// For the initial list of faqs
  List<VideoModel> _videos = [];

  @override
  Widget build(BuildContext context) {
    /// Gets all faqs from the Provider or the Modal Route arguments
    ///
    /// If pushing from home and faqs have initial data
    /// In case of no initial data reverts to fetch faqs
    /// and update with the Provider
    _videos = Provider.of<VideosProvider>(context).videos ??
        ModalRoute.of(context).settings.arguments;

    /// Check if have any data to present, if not show [CircularProgressIndicator]
    /// while wait for data
    var hasData = _videos != null && _videos.isNotEmpty;

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
            ? ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => CardVideo(
                      backgroundUrl: _videos[index].getVideoThumbnail(),
                      label: _videos[index].postTitle,
                      onPressed: () => Navigator.of(context).pushNamed(
                          routeVideoPlayer,
                          arguments: _videos[index].getVideoId()),
                      labelAlignment: Alignment.topLeft,
                    ),
                separatorBuilder: (_, __) {
                  return const SizedBox(
                    height: 12.0,
                  );
                },
                itemCount: _videos != null ? _videos.length : 0)
            : const Loading(),
      ),
    );
  }

  @override
  void initBloc(AppBloc bloc) {
    /// In case [_faqs] is null then fetch if again

    var provider = Provider.of<VideosProvider>(context);

    if (_videos == null ||
        provider.videos == null ||
        (provider.videos != null && provider.videos.isEmpty)) {
      bloc.getVideos();
    }
  }

  @override
  Stream<ResultStream> get onStateListener => bloc.onListener;

  @override
  void onStateResultListener(ResultStream result) {
    if (result is VideosResultStream) {
      /// Updates faqs list on the provider
      Provider.of<VideosProvider>(context, listen: false)
          .setVideos(result.model);

      /// Updates videos list
      _videos = result.model;
    }
  }
}
