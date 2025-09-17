class PaginationModel<Model> {
  int? count;
  String? next;
  String? previous;
  List<Model>? results;

  PaginationModel({this.count, this.next, this.previous, this.results});

  PaginationModel.fromJson(Map<String, dynamic> json, Function modelFromJson) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results!.add(modelFromJson(v));
      });
    }
  }
}
