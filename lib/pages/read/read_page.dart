import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import '../../theme/app_color.dart';
import '../../theme/app_text_stlye.dart';
import '../../utils/compute_luminance.dart';
import '../profile/widgets/profile_logout_dialog.dart';
import 'controller/read_controller.dart';

class ReadPage extends StatelessWidget {
  const ReadPage({super.key});

  // TODO: Tidak boleh di ss, select text

  @override
  Widget build(BuildContext context) {
    final pdfKey = GlobalKey<SfPdfViewerState>();
    final controller = Get.find<ReadController>();
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Baca Buku"),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return const [
                PopupMenuItem(
                  child: Row(
                    children: [
                      Icon(
                        Icons.manage_search_rounded,
                        color: AppColor.black,
                      ),
                      HGap.s,
                      Text("Pencarian Kata"),
                    ],
                  ),
                ),
                PopupMenuItem(
                  child: Row(
                    children: [
                      Icon(
                        Icons.bookmark,
                        color: AppColor.black,
                      ),
                      HGap.s,
                      Text("Terakhir Dibaca"),
                    ],
                  ),
                ),
                PopupMenuItem(
                  child: Row(
                    children: [
                      Icon(
                        Icons.hotel_class_outlined,
                        color: AppColor.black,
                      ),
                      HGap.s,
                      Text("Bintangi Halaman"),
                    ],
                  ),
                ),
              ];
            },
            color: Colors.white,
            position: PopupMenuPosition.under,
            child: Icon(
              Icons.menu_rounded,
              color: calculateLuminance(theme.primaryColor),
            ),
          ),
          HGap.r,
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: Sizes.r,
              right: Sizes.m,
              left: Sizes.m,
              bottom: Sizes.s,
            ),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColor.lightGrey,
                ),
              ),
            ),
            child: Column(
              children: [
                Text(
                  "Judul Dari Buku Lorem Ipsum",
                  style: AppTextStyle.ts16Bold,
                  textAlign: TextAlign.center,
                ),
                Text(
                  "GoodNovel",
                  style: AppTextStyle.ts14Reg,
                ),
                Text(
                  "214 halaman",
                  style: AppTextStyle.ts10Light.copyWith(color: AppColor.grey),
                ),
              ],
            ),
          ),
          // Expanded(child: PDF)
          Expanded(
            child: Stack(
              children: [
                SfPdfViewer.asset(
                  "assets/icons/s.pdf",
                  key: pdfKey,
                  controller: controller.pdfController,
                  scrollDirection: PdfScrollDirection.horizontal,
                  onPageChanged: (details) => controller.currentPage.value = details.newPageNumber,
                  enableDoubleTapZooming: false,
                  pageSpacing: 0,
                  enableTextSelection: false,
                  onAnnotationSelected: (annotation) {},
                  onTextSelectionChanged: (details) {},
                  onTap: (details) {},
                ),
                Positioned.fill(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            print("Left");
                            controller.pdfController.previousPage();
                          },
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: () {
                            print(controller.pdfController.getAnnotations().toString());
                            controller.pdfController.removeAllAnnotations();
                            Get.bottomSheet(
                              const ProfileLogoutDialog(),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(Sizes.r)),
                              ),
                              isScrollControlled: true,
                              enableDrag: false,
                            );
                          },
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            controller.pdfController.nextPage();
                            print("Right");
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.r,
              horizontal: Sizes.m,
            ),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: AppColor.lightGrey),
              ),
            ),
            child: Obx(() {
              final currentPage = controller.currentPage.value;
              return GestureDetector(
                onTap: controller.search,
                child: Text(
                  currentPage.toString(),
                  textAlign: TextAlign.center,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
