// ignore_for_file: no_logic_in_create_state, must_be_immutable

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:weather_app/models/city.dart';
import 'package:weather_app/services/city_service.dart';
import 'package:weather_app/themes/theme.dart';
import 'package:weather_app/views/city.dart';

class CitySliderCardScreen extends StatefulWidget {
  late String cityName;

  CitySliderCardScreen({super.key, required this.cityName});

  @override
  State<CitySliderCardScreen> createState() =>
      _CitySliderCardState(cityName: cityName);
}

class _CitySliderCardState extends State<CitySliderCardScreen> {
  late String cityName;

  _CitySliderCardState({required this.cityName});

  List<City> weatherCityList = [];

  @override
  void initState() {
    super.initState();
    getWeatherCityData(cityName);
  }

  void getWeatherCityData(String cityData) async {
    CityService.getWeatherCity(cityData).then((data) {
      Map resultBody = jsonDecode(data.body);
      if (resultBody['success'] == true) {
        setState(() {
          Iterable result = resultBody['result'];
          weatherCityList = result.map((weatherData) {
            City city = City(name: cityName);
            city.fromJson(weatherData);
            return city;
          }).toList();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (weatherCityList.isEmpty) {
      return _errorLoadingScreen();
    } else {
      return _citySliderCardWidget();
    }
  }

  Widget _errorLoadingScreen() {
    return Card(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CityWeatherScreen(cityName: cityName),
            ),
          );
        },
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(4),
            ),
          ),
          child: Center(
            child: LoadingAnimationWidget.beat(
                color: themeData.colorScheme.background, size: 35),
          ),
        ),
      ),
    );
  }

  Widget _citySliderCardWidget() {
    return Card(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CityWeatherScreen(cityName: cityName),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                themeData.colorScheme.background,
                Colors.lightBlue,
                Colors.lightBlueAccent,
              ],
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(4),
            ),
          ),
          child: Row(
            children: <Widget>[
              Flexible(
                fit: FlexFit.tight,
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: CachedNetworkImage(
                    imageUrl: weatherCityList[0].icon.toString(),
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            colorFilter: const ColorFilter.mode(
                                Colors.red, BlendMode.colorBurn)),
                      ),
                    ),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const CircularProgressIndicator(),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            cityName,
                            style: GoogleFonts.nunito(
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            "${double.parse(weatherCityList[0].degree).round().toString()}°C",
                            style: GoogleFonts.nunito(
                              textStyle: Theme.of(context)
                                  .textTheme
                                  // ignore: deprecated_member_use
                                  .headline3!
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            weatherCityList[0].description,
                            style: GoogleFonts.nunito(
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
