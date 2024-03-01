import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

import '../../../api/voucher-info/model/model_voucher_info_all.dart' as v;
import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';
import '../../../shared/widget/app_button.dart';
import '../../../theme/app_text_stlye.dart';
import '../../index/controller/index_controller.dart';
import '../controller/token_controller.dart';
import 'token_info_card.dart';

class TokenInfo extends StatelessWidget {
  const TokenInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      alignment: Alignment.topCenter,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: Sizes.m, vertical: Sizes.r),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Anda bisa mendapatkan Voucher Token DIGILIB melalui beberapa platform dibawah",
            style: AppTextStyle.ts14Reg,
          ),
          VGap.r,
          Expanded(
            child: SingleChildScrollView(
              child: Obx(() {
                final controller = Get.find<TokenController>();
                final indexController = Get.find<IndexController>();
                final options = controller.listInfoVoucher.value;
                final perpustakaan = controller.profileController.profile.value?.perpustakaan;
                final urlLogo = indexController.perpustakaan.value?.assetLogo?.id;
                return Column(
                  children: [
                    TokenInfoCard(
                      option: v.GetVoucher(
                        judul: perpustakaan?.nama ?? '-',
                        link: "https://api.whatsapp.com/send?phone=${perpustakaan?.noTelepon}",
                        icon: v.Icon(id: urlLogo),
                      ),
                    ),
                    VGap.s,
                    for (v.GetVoucher option in options ?? []) ...[
                      TokenInfoCard(option: option),
                      VGap.s,
                    ]
                  ],
                );
              }),
            ),
          ),
          VGap.s,
          AppButton(
            type: ButtonType.outlined,
            onPressed: Get.back,
            child: Text(
              "Batal",
              style: AppTextStyle.ts14Bold,
            ),
          )
        ],
      ),
    );
  }
}
