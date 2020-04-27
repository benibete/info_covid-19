import 'package:covid/generated/l10n.dart';
import 'package:dio/dio.dart';
import 'package:covid/ui/app.dart';

const String bundle = 'com.benibete.covid';

class APIResponse {
  static final _tag = '$bundle.APIResponse';
  dynamic data;
  Headers headers;
  DioErrorType dioErrorType;
  int statusCode;
  List<int> errors;

  List<String> errorsDescription(S intl) {
    Map<int, String> errorsMap = {
      1234: 'someError',
    };

    return errors
        .map((id) => errorsMap[id] != null ? errorsMap[id] : intl.defaultError)
        .toList();
  }

  APIResponse(this.data, this.statusCode, {this.headers, this.dioErrorType})
      : errors = headers != null && headers['errorKey'] != null
            ? [] // Decode errors to [errors]
            : null {
    logger.i(this);
  }

  bool get isOk =>
      dioErrorType == null &&
      errors == null &&
      statusCode >= 200 &&
      statusCode < 400;

  bool get isNotOk => !isOk;

  @override
  String toString() =>
      '[$_tag] Code: $statusCode | Body: $data | Headers: $headers | Error: $dioErrorType';
}
