import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/themes/theme.dart';
import 'package:weather_app/views/city_mincard.dart';
import 'package:weather_app/views/city_slidercard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with DarkModeClass{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _darkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Hava Durumu?',
            style: GoogleFonts.nunito(
              textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: _darkMode == true
                    ? Colors.white
                    : themeData.colorScheme.background,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          actions: [
            Switch(
              activeThumbImage: const AssetImage(
                  'assets/images/switch_img/icons8-light-mode-78.png'),
              inactiveThumbImage: const AssetImage(
                  'assets/images/switch_img/icons8-dark-mode-67.png'),
              activeColor: _darkMode == true
                  ? Colors.white
                  : themeData.colorScheme.background,
              value: _darkMode,
              onChanged: (value) {
                setState(() {
                  _darkMode = value;
                });
              },
            ),
            const SizedBox(
              width: 15,
            ),
          ],
        ),
        body: ListView(
          children: <Widget>[
            _buildTopSliderWidget(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            _buildBodyCitysListCardWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopSliderWidget() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.28,
      child: CarouselSlider(
        items: [
          CitySliderCardScreen(cityName: 'Adana'),
          CitySliderCardScreen(cityName: 'Ankara'),
          CitySliderCardScreen(cityName: 'Antalya'),
          CitySliderCardScreen(cityName: 'Aydın'),
          CitySliderCardScreen(cityName: 'Balıkesir'),
          CitySliderCardScreen(cityName: 'Bursa'),
          CitySliderCardScreen(cityName: 'Denizli'),
          CitySliderCardScreen(cityName: 'Diyarbakır'),
          CitySliderCardScreen(cityName: 'Erzurum'),
          CitySliderCardScreen(cityName: 'Eskişehir'),
          CitySliderCardScreen(cityName: 'Gaziantep'),
          CitySliderCardScreen(cityName: 'Hatay'),
          CitySliderCardScreen(cityName: 'İstanbul'),
          CitySliderCardScreen(cityName: 'İzmir'),
          CitySliderCardScreen(cityName: 'Kahramanmaraş'),
          CitySliderCardScreen(cityName: 'Kayseri'),
          CitySliderCardScreen(cityName: 'Kocaeli'),
          CitySliderCardScreen(cityName: 'Konya'),
          CitySliderCardScreen(cityName: 'Malatya'),
          CitySliderCardScreen(cityName: 'Manisa'),
          CitySliderCardScreen(cityName: 'Mardin'),
          CitySliderCardScreen(cityName: 'Mersin'),
          CitySliderCardScreen(cityName: 'Muğla'),
          CitySliderCardScreen(cityName: 'Ordu'),
          CitySliderCardScreen(cityName: 'Sakarya'),
          CitySliderCardScreen(cityName: 'Samsun'),
          CitySliderCardScreen(cityName: 'Şanlıurfa'),
          CitySliderCardScreen(cityName: 'Tekirdağ'),
          CitySliderCardScreen(cityName: 'Trabzon'),
          CitySliderCardScreen(cityName: 'Van'),
        ],
        options: CarouselOptions(
          autoPlay: false,
          reverse: false,
          enlargeCenterPage: true,
          enlargeFactor: 0.2,
        ),
      ),
    );
  }

  Widget _buildBodyCitysListCardWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: <Widget>[
          CityMinCardScreen(cityName: 'Adana'),
          CityMinCardScreen(cityName: 'Ankara'),
          CityMinCardScreen(cityName: 'Antalya'),
          CityMinCardScreen(cityName: 'Aydın'),
          CityMinCardScreen(cityName: 'Balıkesir'),
          CityMinCardScreen(cityName: 'Bursa'),
          CityMinCardScreen(cityName: 'Denizli'),
          CityMinCardScreen(cityName: 'Diyarbakır'),
          CityMinCardScreen(cityName: 'Erzurum'),
          CityMinCardScreen(cityName: 'Eskişehir'),
          CityMinCardScreen(cityName: 'Gaziantep'),
          CityMinCardScreen(cityName: 'Hatay'),
          CityMinCardScreen(cityName: 'İstanbul'),
          CityMinCardScreen(cityName: 'İzmir'),
          CityMinCardScreen(cityName: 'Kahramanmaraş'),
          CityMinCardScreen(cityName: 'Kayseri'),
          CityMinCardScreen(cityName: 'Kocaeli'),
          CityMinCardScreen(cityName: 'Konya'),
          CityMinCardScreen(cityName: 'Malatya'),
          CityMinCardScreen(cityName: 'Manisa'),
          CityMinCardScreen(cityName: 'Mardin'),
          CityMinCardScreen(cityName: 'Mersin'),
          CityMinCardScreen(cityName: 'Muğla'),
          CityMinCardScreen(cityName: 'Ordu'),
          CityMinCardScreen(cityName: 'Sakarya'),
          CityMinCardScreen(cityName: 'Samsun'),
          CityMinCardScreen(cityName: 'Şanlıurfa'),
          CityMinCardScreen(cityName: 'Tekirdağ'),
          CityMinCardScreen(cityName: 'Trabzon'),
          CityMinCardScreen(cityName: 'Van'),
        ],
      ),
    );
  }
}

mixin DarkModeClass {
  bool _darkMode = false;
}