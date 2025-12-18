import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cars/app/core/constants/strings_assets_constants.dart';
import 'package:cars/app/core/styles/colors.dart';
import 'package:cars/app/core/styles/text_styles.dart';
import 'package:cars/app/modules/fastrequest/controllers/fastrequest_controller.dart';

class FastrequestView extends GetView<FastrequestController> {
  FastrequestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          ' fastrequest Page ' ,
          style: TextStyles.titleSmall(context)
              .copyWith(color: MainColors.primaryColor),
        ),
      ),
      body: Center(
        child: Text(' This is the Fastrequest page.'),
      ),
    );
  }
}
