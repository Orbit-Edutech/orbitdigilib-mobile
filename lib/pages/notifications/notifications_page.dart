import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_color.dart';
import '../../theme/app_text_stlye.dart';
import 'controller/notifications_controller.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NotificationsController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifikasi"),
      ),
      body: ListView.builder(
          itemCount: 20,
          itemBuilder: (ctx, idx) {
            if (idx == 0) {
              return InkWell(
                onTap: () => controller.showMarkAsReadDialog,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Sizes.m, vertical: Sizes.r),
                      child: Text(
                        "Tandai Semua Telah Dibaca",
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Divider(height: 0),
                  ],
                ),
              );
            }
            return InkWell(
              onTap: () => Get.toNamed(AppRoutes.notification),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.m, vertical: Sizes.s),
                color: idx.isOdd ? Colors.grey.shade100 : AppColor.bgScaffold,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (idx.isOdd)
                          Container(
                            width: Sizes.s,
                            height: Sizes.s,
                            margin: const EdgeInsets.only(right: Sizes.s),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.red,
                            ),
                          ),
                        Expanded(
                          child: Text(
                            "Judul Notifikasi",
                            style: AppTextStyle.ts14Bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Lorem Ipsum dolor sit amet ABCD Lorem Ipsum DOlor Sit Amet two lines of words  Lorem Ipsum DOlor Sit Amet",
                      style: AppTextStyle.ts12Reg,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    VGap.s,
                    Text(
                      "20 Desember 2023, 08:30 WIB",
                      style: AppTextStyle.ts10Light.copyWith(color: AppColor.grey),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
