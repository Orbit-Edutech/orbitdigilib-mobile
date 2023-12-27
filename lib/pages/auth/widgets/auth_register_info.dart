import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';

import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';
import '../../../shared/widget/app_button.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_text_stlye.dart';

class RegisterInfo extends StatelessWidget {
  const RegisterInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      alignment: Alignment.topCenter,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Sizes.l),
          topRight: Radius.circular(Sizes.l),
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(Sizes.m),
        child: Column(
          children: [
            VGap.m,
            SvgPicture.asset(
              "assets/illustrations/chart.svg",
              width: 200,
            ),
            VGap.m,
            Text("Daftar Akun", style: AppTextStyle.ts16Bold),
            VGap.xs,
            SizedBox(
              width: 250,
              // TODO: Copywriting untuk informasi pendaftaran
              child: Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                style: AppTextStyle.ts12Reg,
                textAlign: TextAlign.center,
              ),
            ),
            VGap.xh,
            AppButton(
              state: ButtonState.enable,
              type: ButtonType.elevated,
              backgroundColor: AppColor.whatsapp,
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/icons/whatsapp.svg",
                    width: 24,
                    height: 24,
                  ),
                  HGap.s,
                  Text(
                    "Hubungi kami",
                    style: AppTextStyle.ts14Bold,
                  ),
                ],
              ),
            ),
            AppButton(
              type: ButtonType.outlined,
              borderColor: AppColor.red,
              foregroundColor: AppColor.red,
              onPressed: Get.back,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Batal",
                    style: AppTextStyle.ts14Bold,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
