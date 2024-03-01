import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';
import '../../../shared/widget/app_button.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_text_stlye.dart';
import '../controller/profile_controller.dart';

class ProfileLogoutDialog extends StatelessWidget {
  const ProfileLogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * .75,
      decoration: const BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(Sizes.l)),
      ),
      padding: const EdgeInsets.symmetric(vertical: Sizes.m),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(Sizes.m),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SvgPicture.asset("assets/illustrations/logout.svg"),
            VGap.r,
            Text(
              "Anda Yakin Untuk Keluar Aplikasi?",
              style: AppTextStyle.ts16Bold,
              textAlign: TextAlign.center,
            ),
            VGap.xs,
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 250,
                child: Text(
                  "Pastikan semua perubahan Anda disimpan dengan baik sebelum keluar dari Aplikasi. Kami selalu disini jika Anda kembali.",
                  style: AppTextStyle.ts12Reg.copyWith(color: AppColor.grey),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            VGap.xh,
            Obx(() {
              final state = controller.logoutButtonState.value;
              return AppButton(
                state: state,
                type: ButtonType.elevated,
                onPressed: controller.logout,
                backgroundColor: AppColor.red,
                child: const Text("Keluar Dari Aplikasi"),
              );
            }),
            VGap.s,
            AppButton(
              type: ButtonType.outlined,
              onPressed: Get.back,
              foregroundColor: AppColor.green,
              borderColor: AppColor.green,
              child: const Text("Batal"),
            ),
          ],
        ),
      ),
    );
  }
}
