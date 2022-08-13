import 'package:faker_dart/faker_dart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../provider/user_provider.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/constants.dart';

class ParcInfoCommentsTab extends StatefulWidget {
  const ParcInfoCommentsTab({
    Key? key,
  }) : super(key: key);

  @override
  State<ParcInfoCommentsTab> createState() => _ParcInfoCommentsTabState();
}

class _ParcInfoCommentsTabState extends State<ParcInfoCommentsTab> {
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        bottomNavigationBar: buildBottomNavigationBar(userProvider),
        body: ListView.builder(
          itemCount: 30,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(kSmallPaddingValue),
              child: ListTile(
                tileColor: tertiaryColor.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kRadiusValue),
                ),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(Faker.instance.image.image()),
                  radius: 22,
                ),
                title: Text(
                  Faker.instance.name.firstName(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(Faker.instance.datatype.string()),
              ),
            );
          },
        ),
      ),
    );
  }

  Padding buildBottomNavigationBar(UserProvider userProvider) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kSmallPaddingValue, vertical: kPaddingValue),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(color: tertiaryColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(color: tertiaryColor),
          ),
          contentPadding: EdgeInsets.all(kPaddingValue),
          hintText: 'Add a comment',
          prefixIcon: Container(
            margin: const EdgeInsets.all(4.0),
            width: 48.0,
            height: 48.0,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black45,
                  offset: Offset(0, 2),
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: CircleAvatar(
              child: ClipOval(
                child: Image(
                  height: 48.0,
                  width: 48.0,
                  image: NetworkImage(userProvider.getUser.profileImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              debugPrint("Post Comments");
            },
            child: Container(
              margin: const EdgeInsets.only(right: 4.0),
              width: 70.0,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(kRadiusValue * 5),
              ),
              child: const Icon(
                Icons.send,
                size: 25.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
