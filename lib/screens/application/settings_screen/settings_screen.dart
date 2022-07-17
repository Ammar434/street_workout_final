import 'package:faker_dart/faker_dart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:street_workout_final/services/authentication/authentication_method.dart';
import 'package:street_workout_final/utils/colors.dart';
import 'package:street_workout_final/utils/constants.dart';

import 'components/settings_group.dart';
import 'components/settings_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPaddingValue),
      child: ListView(
        shrinkWrap: true,
        children: [
          Row(
            children: [
              Expanded(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          NetworkImage(Faker.instance.image.image()),
                      radius: kRadiusValue * 5,
                      backgroundColor: secondaryColor,
                    ),
                    Positioned(
                      right: -5,
                      top: 0,
                      child: GestureDetector(
                        onTap: () {
                          debugPrint("Change image");
                        },
                        child: const CircleAvatar(
                          backgroundColor: tertiaryColor,
                          radius: kRadiusValue * 2,
                          child: Center(
                            child: FaIcon(
                              FontAwesomeIcons.pen,
                              size: 15,
                              // color: backgroundColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  Faker.instance.name.fullName(),
                  style: const TextStyle(
                    // color: primaryColor,
                    fontWeight: FontWeight.bold,
                    // fontSize: SizeConfig.textMultiplier * 3,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
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
                  // Navigator.pushNamed(context, accountSetting);
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
                icon: Icons.logout,
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
