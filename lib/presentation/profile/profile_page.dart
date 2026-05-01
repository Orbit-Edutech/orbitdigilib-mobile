import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';

import '../../constants/gaps.dart';
import '../../utils/responsive_helper.dart';
import 'controller/profile_controller.dart';
import 'widgets/kartu_anggota_widget.dart';
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const ProfileHeader(isRead: false),
                      VGap.r,
                      Obx(() {
                        final controller = Get.find<ProfileController>();
                        if (controller.profile.value != null) {
                          return const KartuAnggotaWidget();
                        }
                        return const SizedBox.shrink();
                      }),
                      VGap.r,
                      const ProfileSettings(),
                    ],
                  ),
                ),
              ),
              const ProfileLogoutButton(),
            ],
          ),
        ),
      ),
    );
  }
}
