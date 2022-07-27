import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:street_workout_final/authentication_handler.dart';
import 'package:street_workout_final/responsive/mobile_screen_layout.dart';
import 'package:street_workout_final/responsive/web_screen_layout.dart';
import 'package:street_workout_final/widgets/snackbar.dart';
import '../../../responsive/responsive_layout.dart';
import '../../../services/authentication/authentication_method.dart';
import 'recover_password_screen.dart';
import '../../../utils/constants.dart';
import '../../../widgets/rounded_button.dart';
import '../../../widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  static const String name = "loginScreen";

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
      // Navigator.pop(context);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const AuthenticationHandler(),
        ),
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
        body: Padding(
          padding: const EdgeInsets.all(kPaddingValue),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildColumn(),
              buildColumnInput(),
              buildColumnBottom(context)
            ],
          ),
        ),
      ),
    );
  }

  Column buildColumnBottom(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Forgot your password?",
              style: TextStyle(
                color: Theme.of(context).disabledColor,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RecoverPasswordScreen.name);
              },
              child: const Text(
                "Restore",
                style: TextStyle(),
              ),
            )
          ],
        ),
        const SizedBox(
          height: kPaddingValue,
        ),
        RoundedButton(
          onTap: loginUser,
          text: "Log in",
          isLoading: isLoading,
        ),
      ],
    );
  }

  Column buildColumnInput() {
    return Column(
      children: [
        TextFieldInput(
          textEditingController: _emailController,
          hintText: "Email",
          textInputType: TextInputType.emailAddress,
        ),
        const SizedBox(
          height: kPaddingValue,
        ),
        TextFieldInput(
          textEditingController: _passwordController,
          hintText: "Password",
          textInputType: TextInputType.visiblePassword,
          isPassword: true,
        ),
      ],
    );
  }

  Column buildColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        SizedBox(
          height: kPaddingValue,
        ),
        Text(
          "Let's sign you in",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            letterSpacing: 1.1,
            fontSize: 35,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Welcome back",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          "You've been missed!",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(
          height: 64,
        ),
      ],
    );
  }
}
