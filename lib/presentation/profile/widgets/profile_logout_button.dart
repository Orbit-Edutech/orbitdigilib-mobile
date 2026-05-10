import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

import '../../../constants/sizes.dart';
import '../../../shared/widget/app_button.dart';
import '../../../utils/responsive_helper.dart';
import '../controller/profile_controller.dart';

class ProfileLogoutButton extends StatelessWidget {
  const ProfileLogoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.getHorizontalPadding(context),
        vertical: Sizes.r,
      ),
      child: AppButton(
        type: ButtonType.elevated,
        onPressed: controller.showLogoutDialog,
        child: const Text("Keluar"),
      ),
    );
  }
}
