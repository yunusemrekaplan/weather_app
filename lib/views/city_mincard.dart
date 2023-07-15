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

class CityMinCardScreen extends StatefulWidget {
  late String cityName;
  CityMinCardScreen({super.key, required this.cityName});

  @override
  State<CityMinCardScreen> createState() =>
      _CityMinCardScreenState(cityName: cityName);
}

class _CityMinCardScreenState extends State<CityMinCardScreen> {
  late String cityName;

  _CityMinCardScreenState({required this.cityName});

  List<City> weatherCityList = [];

  @override
  void initState() {
    getWeatherCityData(cityName);
    super.initState();
  }

  void getWeatherCityData(String cityData) async {
    CityService.getWeatherCity(cityData).then((data) {
      Map resultBody = jsonDecode(data.body);
      if (resultBody['success'] == true) {
        setState(
          () {
            Iterable result = resultBody['result'];
            weatherCityList = result.map(
              (weatherData) {
                City city = City(name: cityName);
                city.fromJson(weatherData);
                return city;
              },
            ).toList();
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (weatherCityList.isEmpty) {
      return _errorLoadingScreen();
    } else {
      return cityMinCardWidget();
    }
  }

  Widget _errorLoadingScreen() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.1,
      child: Center(
        child: LoadingAnimationWidget.dotsTriangle(
          color: themeData.colorScheme.background,
          size: 35,
        ),
      ),
    );
  }

  Widget cityMinCardWidget() {
    return Card(
      color: Colors.white,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CityWeatherScreen(cityName: cityName),
            ),
          );
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.11,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(4),
              ),
            ),
            child: Row(
              children: <Widget>[
                Flexible(
                  fit: FlexFit.tight,
                  flex: 2,
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(2),
                    child: Text(
                      cityName,
                      style: GoogleFonts.nunito(
                        textStyle:
                            Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: CachedNetworkImage(
                              imageUrl: weatherCityList[0].icon.toString(),
                              imageBuilder: (context, imageProvider) =>
                                  Container(
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
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 1,
                          child: Text(
                            weatherCityList[0].description,
                            style: GoogleFonts.nunito(
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: Colors.black54,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 2,
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(2),
                    child: Text(
                      "${double.parse(weatherCityList[0].degree).round().toString()}°C",
                      style: GoogleFonts.nunito(
                        textStyle:
                            Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  color: Colors.black54,
                                ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
