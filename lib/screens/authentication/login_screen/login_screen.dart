import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:street_workout_final/authentication_handler.dart';
import 'package:street_workout_final/screens/authentication/recover_password_screen/recover_password_screen.dart';
import 'package:street_workout_final/widgets/snackbar.dart';
import '../../../services/authentication/authentication_method.dart';
import 'package:street_workout_final/utils/constants.dart';
import '../../../widgets/rounded_button.dart';
import '../../../widgets/text_field_input.dart';

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
      // Navigator.pop(context);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => AuthenticationHandler(),
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
          padding: EdgeInsets.all(kPaddingValue),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [buildColumn(), buildColumnInput(), buildColumnBottom(context)],
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
        SizedBox(
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
        SizedBox(
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
      children: [
        SizedBox(
          height: kPaddingValue,
        ),
        const Text(
          "Let's sign you in",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            letterSpacing: 1.1,
            fontSize: 35,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Welcome back",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w400,
          ),
        ),
        const Text(
          "You've been missed!",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(
          height: 64,
        ),
      ],
    );
  }
}
