import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:street_workout_final/widgets/loading_widget.dart';
import 'responsive/mobile_screen_layout.dart';
import 'responsive/responsive_layout.dart';
import 'responsive/web_screen_layout.dart';
import 'screens/authentication/auth_screen/auth_screen.dart';

class AuthenticationHandler extends StatelessWidget {
  AuthenticationHandler({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return ResponsiveLayout(
              webScreenLayout: WebScreenLayout(),
              mobileScreenLayout: MobileScreenLayout(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Some internal error happen please contact the developper",
              ),
            );
          }
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: LoadingWidget(),
          );
        }
        return AuthScreen();
      },
    );
  }
}
