import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';
import '../../../../widgets/loading_widget.dart';
import '../../profile_screen/profile_screen.dart';

class DrawerTopWidget extends StatelessWidget {
  const DrawerTopWidget({
    Key? key,
    required this.profileImage,
    required this.userName,
    required this.userUid,
    required this.userCity,
    required this.isLoading,
  }) : super(key: key);
  final String profileImage;
  final String userName;
  final String userUid;
  final String userCity;
  final bool isLoading;
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
                  isLoading
                      ? const LoadingWidget(
                          isLinear: true,
                        )
                      : Text(
                          userCity,
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
