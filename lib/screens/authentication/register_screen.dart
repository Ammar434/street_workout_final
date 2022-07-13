import 'package:flutter/material.dart';
import 'user_information_gathering/welcome_screen.dart';
import '../../utils/constants.dart';
import '../../widgets/rounded_button.dart';
import '../../widgets/text_field_input.dart';

class RegisterScreen extends StatefulWidget {
  static const String name = "registerScreen";

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final TextEditingController _userNameController = TextEditingController();

  void onTap() {
    //Verif Et creation des users dans firebase
    Navigator.pushNamed(context, WelcomeScreen.name);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    _userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(kPaddingValue),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildColumn(),
              buildColumnInput(),
              RoundedButton(onTap: onTap, text: "Register"),
            ],
          ),
        ),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Hey Welcome",
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
          "Let's create your account!",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(
          height: 64,
        ),
        Center(
          child: Stack(
            children: [
              const CircleAvatar(
                radius: 64,
                backgroundImage: NetworkImage(
                    "https://images.pexels.com/photos/12339648/pexels-photo-12339648.jpeg"),
              ),
              Positioned(
                bottom: -10,
                right: -10,
                child: IconButton(
                  icon: const Icon(Icons.add_a_photo),
                  onPressed: () {},
                ),
              )
            ],
          ),
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
          textEditingController: _userNameController,
          hintText: "Username",
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
        const SizedBox(
          height: kPaddingValue,
        ),
        TextFieldInput(
          textEditingController: _passwordController,
          hintText: "Confirm Password",
          textInputType: TextInputType.visiblePassword,
          isPassword: true,
        ),
      ],
    );
  }
}
