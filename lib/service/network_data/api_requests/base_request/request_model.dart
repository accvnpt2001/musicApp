enum RequestMethod {
  getMethod,
  postMethod,
  putMethod,
}

class RequestModel {
  final RequestMethod method;
  String? route;
  final String params;
  bool? showLoading;
  bool? showErrorDialog;

  RequestModel(
    this.route,
    this.method,
    this.params, {
    this.showLoading,
    this.showErrorDialog,
  });
}
