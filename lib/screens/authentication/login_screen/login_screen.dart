import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";

import '../../../authentication_handler.dart';
import '../../../services/authentication/authentication_method.dart';
import 'components/login_screen_body.dart';


class LoginScreen extends StatefulWidget {
  static String name = "loginScreen";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
  void loginUser() async {
    setState(() {
      isLoading = true;
    });
    String res = await AuthenticationMethod().loginUser(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (!mounted) return;
    if (res == "success") {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const AuthenticationHandler()),
        (route) => false,
      );
    } else {
      customShowSnackBar(
        globalKey: _scaffoldKey,
        title: "Warning",
        content: res,
        contentType: ContentType.failure,
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: LoginScreenBody(
          emailController: _emailController,
          passwordController: _passwordController,
          isLoading: isLoading,
          loginUser: loginUser,
        ),
      ),
    );
  }
}
