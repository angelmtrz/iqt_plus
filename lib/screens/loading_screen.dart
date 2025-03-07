import 'package:flutter/material.dart';
import 'package:iqttv_play/constants/colors.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/img/app_icon.png', height: 120),
            SizedBox(height: 20),
            CircularProgressIndicator(
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation(AppColors.secondary),
              strokeWidth: 5,
            ),
          ],
        ),
      ),
    );
  }
}
