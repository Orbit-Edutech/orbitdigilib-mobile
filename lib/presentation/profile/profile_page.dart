import 'package:flutter/material.dart';

import '../../constants/gaps.dart';
import '../../utils/responsive_helper.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_logout_button.dart';
import 'widgets/profile_settings.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: ResponsiveHelper.getMaxContentWidth(context),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ProfileHeader(isRead: false),
                      VGap.r,
                      ProfileSettings(),
                    ],
                  ),
                ),
              ),
              ProfileLogoutButton(),
            ],
          ),
        ),
      ),
    );
  }
}
