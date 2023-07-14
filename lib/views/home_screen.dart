import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/themes/theme.dart';

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
            // top slider
            _buildTopSliderWidget(),
            SizedBox(
              //height: context.dynamicHeight(0.04),
            ),
            // body citys lists
            _buildBodyCitysListCardWidget(),
          ],
        ),
      ),
    );
  }

  _buildTopSliderWidget() {}
}

mixin DarkModeClass {
  bool _darkMode = false;
}