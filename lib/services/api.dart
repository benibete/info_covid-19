/// Abstract API class
abstract class AbstractApi {
  /// API ex:
  /// https://dev-covid19.vost.pt/wp-json/vost/v1/stats

  /// Scheme request format
  String get scheme;

  /// Host endpoint
  String get host;

  /// Base API path
  String get baseApi;

  /// building the path
  String build({String path = ""});
}

/// API config params
class _ConfigApi implements AbstractApi {
  ///https://dev-covid19.vost.pt/wp-json/vost/v1/stats

  @override
  String get scheme => "http";

  @override
  String get host => "localhost/covidweb";

  @override
  String get baseApi => "api";

  @override
  String build({String path = ""}) {
    var base = "$scheme://$host/$baseApi";

    if (path.isNotEmpty) {
      return "$base/$path";
    }

    return base;
  }
}

/// Develop API Configuration
class DevApi extends _ConfigApi {}

/// Production API Configuration
class ProductionApi extends _ConfigApi {
  @override
  String get scheme => "https";
  
  @override
  String get host => "covid.benibete.com";
}
