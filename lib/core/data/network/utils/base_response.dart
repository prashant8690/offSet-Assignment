class ApiResponse<T> {
  final T data;

  ApiResponse(this.data);
}

enum ErrorType { timeout, noConnection, apiFailure, localError, unknown }

class ApiError {
  final ErrorType type;
  final String code;
  final String message;

  ApiError(this.type, {this.code = "", this.message = ""});
}

class RawError {
  late String code;
  late String msg;

  RawError({required this.code, required this.msg});

  RawError.fromJson(Map<String, dynamic> json) {
    code = json['status'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = code;
    data['msg'] = msg;
    return data;
  }
}

class RawResponse {
  dynamic data;
  RawError? error;

  RawResponse({this.data, this.error});

  RawResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    error = json['error'] != null ? RawError.fromJson(json['error']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data;
    if (error != null) {
      data['error'] = error?.toJson();
    }
    return data;
  }

  bool get isSuccess => error == null;
}
