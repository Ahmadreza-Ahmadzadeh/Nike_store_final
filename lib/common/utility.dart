import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const defaultPhysics = BouncingScrollPhysics();

extension PriceLable on int {
  String get withPriceLabel => this > 0 ? "$seprateByComma تومان" : "رایگان";

  String get seprateByComma {
    final numberFormat = NumberFormat.decimalPattern();
    return numberFormat.format(this);
  }
}
