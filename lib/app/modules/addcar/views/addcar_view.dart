import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cars/app/core/styles/colors.dart';
import 'package:cars/app/core/styles/text_styles.dart';
import 'package:cars/app/modules/addcar/controllers/addcar_controller.dart';
import 'package:cars/app/models/frombackend/carmodel.dart';

class AddcarView extends GetView<AddcarController> {
  AddcarView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _markController = TextEditingController();
  final _modelController = TextEditingController();
  final _yearController = TextEditingController();
  final _engineController = TextEditingController();
  CarType _selectedCarType = CarType.voiture;
  FuelType _selectedFuelType = FuelType.essence;
  Transmission _selectedTransmission = Transmission.manual;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812), // Set the design size of your app
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Add Car',
              style: TextStyles.titleSmall(context)
                  .copyWith(color: MainColors.primaryColor),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(16.w), // Use ScreenUtil for padding
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(
                    controller: _markController,
                    decoration: InputDecoration(
                      labelText: 'Mark',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the car mark';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h), // Use ScreenUtil for spacing
                  TextFormField(
                    controller: _modelController,
                    decoration: InputDecoration(
                      labelText: 'Model',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the car model';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  TextFormField(
                    controller: _yearController,
                    decoration: InputDecoration(
                      labelText: 'Year',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the car year';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Please enter a valid year';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  DropdownButtonFormField<CarType>(
                    value: _selectedCarType,
                    decoration: InputDecoration(
                      labelText: 'Car Type',
                      border: OutlineInputBorder(),
                    ),
                    items: CarType.values
                        .map((type) => DropdownMenuItem(
                              value: type,
                              child: Text(type.displayName),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        _selectedCarType = value;
                      }
                    },
                  ),
                  SizedBox(height: 16.h),
                  DropdownButtonFormField<FuelType>(
                    value: _selectedFuelType,
                    decoration: InputDecoration(
                      labelText: 'Fuel Type',
                      border: OutlineInputBorder(),
                    ),
                    items: FuelType.values
                        .map((type) => DropdownMenuItem(
                              value: type,
                              child: Text(type.displayName),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        _selectedFuelType = value;
                      }
                    },
                  ),
                  SizedBox(height: 16.h),
                  DropdownButtonFormField<Transmission>(
                    value: _selectedTransmission,
                    decoration: InputDecoration(
                      labelText: 'Transmission',
                      border: OutlineInputBorder(),
                    ),
                    items: Transmission.values
                        .map((type) => DropdownMenuItem(
                              value: type,
                              child: Text(type.displayName),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        _selectedTransmission = value;
                      }
                    },
                  ),
                  SizedBox(height: 16.h),
                  TextFormField(
                    controller: _engineController,
                    decoration: InputDecoration(
                      labelText: 'Engine',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final newCar = Car(
                          mark: _markController.text,
                          model: _modelController.text,
                          year: int.parse(_yearController.text),
                          type: _selectedCarType,
                          energie: _selectedFuelType,
                          boiteVitesse: _selectedTransmission,
                          moteur: _engineController.text,
                        );

                        // Call the controller or API to save the car
                        controller.addCar(newCar);
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
