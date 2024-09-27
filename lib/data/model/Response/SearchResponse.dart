
class SearchResponse {
  num? page;
  List<dynamic>? results;
  num? totalPages;
  num? totalResults;
  num? status_code;
  String? status_message;
  bool? success;

  SearchResponse(
      {this.page,
        this.results,
        this.totalPages,
        this.totalResults,
        this.status_code,
        this.status_message,
        this.success});

  SearchResponse.fromJson(Map<String, dynamic> json) {
    page = json["page"];
    status_code = json["status_code"];
    status_message = json["status_message"];
    success = json["success"];
    results = json["results"] ?? [];
    totalPages = json["total_pages"];
    totalResults = json["total_results"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["page"] = page;
    if (results != null) {
      _data["results"] = results;
    }
    _data["total_pages"] = totalPages;
    _data["total_results"] = totalResults;
    return _data;
  }
}
