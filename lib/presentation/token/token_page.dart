import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/route_manager.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import '../../shared/widget/app_button.dart';
import '../../shared/widget/app_textfield.dart';
import '../../theme/app_color.dart';
import '../../theme/app_text_stlye.dart';
import 'controller/token_controller.dart';

class TokenPage extends StatelessWidget {
  const TokenPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TokenController>();
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Isi Token", overflow: TextOverflow.ellipsis),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.m),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            VGap.l,
            VGap.l,
            Obx(() {
              final token = controller.profileController.profile.value?.token;
              return Text.rich(
                TextSpan(text: "Token DIGILIB Anda ", children: [
                  TextSpan(
                    text: token?.split(".")[0],
                    style: TextStyle(color: theme.primaryColor, fontWeight: FontWeight.bold),
                  )
                ]),
                style: AppTextStyle.ts16Reg,
              );
            }),
            VGap.r,
            SvgPicture.asset(
              "assets/illustrations/token.svg",
              width: 200,
            ),
            VGap.r,
            Text(
              "Tambah Token DIGILIB",
              style: AppTextStyle.ts16Bold,
            ),
            VGap.xs,
            SizedBox(
              width: 250,
              child: Text(
                "Masukkan kode voucher Anda sekarang dan nikmati buku yang ingin Anda baca.",
                style: AppTextStyle.ts12Reg,
                textAlign: TextAlign.center,
              ),
            ),
            VGap.l,
            AppTextField(
              type: TextFieldType.normal,
              controller: controller.voucherController,
              focusNode: controller.voucherFocusNode,
              onSubmitted: (text) {
                if (text.isEmpty) return;
                controller.redeem();
              },
              onTapOutside: (_) => controller.voucherFocusNode.unfocus(),
              onChanged: controller.onChanged,
              isError: false,
              label: const Text("Kode Voucher"),
            ),
            VGap.xh,
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Obx(() {
                  final state = controller.buttonState.value;
                  return AppButton(
                    state: state,
                    type: ButtonType.elevated,
                    onPressed: controller.redeem,
                    child: const Text("Isi Voucher"),
                  );
                }),
                VGap.s,
                GestureDetector(
                  onTap: controller.showVoucherInfo,
                  child: Text(
                    "Bagaimana cara mendapatkan Voucher?",
                    style: AppTextStyle.ts12Reg.copyWith(color: AppColor.black),
                    textAlign: TextAlign.center,
                  ),
                ),
                VGap.l,
                VGap.l,
              ],
            )
          ],
        ),
      ),
    );
  }
}
