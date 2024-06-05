import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import '../../theme/app_color.dart';
import '../../theme/app_text_stlye.dart';
import '../../utils/launch_url.dart';
import 'controller/faq_controller.dart';
import 'widgets/faq_card.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FAQController>();
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pusat Bantuan"),
      ),
      body: RefreshIndicator(
        onRefresh: controller.onInit,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: Sizes.m),
          child: Column(
            children: [
              Image.asset(
                "assets/logo/orbit-digilib-logo.png",
                width: size.width / 2,
              ),
              VGap.s,
              Text("ORBIT DIGILIB", style: AppTextStyle.ts18Bold),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Dikembangkan oleh ", style: AppTextStyle.ts12Reg),
                  Text(
                    "ORBIT EDUTECH",
                    style: AppTextStyle.ts12Bold.copyWith(color: AppColor.orange),
                  ),
                ],
              ),
              VGap.m,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.m),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Menemukan kendala perihal Aplikasi Orbit Digilib?",
                          style: AppTextStyle.ts10Bold,
                        ),
                        Text.rich(
                          TextSpan(
                            text: "Aplikasi mengalami masalah? berjalan tidak sebagaimana mestinya?\n",
                            children: [
                              TextSpan(
                                text: "Hubungi Kami!",
                                style: AppTextStyle.ts10Bold.copyWith(color: theme.primaryColor),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    const String url =
                                        "https://api.whatsapp.com/send?phone=6285161400360&text=Halo!%20Saya%20NAMA%20ANDA%20dari%20ASAL%20SEKOLAH.%20Saya%20ingin%20melaporkan%20terkait%20masalah%20Aplikasi%20Orbit%20Digilib.%20(Ceritakan%20masalahmu%20di%20sini)";
                                    await launchUrl(url);
                                  },
                              ),
                            ],
                          ),
                          style: AppTextStyle.ts10Light,
                        )
                      ],
                    ),
                    VGap.s,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Buku yang Anda cari tidak ada?",
                          style: AppTextStyle.ts10Bold,
                        ),
                        Text.rich(
                          TextSpan(
                            text: "Anda menemukan kendala perihal Buku atau hal-hal yang terkait dengan perpustakaan?\n",
                            children: [
                              TextSpan(
                                text: "Hubungi Perpustakaan!",
                                style: AppTextStyle.ts10Bold.copyWith(color: theme.primaryColor),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    const String url =
                                        "https://api.whatsapp.com/send?phone=6285161400360&text=Halo!%20Saya%20NAMA%20ANDA%20dari%20ASAL%20SEKOLAH.%20Saya%20ingin%20melaporkan%20terkait%20masalah%20(Ceritakan%20masalahmu%20di%20sini)";
                                    await launchUrl(url);
                                  },
                              ),
                            ],
                          ),
                          style: AppTextStyle.ts10Light,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              VGap.m,
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: Sizes.m),
                child: Text(
                  "Daftar Pertanyaan Umum",
                  style: AppTextStyle.ts14Bold,
                ),
              ),
              Obx(() {
                final listFAQ = controller.listFAQ.value;
                if (listFAQ == null) {
                  return Column(
                    children: List.generate(10, (index) => index).map((e) {
                      return Container(
                        height: 20,
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: Sizes.m, vertical: Sizes.xs),
                        decoration: const BoxDecoration(
                          color: AppColor.lightGrey,
                          borderRadius: BorderRadius.all(
                            Radius.circular(Sizes.xs),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }
                return ListView.builder(
                  itemCount: listFAQ.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final faq = listFAQ[index];
                    return FAQCard(faq: faq);
                  },
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
