import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/route_manager.dart';

import '../../api/api_path.dart';
import '../../api/perpustakaan/model/model_perpustakaan.dart';
import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import '../../theme/app_text_stlye.dart';
import 'controller/auth_user_controller.dart';
import 'widgets/auth_forgot_form.dart';
import 'widgets/auth_login_form.dart';

class AuthUserPage extends StatelessWidget {
  const AuthUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final controller = Get.find<AuthUserController>();
    final perpustakaan = Get.arguments as Perpustakaan;
    controller.perpustakaan = perpustakaan;
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(Sizes.m),
                    bottomRight: Radius.circular(Sizes.m),
                  ),
                ),
                width: size.width,
                padding: const EdgeInsets.all(24),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(100)),
                          image: perpustakaan.assetLogo != null
                              ? DecorationImage(
                                  image: NetworkImage(APIPath.publicAsset(perpustakaan.assetLogo?.id ?? "")),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                      ),
                      VGap.m,
                      Text(
                        controller.perpustakaan?.nama ?? "-",
                        style: AppTextStyle.ts16Bold.copyWith(color: Colors.white),
                      ),
                      VGap.m,
                    ],
                  ),
                ),
              ),
              VGap.l,
              Obx(() {
                final isforgot = controller.isForgot.value;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Sizes.m),
                  child: isforgot ? AuthForgotForm(controller: controller) : AuthLoginForm(controller: controller),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
