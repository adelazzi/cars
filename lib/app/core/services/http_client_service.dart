import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cars/app/core/components/others/toast_component.dart';
import 'package:cars/app/core/constants/end_points_constants.dart';
import 'package:cars/app/core/constants/storage_keys_constants.dart';
import 'package:cars/app/core/services/local_storage_service.dart';
import 'package:cars/app/models/api_response.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';

class HttpClientService {
  static final String _baseUrl = Uri.encodeFull(EndPointsConstants.baseUrl);

  static Future<ApiResponse?> sendRequest({
    required String endPoint,
    required HttpRequestTypes requestType,
    dynamic invoice,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? header,
    Function(bool isLoading)? onLoading,
    Function(ApiResponse response)? onSuccess,
    Function(List<String> errorsList, ApiResponse response)? onError,
    Function()? onFinal,
    Function(int sent, int total)? onProgress,
  }) async {
    ApiResponse? response;
    onLoading?.call(true);

    try {
      switch (requestType) {
        case HttpRequestTypes.post:
          response = await post(
            endPoint,
            formData: data,
            header: header,
            onProgress: onProgress,
          );
          break;
        case HttpRequestTypes.get:
          response = await get(
            endPoint,
            queryParameters: queryParameters,
            header: header,
            data: data,
          );
          break;
        case HttpRequestTypes.delete:
          response = await delete(
            endPoint,
            formData: data,
            header: header,
          );
          break;
        case HttpRequestTypes.put:
          response = await put(
            endPoint,
            formData: data,
            header: header,
          );
          break;
        case HttpRequestTypes.patch:
          response = await patch(
            endPoint,
            formData: data,
            header: header,
          );
          break;
      }

      if (response == null) {
        throw Exception('No response received from server');
      }

      if ((response.statusCode == 200 || response.statusCode == 201) ||
          response.requestStatus == RequestStatus.success) {
        onSuccess?.call(response);
        return response;
      } else {
        _handleErrorResponse(response, onError);
      }
    } catch (error, stackTrace) {
      log("Error in sendRequest: $error\n$stackTrace");
      response ??= ApiResponse(
        statusCode: 500,
        message: error.toString(),
        requestStatus: RequestStatus.serverError,
      );
      onError?.call([error.toString()], response);
    } finally {
      onLoading?.call(false);
      onFinal?.call();
    }
    return null;
  }

  static void _handleErrorResponse(
    ApiResponse response,
    Function(List<String> errorsList, ApiResponse response)? onError,
  ) {
    final errors = convertResponseErrorsToString(response);

    if (response.requestStatus == RequestStatus.serverError) {
      ToastComponent().showToast(
        Get.context!,
        message: 'Server error:  ${response.message}',
        type: ToastTypes.error,
      );
    } else if (response.requestStatus == RequestStatus.clientError) {
      if (response.statusCode == 401) {
        // Handle unauthorized
        // Get.find<UserController>().clearUser();
      }
      log('Client error: ${response.message}');
      // ToastComponent().showToast(
      //   Get.context!,
      //   message: 'Client error: ${response.message}',
      //   type: ToastTypes.error,
      // );
    } else {
      ToastComponent().showToast(
        Get.context!,
        message: 'Error: ${response.message ?? 'Unknown error'}',
        type: ToastTypes.error,
      );
    }

    onError?.call(errors, response);
  }

