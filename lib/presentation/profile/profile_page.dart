import 'package:flutter/material.dart';

import '../../constants/gaps.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_logout_button.dart';
import 'widgets/profile_settings.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ProfileHeader(isRead: false),
          VGap.r,
          ProfileSettings(),
          ProfileLogoutButton(),
        ],
      ),
    );
  }
}
