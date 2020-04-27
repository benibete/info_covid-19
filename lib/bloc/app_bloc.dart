import 'dart:async';

import 'package:covid/model/api_response_model.dart';
import 'package:covid/model/faq_category_model.dart';
import 'package:covid/model/faq_model.dart';
import 'package:covid/model/post_type.dart';
import 'package:covid/model/slider_model.dart';
import 'package:covid/model/stats_model.dart';
import 'package:covid/model/video_model.dart';
import 'package:covid/model/detail_stats_model.dart';
import 'package:covid/model/protocol_model.dart';
import 'package:covid/services/api_service.dart';
import 'package:covid/ui/app.dart';
import 'package:rxdart/subjects.dart';

import 'base_bloc.dart';

class AppBloc implements Bloc {
  static const String _tag = '.AppBloc';

  StreamController onStream = BehaviorSubject<ResultStream>();

  AppBloc() {
    APIService.api.init();
  }

  void getStats() async {
    final APIResponse response = await APIService.api.getStats();
    if (response.isOk) {
      logger.i('[$_tag] everything went ok!');

      onStream.sink.add(StatsResultStream(
          model: StatsModel.fromJson(response.data),
          state: StateStream.success));
    } else {
      logger.e('[$_tag] oops...');
      // throw some error
      onStream.sink
          .add(StatsResultStream(model: null, state: StateStream.fail));
    }
  }

  void getSlider() async {
    final postType = PostType(PostTypes.slider);

    var results =
        await getPosts<SliderModel>(postType, cacheKey: "SliderModel");

    onStream.sink.add(
      SliderResultStream(
          model: results,
          state: results != null ? StateStream.success : StateStream.fail),
    );
  }

  void getVideos() async {
    final postType = PostType(PostTypes.videos);

    var results = await getPosts<VideoModel>(postType, cacheKey: "VideoModel");

    onStream.sink.add(VideosResultStream(
        model: results,
        state: results != null ? StateStream.success : StateStream.fail));
  }

  Future<List<FaqModel>> getFaqsDetails(int id) async {
    final postType = PostType(PostTypes.faq);

    return getPosts<FaqModel>(postType, cacheKey: "FaqModel", id: id);
  }

  void getFaqCategories() async {
    final postType = PostType(PostTypes.faqCategories);

    var results = await getPosts<FaqCategoryModel>(postType,
        cacheKey: "FaqCategoryModel");

    // fetch all categories
    if (results != null) {
      final map = <int, List<FaqModel>>{};
      for (var result in results) {
        logger.i("Getting faqs for: ${result.categoryId}");
        map[result.categoryId] = await getFaqsDetails(result.categoryId);
      }

      logger.i("FAQS: $map");

      onStream.sink.add(
        FaqResultStream(
          model: map,
          state: map.isNotEmpty ? StateStream.success : StateStream.fail,
        ),
      );
    } else {
      onStream.sink.add(
        FaqResultStream(
          model: null,
          state: StateStream.fail,
        ),
      );
    }

    onStream.sink.add(
      FaqCategoryResultStream(
          model: results,
          state: results != null ? StateStream.success : StateStream.fail),
    );
  }

  void getDetailStats() async {
    final postType = PostType(PostTypes.detailStats);

    var results = await getPosts<DetailStatsModel>(postType, cacheKey: "DetailStats");

    onStream.sink.add(DetailStatsResultStream(
        model: results,
        state: results != null ? StateStream.success : StateStream.fail));
  }

  void getProtocol() async {
    final postType = PostType(PostTypes.protocol);

    var results = await getPosts<ProtocolModel>(postType, cacheKey: "Protocol");

    onStream.sink.add(ProtocolResultStream(
        model: results,
        state: results != null ? StateStream.success : StateStream.fail));
  }

  Future<List<T>> getPosts<T>(PostType postType,
      {int id, bool cache = true, String cacheKey = "key"}) async {
    final APIResponse response =
        await APIService.api.getPosts<T>(postType, id: id);
    if (response.isOk) {
      logger.i('[$_tag] everything went ok!');

      /// Cast the response to Map key -> value
      final data = response.data.cast<Map<String, dynamic>>();

      var results = parseData<T>(postType, data);

      if (cache) {
        /// TODO: cache results
      }

      return results;
    } else {
      logger.e('[$_tag] oops...');
      // throw some error
    }
    return null;
  }

  /// Parse the json map into each corresponding Post Model
  ///
  /// Both [postType] and [data] are mandatory
  ///
  /// Then returns the parsed data
  parseData<T>(PostType postType, dynamic data) {
    switch (postType.postTypes) {
      case PostTypes.slider:

        /// Data converted to a Map now we need to convert each entry
        return data.map<T>((json) =>

            /// into a [SliderModel] instance and save into a List
            SliderModel.fromJson(json)).toList();
      case PostTypes.faqCategories:

        /// Data converted to a Map now we need to convert each entry
        return data.map<T>((json) =>

            /// into a [FaqCategoryModel] instance and save into a List
            FaqCategoryModel.fromJson(json)).toList();

        break;

      case PostTypes.faq:

        /// Data converted to a Map now we need to convert each entry
        return data.map<T>((json) =>

            /// into a [FaqModel] instance and save into a List
            FaqModel.fromJson(json)).toList();

        break;
      case PostTypes.videos:

        /// Data converted to a Map now we need to convert each entry
        return data.map<T>((json) =>

            /// into a [VideoModel] instance and save into a List
            VideoModel.fromJson(json)).toList();

        break;
      case PostTypes.detailStats:

        /// Data converted to a Map now we need to convert each entry
        return data.map<T>((json) =>

            /// into a [VideoModel] instance and save into a List
            DetailStatsModel.fromJson(json)).toList();

        break;
      case PostTypes.protocol:

        /// Data converted to a Map now we need to convert each entry
        return data.map<T>((json) =>

            /// into a [VideoModel] instance and save into a List
            ProtocolModel.fromJson(json)).toList();

        break;
    }
  }

  @override
  void dispose() {
    onStream.close();
  }

  @override
  Stream<ResultStream> get onListener => onStream.stream;
}

class SplashBloc implements Bloc {
  final AppBloc bloc;

  SplashBloc(this.bloc);

  @override
  void dispose() {}

  @override
  Stream<ResultStream> get onListener => null;
}
