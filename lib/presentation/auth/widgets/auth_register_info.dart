import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';

import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';
import '../../../shared/widget/app_button.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_text_stlye.dart';
import '../../../utils/launch_url.dart';

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
              child: Text(
                "Sebelum menggunakan aplikasi, silahkan registrasi akun terlebih dahulu.",
                style: AppTextStyle.ts12Reg,
                textAlign: TextAlign.center,
              ),
            ),
            VGap.xh,
            AppButton(
              state: ButtonState.enable,
              type: ButtonType.elevated,
              backgroundColor: AppColor.whatsapp,
              onPressed: () async {
                const String url =
                    "https://api.whatsapp.com/send?phone=6285161400360&text=Halo!%20Saya%20NAMA%20ANDA%20dari%20ASAL%20SEKOLAH.%20Saya%20ingin%20menggunakan%20ORBIT%20Digital%20Library%20untuk%20sekolah%20kami.%20Apakah%20bisa%20dibantu%20untuk%20tahap%20berikutnya%3F";
                await launchUrl(url);
              },
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
            VGap.s,
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
