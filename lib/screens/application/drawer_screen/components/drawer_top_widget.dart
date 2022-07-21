import 'package:faker_dart/faker_dart.dart';
import 'package:flutter/material.dart';
import 'package:street_workout_final/screens/application/profile_screen/profile_screen.dart';
import 'package:street_workout_final/utils/constants.dart';

class DrawerTopWidget extends StatelessWidget {
  const DrawerTopWidget({
    Key? key,
    required this.profileImage,
    required this.userName,
    required this.userUid,
  }) : super(key: key);
  final String profileImage;
  final String userName;
  final String userUid;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileScreen(userUid: userUid),
          ),
        );
        // Navigator.pushNamed(
        //   context,
        //   ProfileScreen.name,
        //   arguments: {
        //     'userUid': userUid,
        //   },
        // );
      },
      child: Column(
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                width: 5,
              ),
              CircleAvatar(
                radius: 26,
                backgroundImage: NetworkImage(profileImage),
              ),
              const SizedBox(
                width: kPaddingValue,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: const TextStyle(fontWeight: FontWeight.w900),
                    maxLines: 2,
                  ),
                  Text(
                    Faker.instance.address.city(),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
