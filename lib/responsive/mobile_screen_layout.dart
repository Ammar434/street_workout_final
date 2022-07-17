import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:street_workout_final/models/custom_user.dart';
import 'package:street_workout_final/provider/user_provider.dart';
import 'package:street_workout_final/screens/application/main_screen.dart';

class MobileScreenLayout extends StatelessWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomUser customUser = Provider.of<UserProvider>(context).getUser;
    return const MainScreen();
    // return StreamBuilder(
    // stream: FirebaseAuth.instance.authStateChanges(),
    // builder: (context, snapshot) {
    //   if (snapshot.connectionState == ConnectionState.active) {
    //     if (snapshot.hasData) {
    //       return const MainScreen();
    //     } else if (snapshot.hasError) {
    //       return const Center(
    //         child: Text(
    //           "Some internal error happen please contact the developper",
    //         ),
    //       );
    //     }
    //   }
    //   if (snapshot.connectionState == ConnectionState.waiting) {
    //     return const Center(
    //       child: CircularProgressIndicator(
    //         color: primaryColor,
    //       ),
    //     );
    //   }
    //   return const AuthScreen();
    // },
    // )
  }
}
