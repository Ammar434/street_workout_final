import 'package:flutter/material.dart';
import 'package:street_workout_final/utils/constants.dart';

class CategorieBuilder extends StatelessWidget {
  const CategorieBuilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Discover"),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.all(kPaddingValue / 2),
                width: 150,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kRadiusValue),
                  color: Colors.blueAccent.shade100,
                ),
                child: const Center(child: Text('bar')),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
