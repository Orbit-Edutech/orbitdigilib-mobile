import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
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
        title: const Text("Notifikasi (50)"),
      ),
      body: Column(
        children: [
          InkWell(
            onTap: controller.showMarkAsReadDialog,
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
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (ctx, idx) {
                return NotificationCard(
                  notification: {"isRead": idx.isOdd},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationCard extends StatefulWidget {
  const NotificationCard({
    super.key,
    required this.notification,
  });

  final Map<String, dynamic> notification;

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  bool isOpen = false;
  bool isRead = false;
  @override
  void initState() {
    setState(() {
      isRead = widget.notification["isRead"];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => setState(() {
        isOpen = !isOpen;
        isRead = true;
      }),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.m, vertical: Sizes.s),
        color: !isRead ? Colors.grey.shade100 : AppColor.bgScaffold,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (!isRead)
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
              "Lorem Ipsum dolor sit amet ABCD Lorem Ipsum DOlor Sit Amet two lines of words  Lorem Ipsum DOlor Sit AmetLorem Ipsum dolor sit amet ABCD Lorem Ipsum DOlor Sit Amet two lines of words  Lorem Ipsum DOlor Sit AmetLorem Ipsum dolor sit amet ABCD Lorem Ipsum DOlor Sit Amet two lines of words  Lorem Ipsum DOlor Sit AmetLorem Ipsum dolor sit amet ABCD Lorem Ipsum DOlor Sit Amet two lines of words  Lorem Ipsum DOlor Sit AmetLorem Ipsum dolor sit amet ABCD Lorem Ipsum DOlor Sit Amet two lines of words  Lorem Ipsum DOlor Sit Amet",
              style: AppTextStyle.ts12Reg,
              maxLines: isOpen ? null : 2,
              overflow: isOpen ? null : TextOverflow.ellipsis,
              textAlign: TextAlign.justify,
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
  }
}
