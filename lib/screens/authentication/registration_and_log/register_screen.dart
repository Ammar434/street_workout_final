import 'dart:typed_data';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../../../services/authentication/authentication_method.dart';
import '../../../services/image_picker.dart';
import '../../../utils/constants.dart';
import '../../../widgets/snackbar.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/rounded_button.dart';
import '../../../widgets/text_field_input.dart';

import '../user_information_gathering/welcome_screen.dart';

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
  late Uint8List _image;

  void onTap() async {
    setState(() {
      isLoading = true;
    });
    String responseCode = await AuthenticationMethod().checkInfoRegisterUser(
      email: _emailController.text,
      password: _passwordController.text,
      passwordConfirm: _passwordConfirmController.text,
      userName: _userNameController.text,
      profileImage: _image,
    );
    if (!mounted) return;
    if (responseCode == "success") {
      Navigator.pushNamed(context, WelcomeScreen.name);
    } else {
      showSnackBar(
        context: context,
        title: "Warning",
        content: responseCode,
        contentType: ContentType.failure,
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  void selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(
      () {
        _image = image;
      },
    );
  }

  void loadDefaultImage() async {
    setState(() {
      isLoading = true;
    });
    ByteData bytes = await rootBundle.load(
      "assets/images/authentication/default_profile.png",
    );
    _image = bytes.buffer.asUint8List();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadDefaultImage();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    _userNameController.dispose();
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // set it to false
      body: isLoading
          ? const LoadingWidget()
          : Padding(
              padding: const EdgeInsets.all(kPaddingValue),
              child: SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildTopColumn(),
                      buildColumnInput(),
                      RoundedButton(
                        onTap: onTap,
                        text: "Register",
                        isLoading: isLoading,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Column buildTopColumn() {
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
              CircleAvatar(
                radius: 56,
                backgroundImage: MemoryImage(_image),
              ),
              Positioned(
                bottom: -10,
                right: -10,
                child: IconButton(
                  icon: const Icon(Icons.add_a_photo),
                  onPressed: selectImage,
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
          textEditingController: _passwordConfirmController,
          hintText: "Confirm Password",
          textInputType: TextInputType.visiblePassword,
          isPassword: true,
        ),
      ],
    );
  }
}
