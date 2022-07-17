import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:street_workout_final/responsive/mobile_screen_layout.dart';
import 'package:street_workout_final/responsive/responsive_layout.dart';
import 'package:street_workout_final/responsive/web_screen_layout.dart';
import 'package:street_workout_final/screens/authentication/auth_screen.dart';
import 'utils/colors.dart';

class AuthenticationHandler extends StatelessWidget {
  const AuthenticationHandler({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return const ResponsiveLayout(
              webScreenLayout: WebScreenLayout(),
              mobileScreenLayout: MobileScreenLayout(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Some internal error happen please contact the developper",
              ),
            );
          }
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: primaryColor,
            ),
          );
        }
        return const AuthScreen();
      },
    );
  }
}
