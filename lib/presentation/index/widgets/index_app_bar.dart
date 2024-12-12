import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';

import '../../../api/hak-akses/model/model_all_access.dart';
import '../../../constants/gaps.dart';
import '../../../routes/app_routes.dart';
import '../../../shared/widget/app_button.dart';
import '../../../theme/app_text_stlye.dart';
import '../controller/index_controller.dart';

class IndexAppBar extends StatefulWidget implements PreferredSizeWidget {
  const IndexAppBar({
    super.key,
  });

  @override
  State<IndexAppBar> createState() => _IndexAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

class _IndexAppBarState extends State<IndexAppBar> {
  bool isRead = false;
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<IndexController>();
    return AppBar(
      automaticallyImplyLeading: false,
      leading: DropdownButtonHideUnderline(
        child: Obx(() {
          final allAccess = controller.allAccess.value?.listAccess?.where((acc) => acc.hakAkses ?? false);
          final perpustakaan = controller.perpustakaan.value;
          return DropdownButton2(
            customButton: const Icon(
              Icons.arrow_drop_down,
              color: Colors.white,
            ),
            items: allAccess?.map((access) {
              return DropdownMenuItem<Access>(
                value: access,
                child: Text(
                  access.perpustakaan?.nama ?? "-",
                  style: AppTextStyle.ts18Reg,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              );
            }).toList(),
            onChanged: (value) {
              if (value?.perpustakaan?.nama == perpustakaan?.nama) return;
              Get.dialog(
                Obx(() {
                  final state = controller.changeAccessState.value;
                  return AlertDialog(
                    title: Text(
                      "Yakin ingin berpindah ke ${value?.perpustakaan?.nama}?",
                      style: AppTextStyle.ts18Reg,
                    ),
                    actions: [
                      AppButton(
                        state: state == ButtonState.loading ? ButtonState.disable : ButtonState.enable,
                        type: ButtonType.text,
                        onPressed: Get.back,
                        child: const Text("Batal"),
                      ),
                      AppButton(
                        state: state,
                        type: ButtonType.elevated,
                        onPressed: () => controller.changeAccess(value?.perpustakaan?.id ?? ""),
                        child: const Text("Pindah"),
                      ),
                    ],
                  );
                }),
                barrierDismissible: false,
              );
            },
            dropdownStyleData: DropdownStyleData(
              width: context.width,
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          );
        }),
      ),
      title: Row(
        children: [
          HGap.s,
          Expanded(
            child: Obx(() {
              final nama = controller.perpustakaan.value?.nama;
              return Text(
                nama ?? "-",
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.ts18Bold,
              );
            }),
          ),
        ],
      ),
      actions: [
        GestureDetector(
          onTap: () => Get.toNamed(AppRoutes.search),
          child: const Icon(Icons.search_rounded, size: 24),
        ),
        // TODO: Fitur notifikasi akan dikembangkan pada fase 2
        // HGap.r,
        // GestureDetector(
        //   onTap: () => Get.toNamed(AppRoutes.notifications),
        //   child: isRead
        //       ? SvgPicture.asset(
        //           "assets/icons/notifications.svg",
        //           height: 20,
        //           width: 24,
        //         )
        //       : SvgPicture.asset(
        //           "assets/icons/notifications-unread.svg",
        //           height: 20,
        //           width: 24,
        //         ),
        // ),
        HGap.m,
      ],
    );
  }
}
