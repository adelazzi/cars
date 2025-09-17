import 'dart:developer';

import 'package:cars/app/core/constants/end_points_constants.dart';
import 'package:cars/app/core/services/http_client_service.dart';
import 'package:cars/app/modules/profile/controllers/profile_controller.dart';
import 'package:get/get.dart';

class Car {
  final int id;
  final String mark;
  final String model;
  final int year;
  final CarType type;
  final FuelType energie;
  final Transmission boiteVitesse;
  final String moteur;
  int clientid;

  Car({
    this.id = 0,
    required this.mark,
    required this.model,
    required this.year,
    this.type = CarType.voiture,
    this.energie = FuelType.essence,
    this.boiteVitesse = Transmission.manual,
    this.moteur = '',
    required this.clientid,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      mark: json['mark'],
      model: json['model'],
      year: json['year'],
      type: CarType.values
          .firstWhere((e) => e.toString() == 'CarType.${json['type']}'),
      energie: FuelType.values
          .firstWhere((e) => e.toString() == 'FuelType.${json['energie']}'),
      boiteVitesse: Transmission.values.firstWhere(
          (e) => e.toString() == 'Transmission.${json['boiteVitesse']}'),
      moteur: json['moteur'] ?? '',
      clientid: int.tryParse(json['clientid']?.toString() ?? '0') ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mark': mark,
      'model': model,
      'year': year,
      'type': type.name,
      'energie': energie.name,
      'boiteVitesse': boiteVitesse.name,
      'moteur': moteur,
      'clientid': clientid,
    };
  }

  /////// API Methods ///////

  static Future<List<Car>> fetchAll() async {
    final response = await HttpClientService.sendRequest(
      endPoint: '/cars',
      requestType: HttpRequestTypes.get,
      onError: (errors, _) => throw Exception(errors.join(', ')),
    );

    if (response != null && response.body is List) {
      return (response.body as List).map((json) => Car.fromJson(json)).toList();
    }
    return [];
  }

  static Future<Car> create(Car car) async {
    final response = await HttpClientService.sendRequest(
        endPoint: EndPointsConstants.carApi,
        requestType: HttpRequestTypes.post,
        data: car.toJson(),
        onSuccess: (response) {
          log('done');
          Get.find<ProfileController>()
              .cars
              .value
              .add(Car.fromJson(response.body));
        },
        onError: (errors, response) {
          log('onError === ' + response.body.toString());
          log(errors.join(', '));
        });

    if (response != null && response.body is Map<String, dynamic>) {
      return Car.fromJson(response.body);
    }
    log('Failed to create car');
    throw Exception('Failed to create car');
  }

  static Future<Car> update(String id, Car car) async {
    final response = await HttpClientService.sendRequest(
      endPoint: '/cars/$id',
      requestType: HttpRequestTypes.put,
      data: car.toJson(),
      onError: (errors, _) => throw Exception(errors.join(', ')),
    );

    if (response != null && response.body is Map<String, dynamic>) {
      return Car.fromJson(response.body);
    }
    throw Exception('Failed to update car');
  }

  static Future<bool> delete(String id) async {
    await HttpClientService.sendRequest(
        endPoint: '/cars/$id',
        requestType: HttpRequestTypes.delete,
        onSuccess: (response) {
          log('Car deleted successfully');
          return true;
        },
        onError: (errors, _) {
          log(errors.join(', '));
          return false;
        });
    return true;
  }

  static Future<Car> fetchById(String id) async {
    final response = await HttpClientService.sendRequest(
      endPoint: '/cars/$id',
      requestType: HttpRequestTypes.get,
      onError: (errors, _) => throw Exception(errors.join(', ')),
    );

    if (response != null && response.body is Map<String, dynamic>) {
      return Car.fromJson(response.body);
    }
    throw Exception('Failed to fetch car details');
  }

  static Future<List<Car>> fetchMyCars(int id) async {
    log('Fetching cars for user ID: $id');
    final response = await HttpClientService.sendRequest(
        endPoint: EndPointsConstants.myCars(id.toString()),
        requestType: HttpRequestTypes.get,
        onSuccess: (response) {
          log('Successfully fetched cars for user ID: $id');
        },
        onError: (errors, responce) {
          log('errore ======= ${responce.statusCode}');
          log(errors.join(', '));
        });

    if (response != null && response.body is List) {
      log('CARS response.body: ${response.body}');
      return (response.body as List).map((json) {
        return Car(
          id: int.tryParse(json['id']?.toString() ?? '0') ?? 0,
          mark: json['mark'] ?? '',
          model: json['model'] ?? '',
          year: int.tryParse(json['year']?.toString() ?? '0') ?? 0,
          type: CarType.values.firstWhere(
            (e) => e.toString() == 'CarType.${json['type']}',
            orElse: () => CarType.voiture,
          ),
          energie: FuelType.values.firstWhere(
            (e) => e.toString() == 'FuelType.${json['energie']}',
            orElse: () => FuelType.essence,
          ),
          boiteVitesse: Transmission.values.firstWhere(
            (e) => e.toString() == 'Transmission.${json['boitevitesse']}',
            orElse: () => Transmission.manual,
          ),
          moteur: json['moteur'] ?? '',
          clientid: int.tryParse(json['clientid']?.toString() ?? '0') ?? 0,
        );
      }).toList();
    }
    return [];
  }
}

////////// enums ////////
enum CarType {
  voiture,
  motos_scooters,
  fourgon,
  camion,
  bus,
  tracteur,
  ;

  String get displayName {
    switch (this) {
      case CarType.voiture:
        return 'Voiture';
      case CarType.motos_scooters:
        return 'Motos & Scooters';
      case CarType.fourgon:
        return 'Fourgon';
      case CarType.camion:
        return 'Camion';
      case CarType.bus:
        return 'Bus';
      case CarType.tracteur:
        return 'Tracteur';
    }
  }
}

enum FuelType {
  GPL,
  essence,
  diesel,
  electric,
  hybrid;

  String get displayName {
    switch (this) {
      case FuelType.GPL:
        return 'GPL';
      case FuelType.essence:
        return 'Essence';
      case FuelType.diesel:
        return 'Diesel';
      case FuelType.electric:
        return 'Electric';
      case FuelType.hybrid:
        return 'Hybrid';
    }
  }
}

enum Transmission {
  manual,
  automatic,
  semiAuto;

  String get displayName {
    switch (this) {
      case Transmission.manual:
        return 'Manual';
      case Transmission.automatic:
        return 'Automatic';
      case Transmission.semiAuto:
        return 'Semi-Automatic';
    }
  }
}
