import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iqttv_play/constants/colors.dart';
import 'package:iqttv_play/screens/loading_screen.dart';
import 'package:iqttv_play/screens/video_player_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoading = true;
  int _selectedIndex = 1;

  Future<void> _loadApp() async {
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _loadApp();
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.openSansTextTheme(ThemeData().textTheme),
        colorScheme: ColorScheme(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          tertiary: AppColors.accent,
          surface: Colors.white,
          error: Colors.red,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.black,
          onError: Colors.white,
          brightness: Brightness.light,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home:
          _isLoading
              ? LoadingScreen()
              : Scaffold(
                backgroundColor: const Color.fromARGB(100, 10, 10, 100),
                appBar: AppBar(
                  backgroundColor: AppColors.background,
                  title: Center(
                    child: Image.asset('assets/img/app_icon.png', height: 50),
                  ),
                ),
                body: SafeArea(child: _getSelectedScreen()),
                bottomNavigationBar: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  elevation: 5.0,
                  backgroundColor: AppColors.background,
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Colors.white30,
                  selectedFontSize: 12.0,
                  iconSize: 20.0,
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Inicio',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.live_tv),
                      label: 'En vivo',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.podcasts),
                      label: 'Podcast',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.back_hand),
                      label: 'Síguenos',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.mail),
                      label: 'Contacto',
                    ),
                  ],
                  currentIndex: _selectedIndex,
                  onTap: (index) {
                    if (index == 1) {
                      _onItemTapped;
                    }
                  },
                ),
              ),
    );
  }

  Widget _getSelectedScreen() {
    switch (_selectedIndex) {
      case 0:
        return const Center(child: Text('Inicio'));
      case 1:
        return VideoPlayerScreen();
      case 2:
        return const Center(child: Text('Podcast'));
      case 3:
        return const Center(child: Text('Síguenos'));
      case 4:
        return const Center(child: Text('Contacto'));
      default:
        return SizedBox.shrink();
    }
  }
}
