import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import '../../constants/sizes.dart';
import '../../shared/widget/empty_list.dart';
import '../../theme/app_color.dart';
import '../../theme/app_text_stlye.dart';
import 'controller/read_controller.dart';
import 'widgets/read_app_bar.dart';
import 'widgets/read_search_toolbar.dart';

class ReadPage extends StatefulWidget {
  const ReadPage({super.key});

  @override
  State<ReadPage> createState() => _ReadPageState();
}

class _ReadPageState extends State<ReadPage> {
  final MethodChannel _methodChannel = const MethodChannel("com.orbit360.digilib");

  @override
  void initState() {
    // _methodChannel.invokeMethod("secure", {"isSecure": true});
    super.initState();
  }

  @override
  void dispose() {
    _methodChannel.invokeMethod("secure", {"isSecure": false});
    super.dispose();
  }

  final controller = Get.find<ReadController>();
  final pdfKey = GlobalKey<SfPdfViewerState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: const ReadAppBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: AppColor.white,
                border: Border(
                  bottom: BorderSide(
                    color: AppColor.lightGrey,
                  ),
                ),
              ),
              child: Obx(() {
                final isOnSearch = controller.isOnSearch.value;
                if (isOnSearch) {
                  return SearchToolbar(
                    controller: controller.pdfController,
                    onTap: (toolbarItem) async {
                      if (toolbarItem.toString() == "onChanged") {
                        controller.noResultFound.value = false;
                      }
                      if (toolbarItem.toString() == 'Cancel Search') {
                        controller.isOnSearch.value = false;
                        controller.isFullScreen.value = false;
                        controller.noResultFound.value = false;
                      }
                      if (toolbarItem.toString() == 'noResultFound') {
                        controller.noResultFound.value = true;
                      }
                      if (toolbarItem.toString() == 'Clear Text') {
                        controller.noResultFound.value = false;
                      }
                    },
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(
                      top: Sizes.r,
                      right: Sizes.m,
                      left: Sizes.m,
                      bottom: Sizes.s,
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
                  );
                }
              }),
            ),
            Expanded(
              child: Obx(() {
                final noResultFound = controller.noResultFound.value;
                return Stack(
                  children: [
                    SfPdfViewerTheme(
                      data: SfPdfViewerThemeData(backgroundColor: AppColor.white),
                      child: SfPdfViewer.asset(
                        "assets/icons/s.pdf",
                        key: pdfKey,
                        controller: controller.pdfController,
                        currentSearchTextHighlightColor: theme.primaryColor.withOpacity(.5),
                        otherSearchTextHighlightColor: theme.primaryColor.withOpacity(.25),
                        scrollDirection: PdfScrollDirection.horizontal,
                        pageLayoutMode: PdfPageLayoutMode.single,
                        onPageChanged: (details) => controller.currentPage.value = details.newPageNumber,
                        enableDoubleTapZooming: false,
                        pageSpacing: 0,
                        enableTextSelection: false,
                        canShowPageLoadingIndicator: false,
                        canShowScrollHead: false,
                        onAnnotationSelected: (annotation) {},
                        onTextSelectionChanged: (details) {},
                        onDocumentLoaded: (details) {},
                        onTap: (details) {},
                      ),
                    ),
                    Positioned.fill(
                      child: noResultFound
                          ? Container(
                              color: AppColor.bgScaffold,
                              padding: const EdgeInsets.all(Sizes.m),
                              child: const EmptyList(description: "Kata tidak ditemukan"),
                            )
                          : Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (controller.isFullScreen.value) {
                                        controller.pdfController.previousPage();
                                      } else {
                                        controller.isFullScreen.value = true;
                                      }
                                    },
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (!controller.isOnSearch.value) {
                                        controller.isFullScreen.value = !controller.isFullScreen.value;
                                      }
                                    },
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (controller.isFullScreen.value) {
                                        controller.pdfController.nextPage();
                                      } else {
                                        controller.isFullScreen.value = true;
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ],
                );
              }),
            ),
            Obx(() {
              final currentPage = controller.currentPage.value;
              final isFullScreen = controller.isFullScreen.value;
              return AnimatedContainer(
                height: isFullScreen ? 0 : kToolbarHeight,
                duration: const Duration(milliseconds: 150),
                padding: const EdgeInsets.symmetric(
                  vertical: Sizes.r,
                  horizontal: Sizes.m,
                ),
                decoration: const BoxDecoration(
                  color: AppColor.white,
                  border: Border(
                    top: BorderSide(color: AppColor.lightGrey),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.star,
                      color: currentPage % 2 == 0 ? Colors.black : Colors.transparent,
                    ),
                    Text(
                      currentPage.toString(),
                      textAlign: TextAlign.center,
                    ),
                    const Icon(Icons.star, color: Colors.transparent),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
