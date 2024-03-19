import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/route_manager.dart';

import '../../../api/api_path.dart';
import '../../../api/buku-perpustakaan/model/model_one_buku_perpustakaan.dart';
import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';
import '../../../shared/widget/app_button.dart';
import '../../../shared/widget/app_divider.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_text_stlye.dart';
import '../../../utils/compute_luminance.dart';
import '../../profile/controller/profile_controller.dart';
import '../controller/book_controller.dart';
import 'book_option_card.dart';

class BookReadOptions extends StatelessWidget {
  const BookReadOptions({super.key, required this.payload});

  final BukuPerpustakaan? payload;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final profileController = Get.find<ProfileController>();
    return Container(
      height: size.height * .65,
      width: size.width,
      decoration: const BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(Sizes.l)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: Sizes.m, vertical: Sizes.r),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: Sizes.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 80,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(Sizes.s)),
                        image: DecorationImage(
                          image: NetworkImage(APIPath.publicAsset(payload?.buku?.assetSampulId ?? "-")),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    HGap.r,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            payload?.buku?.judul ?? "-",
                            style: AppTextStyle.ts14Bold,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          VGap.s,
                          Text(
                            payload?.buku?.penerbit?.nama ?? "-",
                            style: AppTextStyle.ts14Light,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          VGap.s,
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: Sizes.xs, horizontal: Sizes.s),
                            decoration: BoxDecoration(
                              color: theme.primaryColor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(Sizes.xh),
                              ),
                            ),
                            child: Text(
                              payload?.buku?.tahunTerbit ?? "-",
                              style: AppTextStyle.ts10Bold.copyWith(color: calculateLuminance(theme.primaryColor)),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                const AppDivider(height: Sizes.h),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: Sizes.xs, horizontal: Sizes.s),
                    decoration: BoxDecoration(
                      border: Border.all(color: theme.primaryColor),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(Sizes.xh),
                      ),
                    ),
                    child: Text(
                      "Sisa Token Anda ${profileController.profile.value?.token ?? 0}",
                      style: AppTextStyle.ts10Bold,
                    ),
                  ),
                ),
                VGap.l,
                OptionsCard(
                  title: "Pinjam",
                  subtitle: "(Gratis)",
                  suffix: "Tersedia: ${payload?.jumlahSiapPinjam ?? 0}",
                  enabled: (payload?.jumlahSiapPinjam ?? 0) > 0,
                ),
                VGap.s,
                OptionsCard(
                  title: "Sewa",
                  subtitle: "(${(payload?.buku?.hargaSewa ?? 0) ~/ 100} Token)",
                ),
                VGap.s,
                OptionsCard(
                  title: "Beli",
                  subtitle: "(${(payload?.buku?.hargaBeli ?? 0) ~/ 100} Token)",
                ),
              ],
            ),
            VGap.m,
            Obx(() {
              final controller = Get.find<BookController>();
              final state = controller.buttonState.value;
              return AppButton(
                state: state,
                type: ButtonType.elevated,
                onPressed: controller.submitOption,
                child: const Text("Kirim"),
              );
            }),
            VGap.s,
            AppButton(
              type: ButtonType.outlined,
              onPressed: Get.back,
              child: const Text("Tutup"),
            ),
          ],
        ),
      ),
    );
  }
}
