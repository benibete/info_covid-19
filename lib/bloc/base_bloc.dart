import 'package:covid/model/slider_model.dart';
import 'package:covid/model/video_model.dart';
import 'package:covid/model/faq_category_model.dart';
import 'package:covid/model/detail_stats_model.dart';
import 'package:covid/model/faq_model.dart';
import 'package:covid/model/stats_model.dart';
import 'package:covid/model/protocol_model.dart';

abstract class Bloc {
  /// Dispose Bloc instance
  void dispose();

  /// A listener to capture the stream events
  ///
  /// This stream will be a [ResultStream] data type
  Stream<ResultStream> get onListener;
}

/// ResultStream a base class for sending event streams
///
/// [S] is the State instance, emum with states
/// [M] is the related data to pass on the stream
/// this could be a Model instance or other data type
class ResultStream<S, M> {
  /// Data passed to the stream
  M model;

  /// Actual State of the stream
  S state;
}

/// Enums the different States
///
/// [request] on doing the request
/// [loading] while doing the request
/// [success] if request was successfully
/// [fail] if request throw an exception
enum StateStream { request, loading, success, fail }

/// The ResultStream instance for requesting the case Stats
///
/// [StatsResultStream] is extended from [ResultStream]
class StatsResultStream extends ResultStream<StateStream, StatsModel> {
  @override
  StatsModel model;

  @override
  StateStream state;

  /// Constructor to set the [state], a [StateStream] instance
  /// and [model] a [StatsModel] instance
  StatsResultStream({this.state, this.model});
}

/// The ResultStream instance for requesting the remote work posts
///
/// [VideosResultStream] is extended from [ResultStream]
class VideosResultStream extends ResultStream<StateStream, List<VideoModel>> {
  @override
  List<VideoModel> model;

  @override
  StateStream state;

  /// Constructor to set the [state], a [StateStream] instance
  /// and [model] a [List<VideoModel>] instance list
  VideosResultStream({this.state, this.model});
}

/// The ResultStream instance for requesting the remote work posts
///
/// [FaqResultStream] is extended from [ResultStream]
class FaqResultStream
    extends ResultStream<StateStream, Map<int, List<FaqModel>>> {
  @override
  Map<int, List<FaqModel>> model;

  @override
  StateStream state;

  /// Constructor to set the [state], a [StateStream] instance
  /// and [model] a [List<FaqModel>] instance list
  FaqResultStream({this.state, this.model});
}

class SliderResultStream extends ResultStream<StateStream, List<SliderModel>> {
  @override
  List<SliderModel> model;

  @override
  StateStream state;

  /// and [model] a [Lst<SliderModel>] instance list
  SliderResultStream({this.state, this.model});
}

class FaqCategoryResultStream
    extends ResultStream<StateStream, List<FaqCategoryModel>> {
  @override
  List<FaqCategoryModel> model;

  @override
  StateStream state;

  /// and [model] a [Lst<FaqCategoryModel>] instance list
  FaqCategoryResultStream({this.state, this.model});
}

/// The ResultStream instance for requesting the remote work posts
///
/// [SetailStatsStream] is extended from [ResultStream]
class DetailStatsResultStream extends ResultStream<StateStream, List<DetailStatsModel>> {
  @override
  List<DetailStatsModel> model;

  @override
  StateStream state;

  /// Constructor to set the [state], a [StateStream] instance
  /// and [model] a [List<DetailStatsModel>] instance list
  DetailStatsResultStream({this.state, this.model});
}

/// The ResultStream instance for requesting the remote work posts
///
/// [ProtocolResultStream] is extended from [ResultStream]
class ProtocolResultStream extends ResultStream<StateStream, List<ProtocolModel>> {
  @override
  List<ProtocolModel> model;

  @override
  StateStream state;

  /// Constructor to set the [state], a [StateStream] instance
  /// and [model] a [List<ProtocolModel>] instance list
  ProtocolResultStream({this.state, this.model});
}