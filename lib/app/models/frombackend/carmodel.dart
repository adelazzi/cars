


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
}

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

enum FuelType { GPL, essence, diesel, electric, hybrid }

enum Transmission { manual, automatic, SemiAutomatic }
