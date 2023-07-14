// ignore_for_file: no_logic_in_create_state, must_be_immutable

import 'package:flutter/material.dart';

class CityMincardScreen extends StatefulWidget {
  late String cityName;
  CityMincardScreen({super.key, required this.cityName});

  @override
  State<CityMincardScreen> createState() => _CityMincardScreenState(cityName: cityName);
}

class _CityMincardScreenState extends State<CityMincardScreen> {
  late String cityName;

  _CityMincardScreenState({required this.cityName});



  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
