import 'package:flutter/material.dart';

double widgetWidth({required BuildContext context, required double width}){
  double screenWidth=MediaQuery.of(context).size.width;
  double responsiveWidth=(screenWidth/411)*width;
  return responsiveWidth;
}