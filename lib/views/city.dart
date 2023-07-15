// ignore_for_file: no_logic_in_create_state, must_be_immutable

import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:weather_app/models/city.dart';
import 'package:weather_app/services/city_service.dart';
import 'package:weather_app/themes/theme.dart';

class CityWeatherScreen extends StatefulWidget {
  late String cityName;
  CityWeatherScreen({super.key, required this.cityName});

  @override
  State<CityWeatherScreen> createState() =>
      _CityWeatherScreenState(cityName: cityName);
}

class _CityWeatherScreenState extends State<CityWeatherScreen> {
  late String cityName;

  _CityWeatherScreenState({required this.cityName});

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

  String buildWeatherListCityText(String day) {
    switch (day.toLowerCase()) {
      case "pazartesi":
        return "Pazartesi";
      case "salı":
        return "Salı           ";
      case "çarşamba":
        return "Çarşamba";
      case "perşembe":
        return "Perşembe";
      case "cuma":
        return "Cuma        ";
      case "cumartesi":
        return "Cumartesi   ";
      case "pazar":
        return "Pazar          ";
      default:
        return "?";
    }
  }

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context).size;
    String status =
        weatherCityList.isEmpty ? 'Error' : weatherCityList[0].description;
    String res = "";

    if (weatherCityList.isEmpty) {
      return _errorLoadingScreen();
    } else {
      if (status == "parçalı bulutlu") {
        res =
            "https://i.pinimg.com/564x/c4/fd/0b/c4fd0b71a1ca00375a675e2bd3ce2cf3.jpg";
      } else if (status == "rain and snow") {
        res =
            "https://i.pinimg.com/564x/5a/90/70/5a907030775acc4b1660c4be44530c04.jpg";
      } else if (status == "hafif kar yağışlı") {
        res =
            "https://firebasestorage.googleapis.com/v0/b/blogdb-6ac10.appspot.com/o/4fc90d09-690f-4759-afec-7181a122e068.jpg?alt=media&token=09d7ea01-f4d3-40b6-9cb2-ccb04625e18d";
      } else if (status == "parçalı az bulutlu") {
        res =
            "https://i.pinimg.com/564x/e3/9e/7d/e39e7df3b5b86123fd11cef80d49ebe3.jpg";
      } else if (status == "hafif yağmur") {
        res =
            "https://i.pinimg.com/564x/78/b2/32/78b232ad14297dbbdb5cd09ef9c8d1bc.jpg";
      } else if (status == "az bulutlu") {
        res =
            "https://i.pinimg.com/564x/e3/9e/7d/e39e7df3b5b86123fd11cef80d49ebe3.jpg";
      } else if (status == "açık") {
        res =
            "https://i.pinimg.com/750x/bf/4a/b8/bf4ab8e641ba5942270a91247e623b63.jpg";
      } else if (status == "kapalı") {
        res =
            "https://i.pinimg.com/564x/53/f7/9d/53f79dcd723ffa00faad120ad7e6c5a0.jpg";
      } else {
        res =
            "https://i.pinimg.com/564x/cb/b8/ed/cbb8edb225f3c95eb828e86ea9984950.jpg";
      }
    }

    return Scaffold(
      body: CachedNetworkImage(
        imageUrl: res.toString(),
        imageBuilder: (context, imageProvider) => _buildImageBuilder(imageProvider, query, context),
        placeholder: (context, url) => Center(
          child: LoadingAnimationWidget.beat(
            color: themeData.colorScheme.background,
            size: 35,
          ),
        ),
        errorWidget: (context, url, error) => const CircularProgressIndicator(),
      ),
    );
  }

  Container _buildImageBuilder(ImageProvider<Object> imageProvider, Size query, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        color: Colors.white.withOpacity(0.1),
        child: Column(
          children: <Widget>[
            _buildTopBody(query, context),
            _buildBottomButton(context),
          ],
        ),
      ),
    );
  }

  Flexible _buildBottomButton(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: FadeInUp(
          child: GestureDetector(
            onTap: bottomButtonOnTap,
            child: _buildBottomWidget(context),
          ),
        ),
      ),
    );
  }

  SizedBox _buildBottomWidget(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.black54.withOpacity(0.1),
          borderRadius: const BorderRadius.all(
            Radius.circular(4),
          ),
          border: Border.all(color: Colors.white, width: 0.5),
          boxShadow: [
            BoxShadow(
              blurRadius: 0.0,
              color: Colors.black54.withOpacity(0.1),
              offset: const Offset(1, 1),
            ),
          ],
        ),
        child: Text(
          "6 Günlük Hava Durumu",
          style: GoogleFonts.nunito(
            textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Colors.white,
              shadows: [
                const Shadow(
                  blurRadius: 10.0,
                  color: Colors.black,
                  offset: Offset(1, 1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future bottomButtonOnTap() {
    return showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (context) => _buildDayListBox(context),
    );
  }

  SizedBox _buildDayListBox(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.5,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: _buildDayListView(),
      ),
    );
  }

  ListView _buildDayListView() {
    return ListView.separated(
      itemCount: weatherCityList.length - 1,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.white,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.11,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
              child: _buildDayRow(index, context),
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          color: Colors.transparent,
        );
      },
    );
  }

  Row _buildDayRow(int index, BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
          fit: FlexFit.tight,
          flex: 2,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(2),
            child: Text(
              buildWeatherListCityText(weatherCityList[index + 1].day),
              style: GoogleFonts.nunito(
                textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
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
                      imageUrl: weatherCityList[index + 1].icon.toString(),
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            colorFilter: const ColorFilter.mode(
                                Colors.red, BlendMode.colorBurn,
                            ),
                          ),
                        ),
                      ),
                      placeholder: (context, url) => LoadingAnimationWidget.beat(
                          color: themeData.colorScheme.background,
                          size: 25),
                      errorWidget: (context, url, error) => const CircularProgressIndicator(),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: Text(
                    "${double.parse(weatherCityList[index + 1].min).round()}°",
                    style: GoogleFonts.nunito(
                      textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black54),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: Text(
                    "-5°C",
                    style: GoogleFonts.nunito(
                      textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black54),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Expanded _buildTopBody(Size query, BuildContext context) {
    return Expanded(
      flex: 6,
      child: SizedBox(
        width: query.width,
        height: query.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 75, left: 30, right: 30),
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: <Widget>[
                      FadeInUp(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            "Türkiye / $cityName",
                            style: GoogleFonts.nunito(
                              textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                                color: Colors.white,
                                shadows: [
                                  const Shadow(
                                    blurRadius: 10.0,
                                    color: Colors.black,
                                    offset: Offset(1, 1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      FadeInUp(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            "${double.parse(weatherCityList[0].degree).round().toString()}°C",
                            style: GoogleFonts.ubuntu(
                              textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 105,
                                shadows: [
                                  const Shadow(
                                    blurRadius: 10.0,
                                    color: Colors.black,
                                    offset: Offset(1, 1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      FadeInUp(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            weatherCityList[0].description,
                            style: GoogleFonts.nunito(
                              textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                                color: Colors.white,
                                shadows: [
                                  const Shadow(
                                    blurRadius: 10.0,
                                    color: Colors.black,
                                    offset: Offset(1, 1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _errorLoadingScreen() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            LoadingAnimationWidget.fourRotatingDots(color: themeData.colorScheme.background, size: 80),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Hava Durumu Açılıyor...",
              style: GoogleFonts.nunito(
                textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Lütfen Bekleyiniz",
              style: GoogleFonts.nunito(
                textStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
