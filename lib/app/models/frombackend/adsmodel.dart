import 'package:cars/app/core/services/http_client_service.dart';

class AdsModel {
  final int storeId;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime createdAt;

  AdsModel({
    required this.storeId,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
  });

  factory AdsModel.fromJson(Map<String, dynamic> json) {
    return AdsModel(
      storeId: json['store_id'],
      title: json['title'],
      description: json['description'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'store_id': storeId,
      'title': title,
      'description': description,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }


    /////// API Methods ///////


    static Future<List<AdsModel>> fetchAll() async {
      final response = await HttpClientService.sendRequest(
        endPoint: '/ads',
        requestType: HttpRequestTypes.get,
        onError: (errors, _) => throw Exception(errors.join(', ')),
      );

      if (response != null && response.body is List) {
        return (response.body as List)
            .map((json) => AdsModel.fromJson(json))
            .toList();
      }
      throw Exception('Failed to fetch ads');
    }

    static Future<AdsModel> create(Map<String, dynamic> data) async {
      final response = await HttpClientService.sendRequest(
        endPoint: '/ads',
        requestType: HttpRequestTypes.post,
        data: data,
        onError: (errors, _) => throw Exception(errors.join(', ')),
      );

      if (response != null && response.body is Map<String, dynamic>) {
        return AdsModel.fromJson(response.body);
      }
      throw Exception('Failed to create ad');
    }

    static Future<AdsModel> update(int id, AdsModel adsModel) async {
      final response = await HttpClientService.sendRequest(
      endPoint: '/ads/$id',
      requestType: HttpRequestTypes.put,
      data: adsModel.toJson(),
      onError: (errors, _) => throw Exception(errors.join(', ')),
      );

      if (response != null && response.body is Map<String, dynamic>) {
      return AdsModel.fromJson(response.body);
      }
      throw Exception('Failed to update ad');
    }

    static Future<void> remove(int id) async {
      await HttpClientService.sendRequest(
        endPoint: '/ads/$id',
        requestType: HttpRequestTypes.delete,
        onError: (errors, _) => throw Exception(errors.join(', ')),
      );
    }
}