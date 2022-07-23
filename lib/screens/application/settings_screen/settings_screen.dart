import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/custom_user.dart';
import '../../../provider/user_provider.dart';
import '../../../services/authentication/authentication_method.dart';
import '../../../utils/constants.dart';
import 'account_settings_screen.dart';
import 'components/profile_image_update_setting_screen.dart';
import 'components/settings_group.dart';
import 'components/settings_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomUser customUser = Provider.of<UserProvider>(context).getUser;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPaddingValue),
      child: ListView(
        shrinkWrap: true,
        children: [
          ProfileImageUpdateSettingScreen(customUser: customUser),
          const SizedBox(
            height: kPaddingValue,
          ),
          SettingsGroup(
            textSettingGroup: "General",
            widgetList: [
              SettingsTile(
                icon: Icons.person,
                iconBackgroundColor: Colors.green,
                text1: "Account Settings",
                text2: "Changer your personal data",
                isArrow: true,
                press: () {
                  Navigator.pushNamed(context, AccountSettingsScreen.name);
                },
              ),
              SettingsTile(
                icon: Icons.notifications,
                iconBackgroundColor: Colors.orange,
                text1: "Notifications",
                text2: "Newsletter, App Updates",
                isArrow: true,
                press: () {},
              ),
              SettingsTile(
                icon: Icons.logout_sharp,
                iconBackgroundColor: Colors.teal,
                text1: "Logout",
                text2: "",
                isArrow: false,
                press: () async {
                  await AuthenticationMethod().signOut();

                  // context.read<AuthenticationService>().signOut();
                },
              ),
              SettingsTile(
                icon: Icons.delete,
                iconBackgroundColor: Colors.red,
                text1: "Delete Account",
                text2: "",
                isArrow: false,
                press: () {
                  // context.read<AuthenticationService>().deleteUser();

                  // Navigator.of(context).pop();
                },
              ),
            ],
          ),
          SettingsGroup(
            textSettingGroup: 'Feedback',
            widgetList: [
              SettingsTile(
                icon: Icons.bug_report,
                iconBackgroundColor: Colors.purple,
                text1: "Report a bug",
                text2: "",
                isArrow: false,
                press: () {},
              ),
              SettingsTile(
                icon: Icons.thumb_up,
                iconBackgroundColor: Colors.pink,
                text1: "Sent a feedback",
                text2: "",
                isArrow: false,
                press: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
