import 'package:flutter/material.dart';
import 'package:gecwapp/Constants/strings.dart';

class DetailsButtonStyle extends ButtonStyle {
  @override
  MaterialStateProperty<Color?>? get foregroundColor => MaterialStateProperty.all<Color>(AppColors.primaryColor);
  @override
  MaterialStateProperty<Color?>? get backgroundColor => MaterialStateProperty.all<Color>(AppColors.systemWhite);
  @override
  MaterialStateProperty<OutlinedBorder?>? get shape => MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          color: AppColors.primaryColor)));
}