import 'package:faker_dart/faker_dart.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/constants.dart';

class ParcInfoPhotosTab extends StatelessWidget {
  const ParcInfoPhotosTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: kSmallPaddingValue,
        crossAxisSpacing: kSmallPaddingValue,
      ),
      itemCount: 200,
      itemBuilder: (BuildContext context, int index) {
        return Image(
          image: NetworkImage(Faker.instance.image.image()),
        );
      },
    );
  }
}