  static Future<dio.BaseOptions> getBaseOptions({
    Map<String, String>? header,
    int? timeout,
  }) async {
    header ??= <String, String>{};

    // Add authorization if available
    // final token = await LocalStorageService.loadData(
    //   key: StorageKeysConstants.userToken,
    //   type: DataTypes.string,
    // );

    // if (token != null) {
    //   header['Authorization'] = 'Bearer $token';
    // }

    header.addAll({
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    });

    return dio.BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 60),
      headers: header,
    );
  }

  static Future<ApiResponse> get(
    String endPoint, {
    int? timeout,
    Map<String, String>? header,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.Dio(await getBaseOptions(
        timeout: timeout,
        header: header,
      ))
          .get(
        Uri.encodeFull(endPoint),
        queryParameters: queryParameters,
        data: data,
      );

      return _buildOut(response);
    } on dio.DioError catch (error) {
      return _handleDioError(error);
    } on SocketException catch (error) {
      return _handleSocketException(error);
    } catch (error) {
      return _handleUnknownError(error);
    }
  }

  static Future<ApiResponse> post(
    String endPoint, {
    dynamic formData,
    Map<String, String>? header,
    int? timeout,
    Map<String, String?>? queryParameters,
    Function(int sent, int total)? onProgress,
  }) async {
    try {
      final dioInstance = dio.Dio(await getBaseOptions(
        timeout: timeout,
        header: header,
      ));

      final response = await dioInstance.post(
        Uri.encodeFull(endPoint),
        data: formData,
        queryParameters: queryParameters,
        onSendProgress: onProgress,
      );

      return _buildOut(response);
    } on dio.DioError catch (error) {
      return _handleDioError(error);
    } on SocketException catch (error) {
      return _handleSocketException(error);
    } catch (error) {
      return _handleUnknownError(error);
    }
  }

  static Future<ApiResponse> delete(
    String endPoint, {
    dynamic formData,
    Map<String, String>? header,
    int? timeout,
    Map<String, String>? queryParameters,
  }) async {
    try {
      final response = await dio.Dio(await getBaseOptions(
        timeout: timeout,
        header: header,
      ))
          .delete(
        Uri.encodeFull(endPoint),
        data: formData,
        queryParameters: queryParameters,
      );
      return _buildOut(response);
    } on dio.DioError catch (error) {
      return _handleDioError(error);
    } on SocketException catch (error) {
      return _handleSocketException(error);
    } catch (error) {
      return _handleUnknownError(error);
    }
  }

  static Future<ApiResponse> put(
    String endPoint, {
    dynamic formData,
    Map<String, String>? header,
    int? timeout,
    Map<String, String>? queryParameters,
  }) async {
    try {
      final response = await dio.Dio(await getBaseOptions(
        timeout: timeout,
        header: header,
      ))
          .put(
        Uri.encodeFull(endPoint),
        data: formData,
        queryParameters: queryParameters,
      );
      return _buildOut(response);
    } on dio.DioError catch (error) {
      return _handleDioError(error);
    } on SocketException catch (error) {
      return _handleSocketException(error);
    } catch (error) {
      return _handleUnknownError(error);
    }
  }

  static Future<ApiResponse> patch(
    String endPoint, {
    dynamic formData,
    Map<String, String>? header,
    int? timeout,
    Map<String, String>? queryParameters,
  }) async {
    try {
      final response = await dio.Dio(await getBaseOptions(
        timeout: timeout,
        header: header,
      ))
          .patch(
        Uri.encodeFull(endPoint),
        data: formData,
        queryParameters: queryParameters,
      );
      return _buildOut(response);
    } on dio.DioError catch (error) {
      return _handleDioError(error);
    } on SocketException catch (error) {
      return _handleSocketException(error);
    } catch (error) {
      return _handleUnknownError(error);
    }
  }

  static ApiResponse _buildOut(dio.Response response) {
    final apiResponse = ApiResponse();
    apiResponse.statusCode = response.statusCode;
    apiResponse.body = response.data;

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 204) {
      //apiResponse.message = response.data['message'] ?? 'Success';
      apiResponse.requestStatus = RequestStatus.success;
      //   log('Response status: ${apiResponse.requestStatus}');
    } else if (response.statusCode! >= 400 && response.statusCode! < 500) {
      apiResponse.message = response.data['message'] ?? 'Client error';
      apiResponse.error = response.data['errors'] ?? {};
      apiResponse.requestStatus = RequestStatus.clientError;
    } else if (response.statusCode! >= 500) {
      apiResponse.message = response.data['message'] ?? 'Server error';
      apiResponse.error = response.data['errors'] ?? {};
      apiResponse.requestStatus = RequestStatus.serverError;
    }

    return apiResponse;
  }

  static ApiResponse _handleDioError(dio.DioError error) {
    if (error.response != null) {
      return _buildOut(error.response!);
    }

    if (error.error is SocketException) {
      return _handleSocketException(error.error as SocketException);
    }

    return ApiResponse(
      statusCode: error.response?.statusCode ?? 500,
      message: error.message,
      requestStatus: RequestStatus.serverError,
    );
  }

  static ApiResponse _handleSocketException(SocketException error) {
    return ApiResponse(
      statusCode: 502,
      message: 'No Internet connection',
      requestStatus: RequestStatus.internetError,
    );
  }

  static ApiResponse _handleUnknownError(dynamic error) {
    return ApiResponse(
      statusCode: 500,
      message: 'Unknown error occurred: ${error.toString()}',
      requestStatus: RequestStatus.serverError,
    );
  }

  static List<String> convertResponseErrorsToString(ApiResponse response) {
    final errorsMessage = <String>[];

    if (response.error is Map<String, dynamic>) {
      final messagesList = response.error as Map<String, dynamic>;
      messagesList.forEach((key, value) {
        if (value is List) {
          errorsMessage.addAll(value.map((e) => e.toString()));
        } else {
          errorsMessage.add(value.toString());
        }
      });
    } else if (response.message != null) {
      errorsMessage.add(response.message!);
    } else {
      errorsMessage.add('An unknown error occurred');
    }

    return errorsMessage;
  }
}

enum HttpRequestTypes {
  post,
  delete,
  put,
  get,
  patch,
}
