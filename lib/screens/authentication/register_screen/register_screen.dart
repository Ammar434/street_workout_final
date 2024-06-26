import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import "../../../common_libs.dart";
import '../../../services/authentication/authentication_method.dart';
import '../../../services/image_picker.dart';
import '../../../widgets/loading_widget.dart';
import '../user_information_gathering/welcome_screen.dart';
import 'components/register_screen_body.dart';

class RegisterScreen extends StatefulWidget {
  static String name = "registerScreen";

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();

  late Uint8List _image;
  bool isLoading = false;
  bool isLoadingButton = false;

  void onTap() async {
    setState(() {
      isLoadingButton = true;
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
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
        (route) => false,
      );
    } else {
      customShowSnackBar(
        title: "Warning",
        content: responseCode,
        contentType: ContentType.failure,
        globalKey: _scaffoldKey,
      );
    }
    setState(() {
      isLoadingButton = false;
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

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const LoadingWidget()
        : Scaffold(
            key: _scaffoldKey,

            resizeToAvoidBottomInset: true, // set it to false
            body: RegisterScreenBody(
              image: _image,
              selectImage: selectImage,
              emailController: _emailController,
              passwordConfirmController: _passwordConfirmController,
              passwordController: _passwordController,
              userNameController: _userNameController,
              isLoading: isLoadingButton,
              onPageTransition: onTap,
            ),
          );
  }
}
