import 'package:faker_dart/faker_dart.dart';
import 'package:flutter/material.dart';
import 'package:street_workout_final/utils/constants.dart';

class DrawerTopWidget extends StatelessWidget {
  const DrawerTopWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              width: 5,
            ),
            CircleAvatar(
              radius: 26,
              backgroundImage: NetworkImage(
                Faker.instance.image.image(),
              ),
            ),
            const SizedBox(
              width: kPaddingValue,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Faker.instance.name.lastName(),
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
    );
  }
}
