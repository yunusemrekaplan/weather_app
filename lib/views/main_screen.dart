import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:weather_app/views/home_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with MainSetting {
  @override
  void initState() {
    Future.delayed(
      const Duration(
        seconds: 3,
      ),
      () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
          (Route<dynamic> route) => false,
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Container _buildBody() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background_img/background_img.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
        ),
        alignment: Alignment.center,
        child: Column(
          children: [
            _buildMainBody(),
            _buildFooterBody(),
          ],
        ),
      ),
    );
  }

  Expanded _buildMainBody() {
    return Expanded(
      flex: 9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                LoadingAnimationWidget.discreteCircle(
                  color: Colors.white,
                  secondRingColor: Colors.lightBlueAccent,
                  thirdRingColor: Colors.lightBlue,
                  size: 75,
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child:
                        Image.asset("assets/images/logo/icons8-weather-65.png"),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 0.05,
          ),
          Text(
            "Hava Durumu",
            style: GoogleFonts.ubuntu(
              textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            "Lütfen Bekleyiniz...",
            style: GoogleFonts.ubuntu(
              textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Flexible _buildFooterBody() {
    return Flexible(
      fit: FlexFit.tight,
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Icon(
            Icons.favorite,
            color: Colors.redAccent,
            size: 21,
          ),
          const SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              _launchUrl();
            },
            child: Text(
              "Github: Yunus Emre Kaplan",
              style: GoogleFonts.nunito(
                textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

mixin MainSetting {
  final Uri _url = Uri.parse("https://github.com/yunusemrekaplan");

  // ignore: unused_element
  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Url Adresi Bulunamadı: $_url');
    }
  }
}
