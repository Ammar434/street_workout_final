import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

import '../../../services/authentication/authentication_method.dart';
import '../../../utils/constants.dart';
import '../../../widgets/rounded_button.dart';
import '../../../widgets/snackbar.dart';
import '../../../widgets/text_field_input.dart';
import 'components/recover_password_screen_mid.dart';
import 'recover_password_confirm_screen.dart';

class RecoverPasswordScreen extends StatefulWidget {
  static String name = "RecoverPasswordScreen";

  const RecoverPasswordScreen({Key? key}) : super(key: key);

  @override
  State<RecoverPasswordScreen> createState() => _RecoverPasswordScreenState();
}

class _RecoverPasswordScreenState extends State<RecoverPasswordScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  late TextEditingController _emailController;

  bool isLoading = false;

  void onTap() async {
    setState(() {
      isLoading = true;
    });
    String responseCode = await AuthenticationMethod().resetPassword(
      email: _emailController.text,
    );
    if (!mounted) return;
    if (responseCode == "success") {
      Navigator.pushReplacementNamed(context, RecoverPasswordConfirmScreen.name);
    } else {
      customShowSnackBar(
        title: "Warning",
        content: responseCode,
        contentType: ContentType.failure,
        globalKey: _scaffoldKey,
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        key: _scaffoldKey,
        body: Padding(
          padding: EdgeInsets.all(kPaddingValue),
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Flexible(child: SizedBox()),
                  AspectRatio(
                    aspectRatio: 4 / 3,
                    child: Image.asset(
                      "assets/images/authentication/image5_authentication.png",
                    ),
                  ),
                  const RecoverPasswordScreenMid(),
                  TextFieldInput(
                    textEditingController: _emailController,
                    hintText: "Email",
                    textInputType: TextInputType.emailAddress,
                  ),
                  RoundedButton(
                    onTap: onTap,
                    isLoading: isLoading,
                    text: "Reset",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
