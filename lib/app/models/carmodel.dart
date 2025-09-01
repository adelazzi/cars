import 'package:cars/app/core/constants/images_assets_constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Car {
  final String id;
  final String mark;
  final String model;
  final int year;
  final CarType type;
  final FuelType energie;
  final Transmission boiteVitesse;
  final String moteur;
  final String matrecule;
  final String clientid;

  Car({
    this.matrecule = '',
    this.id = '',
    this.clientid = '',
    required this.mark,
    required this.model,
    required this.year,
    this.type = CarType.voiture,
    this.energie = FuelType.essence,
    this.boiteVitesse = Transmission.manual,
    this.moteur = '',
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

  String get image {
    switch (this) {
      case CarType.voiture:
        return ImagesAssetsConstants.voiture;
      case CarType.motos_scooters:
        return ImagesAssetsConstants.motos_scooters;
      case CarType.fourgon:
        return ImagesAssetsConstants.fourgon;
      case CarType.camion:
        return ImagesAssetsConstants.camion;
      case CarType.bus:
        return ImagesAssetsConstants.bus;
      case CarType.tracteur:
        return ImagesAssetsConstants.tracteur;
    }
  }

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

enum Transmission { automatic, manual, SemiAutomatic }
