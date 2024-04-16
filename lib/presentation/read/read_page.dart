import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:get/utils.dart';
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
    _methodChannel.invokeMethod("secure", {"isSecure": true});
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
                final buku = controller.buku.value;
                final isOnSearch = controller.isOnSearch.value;
                final isFullScreen = controller.isFullScreen.value;
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
                        controller.pdfController.jumpToPage(controller.currentPage.value);
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
                  if (isFullScreen) return const SizedBox();
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
                          buku?.judul ?? "-",
                          style: AppTextStyle.ts16Bold,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          buku?.penulis ?? "-",
                          style: AppTextStyle.ts14Reg,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "${buku?.jumlahHalaman ?? "-"} halaman",
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
                final book = controller.buku.value;
                final pdf = controller.pdf.value;
                if (book == null || pdf == null) {
                  return SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.only(top: Sizes.m),
                      child: const EmptyList(description: "Buku sedang dimuat"),
                    ),
                  );
                }
                return Stack(
                  children: [
                    SfPdfViewerTheme(
                      data: SfPdfViewerThemeData(backgroundColor: AppColor.white),
                      child: SfPdfViewer.file(
                        pdf,
                        key: pdfKey,
                        controller: controller.pdfController,
                        currentSearchTextHighlightColor: theme.primaryColor.withOpacity(.5),
                        otherSearchTextHighlightColor: theme.primaryColor.withOpacity(.25),
                        scrollDirection: PdfScrollDirection.horizontal,
                        pageLayoutMode: PdfPageLayoutMode.single,
                        onPageChanged: (details) => controller.onPageChanged(details.newPageNumber),
                        enableDoubleTapZooming: false,
                        pageSpacing: 0,
                        enableTextSelection: false,
                        canShowPageLoadingIndicator: true,
                        canShowScrollHead: true,
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
              final isStared = controller.staredPages.value?.firstWhereOrNull((page) => page == currentPage) != null;
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
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: controller.onStarChanged,
                          child: Icon(
                            isStared ? Icons.star : Icons.star_outline,
                            color: Colors.black,
                          ),
                        ),
                        if (controller.staredPages.value?.isNotEmpty ?? false) ...[
                          PopupMenuButton(
                            surfaceTintColor: Colors.white,
                            color: Colors.white,
                            itemBuilder: (context) {
                              return controller.staredPages.value!.map((e) {
                                return PopupMenuItem(
                                  value: e,
                                  child: Text(e.toString()),
                                );
                              }).toList();
                            },
                            onSelected: (value) {
                              controller.pdfController.jumpToPage(value);
                            },
                            child: const Icon(Icons.keyboard_arrow_up_rounded),
                          ),
                        ],
                      ],
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
