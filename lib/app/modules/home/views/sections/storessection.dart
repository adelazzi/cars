import 'package:cars/app/models/storemodel.dart';
import 'package:cars/app/modules/home/views/cards/storecard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopStores extends StatelessWidget {
  final List<Store> topStores;

  const TopStores({Key? key, required this.topStores}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.h, // Use ScreenUtil for responsive height
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w), // Responsive padding
        itemCount: topStores.length,
        itemBuilder: (context, index) {
          final store = topStores[index];
          return StoreCard(store: store);
        },
      ),
    );
  }
}
