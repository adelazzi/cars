


import 'package:cars/app/core/services/http_client_service.dart';

class Car {
  final String id;
  final String mark;
  final String model;
  final int year;
  final CarType type;
  final FuelType energie;
  final Transmission boiteVitesse;
  final String moteur;
  final String clientid;

  Car({
    this.id = '',
    required this.mark,
    required this.model,
    required this.year,
    this.type = CarType.voiture,
    this.energie = FuelType.essence,
    this.boiteVitesse = Transmission.manual,
    this.moteur = '',
    this.clientid = '',
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'] ?? '',
      mark: json['mark'],
      model: json['model'],
      year: json['year'],
      type: CarType.values.firstWhere((e) => e.toString() == 'CarType.${json['type']}'),
      energie: FuelType.values.firstWhere((e) => e.toString() == 'FuelType.${json['energie']}'),
      boiteVitesse: Transmission.values.firstWhere((e) => e.toString() == 'Transmission.${json['boiteVitesse']}'),
      moteur: json['moteur'] ?? '',
      clientid: json['clientid'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
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
      endPoint: '/cars',
      requestType: HttpRequestTypes.post,
      data: car.toJson(),
      onError: (errors, _) => throw Exception(errors.join(', ')),
    );

    if (response != null && response.body is Map<String, dynamic>) {
      return Car.fromJson(response.body);
    }
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

  static Future<void> delete(String id) async {
    await HttpClientService.sendRequest(
      endPoint: '/cars/$id',
      requestType: HttpRequestTypes.delete,
      onError: (errors, _) => throw Exception(errors.join(', ')),
    );
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
