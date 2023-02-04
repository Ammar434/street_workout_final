import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';
import '../utils/dimension.dart';
import '../widgets/loading_widget.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({Key? key, required this.webScreenLayout, required this.mobileScreenLayout}) : super(key: key);
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of(context);
    if (userProvider.getUser == null) {
      return const LoadingWidget();
    }

    return LayoutBuilder(
      builder: (context, raints) {
        if (raints.maxWidth > webScreenSize) {
          return webScreenLayout;
        }
        return mobileScreenLayout;
      },
    );
  }
}

// class ResponsiveLayout extends StatefulWidget {
//   final Widget webScreenLayout;
//   final Widget mobileScreenLayout;

//   const ResponsiveLayout({Key? key, required this.webScreenLayout, required this.mobileScreenLayout}) : super(key: key);

//   @override
//   State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
// }

// class _ResponsiveLayoutState extends State<ResponsiveLayout> {
//   bool isLoading = false;
//   @override
//   void initState() {
//     super.initState();
//     getData();
//   }

//   void getData() async {
//     setState(() {
//       isLoading = true;
//     });

//     // UserProvider userProvider = Provider.of(context, listen: false);
//     // await userProvider.refreshUser();

//     setState(() {
//       isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {}
// }
