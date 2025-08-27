// ignore_for_file: avoid_print
/*
import 'package:cars/app/core/constants/end_points_constants.dart';
import 'package:cars/app/core/services/http_client_service.dart';
import 'package:cars/app/models/api_response.dart';
import 'package:cars/app/models/home_item_model.dart';
import 'package:cars/app/models/pagination_model.dart';

class HomeProvider {
  Future<PaginationModel<HomeItemModel>?> home({
    required int page,
    required Function onLoading,
    required Function onFinal,
  }) async {
    ApiResponse? response = await HttpClientService.sendRequest(
      endPoint: '${EndPointsConstants.home}?page=$page',
      requestType: HttpRequestTypes.post,
      onLoading: () => onLoading(),
      onFinal: () => onFinal(),
    );
    print(
        ' endPoint${EndPointsConstants.home} , home:::: ${response?.statusCode}');
    if (response?.body['data'] != null) {
      print(" home : ${response?.body['data']}");
      return PaginationModel.fromJson(
          response?.body['data'], HomeItemModel.fromJson);
    } else {
      print(" home : ${response?.statusCode}");
      return null;
    }
  }
}
*/