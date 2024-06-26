import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "../../../common_libs.dart";
import 'package:provider/provider.dart';

import '../../../models/custom_user.dart';
import '../../../provider/user_provider.dart';
import '../../../services/authentication/authentication_method.dart';
import '../../../services/url_launcher.dart';
import 'account_settings/account_settings_screen.dart';
import 'components/custom_alert_dialog.dart';
import 'components/settings_group.dart';
import 'components/settings_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomUser customUser = Provider.of<UserProvider>(context).getUser!;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kPaddingValue),
      child: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
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
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AccountSettingsScreen(customUser: customUser),
                    ),
                  );
                },
              ),
              SettingsTile(
                icon: Icons.notifications,
                iconBackgroundColor: Colors.orange,
                text1: "Notifications",
                text2: "Newsletter, App Updates",
                isArrow: true,
                press: () {
                  // Navigator.pushNamed(context, AccountNotificationScreen.name);
                },
              ),
              SettingsTile(
                icon: Icons.logout_sharp,
                iconBackgroundColor: Colors.teal,
                text1: "Logout",
                text2: "",
                isArrow: false,
                press: () async {
                  await AuthenticationMethod().signOut();
                },
              ),
              SettingsTile(
                icon: Icons.delete,
                iconBackgroundColor: Colors.red,
                text1: "Delete Account",
                text2: "",
                isArrow: false,
                press: () {
                  showDialog(
                    context: context,
                    builder: (context) => const CustomDialogBox(),
                  );
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
                press: () => writeEmail(),
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
          SettingsGroup(
            textSettingGroup: 'Others',
            widgetList: [
              SettingsTile(
                icon: Icons.lock,
                iconBackgroundColor: const Color(0xff009cde),
                text1: "Privacy and security",
                text2: "",
                isArrow: false,
                press: () async {
                  await openUrl(context, privacyPolicy);
                },
              ),
              SettingsTile(
                icon: FontAwesomeIcons.gift,
                iconBackgroundColor: const Color(0xffFF5F5F),
                text1: "Checkout Our Others Apps!",
                text2: "",
                isArrow: false,
                press: () async {
                  // await openUrl(context, paypalUrl);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
