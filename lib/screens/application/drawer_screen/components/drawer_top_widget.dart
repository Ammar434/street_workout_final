import 'package:flutter/material.dart';
import "../../../../common_libs.dart";

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
                radius: kRadiusValueImageProfile * 0.5,
                backgroundImage: NetworkImage(profileImage),
              ),
              SizedBox(
                width: kPaddingValue,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: Theme.of(context).textTheme.titleSmall,
                    maxLines: 2,
                  ),
                  Row(
                    children: [
                      Visibility(
                        visible: isLoading,
                        child: SizedBox(width: kPaddingValue, height: kPaddingValue, child: const LoadingWidget()),
                      ),
                      SizedBox(
                        width: isLoading ? kSmallPaddingValue : 0,
                      ),
                      Text(
                        userCity,
                        style: Theme.of(context).textTheme.titleSmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
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
