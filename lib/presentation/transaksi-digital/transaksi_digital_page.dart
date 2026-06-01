import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import '../../shared/widget/empty_list.dart';
import '../../theme/app_color.dart';
import '../../theme/app_text_stlye.dart';
import '../../utils/responsive_helper.dart';
import 'controller/transaksi_digital_controller.dart';
import 'widgets/pinjam_digital_card.dart';
import 'widgets/sewa_digital_card.dart';

class TransaksiDigitalPage extends StatelessWidget {
  const TransaksiDigitalPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TransaksiDigitalController>();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Riwayat Digital"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Pinjam"),
              Tab(text: "Sewa"),
            ],
            labelColor: AppColor.white,
            unselectedLabelColor: AppColor.white,
            indicatorColor: AppColor.white,
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              _PinjamTab(controller: controller),
              _SewaTab(controller: controller),
            ],
          ),
        ),
      ),
    );
  }
}

class _PinjamTab extends StatelessWidget {
  const _PinjamTab({required this.controller});
  final TransaksiDigitalController controller;

  @override
  Widget build(BuildContext context) {
    final hPad = ResponsiveHelper.getHorizontalPadding(context);
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
            maxWidth: ResponsiveHelper.getMaxContentWidth(context)),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(hPad, Sizes.r, hPad, 0),
              child: Column(
                children: [
                  TextField(
                    controller: controller.pinjamSearchCtrl,
                    onChanged: (v) => controller.pinjamSearchQuery.value = v,
                    decoration:
                        _searchDecoration("Cari judul atau penulis...", () {
                      controller.pinjamSearchCtrl.clear();
                      controller.pinjamSearchQuery.value = '';
                    }, controller.pinjamSearchQuery),
                  ),
                  VGap.s,
                  _DateFilterRow(
                    dateFrom: controller.pinjamDateFrom,
                    dateTo: controller.pinjamDateTo,
                    onClear: controller.clearPinjamFilters,
                  ),
                  VGap.s,
                ],
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: controller.refreshPinjam,
                child: Obx(() {
                  final list = controller.filteredPinjam;
                  if (list == null) return _loadingSkeleton(hPad);
                  if (list.isEmpty) {
                    return const SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Column(children: [
                        VGap.m,
                        EmptyList(description: "Tidak ada data pinjam digital")
                      ]),
                    );
                  }
                  return ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                        horizontal: hPad, vertical: Sizes.r),
                    itemCount: list.length,
                    itemBuilder: (_, i) => PinjamDigitalCard(item: list[i]),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SewaTab extends StatelessWidget {
  const _SewaTab({required this.controller});
  final TransaksiDigitalController controller;

  @override
  Widget build(BuildContext context) {
    final hPad = ResponsiveHelper.getHorizontalPadding(context);
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
            maxWidth: ResponsiveHelper.getMaxContentWidth(context)),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(hPad, Sizes.r, hPad, 0),
              child: Column(
                children: [
                  TextField(
                    controller: controller.sewaSearchCtrl,
                    onChanged: (v) => controller.sewaSearchQuery.value = v,
                    decoration:
                        _searchDecoration("Cari judul atau penulis...", () {
                      controller.sewaSearchCtrl.clear();
                      controller.sewaSearchQuery.value = '';
                    }, controller.sewaSearchQuery),
                  ),
                  VGap.s,
                  _DateFilterRow(
                    dateFrom: controller.sewaDateFrom,
                    dateTo: controller.sewaDateTo,
                    onClear: controller.clearSewaFilters,
                  ),
                  VGap.s,
                ],
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: controller.refreshSewa,
                child: Obx(() {
                  final list = controller.filteredSewa;
                  if (list == null) return _loadingSkeleton(hPad);
                  if (list.isEmpty) {
                    return const SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Column(children: [
                        VGap.m,
                        EmptyList(description: "Tidak ada data sewa digital")
                      ]),
                    );
                  }
                  return ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                        horizontal: hPad, vertical: Sizes.r),
                    itemCount: list.length,
                    itemBuilder: (_, i) => SewaDigitalCard(item: list[i]),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DateFilterRow extends StatelessWidget {
  const _DateFilterRow({
    required this.dateFrom,
    required this.dateTo,
    required this.onClear,
  });
  final Rx<DateTime?> dateFrom;
  final Rx<DateTime?> dateTo;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final from = dateFrom.value;
      final to = dateTo.value;
      return Align(
        alignment: Alignment.centerLeft,
        child: GestureDetector(
          onTap: () async {
            final picked = await showDateRangePicker(
              context: context,
              firstDate: DateTime(2020),
              lastDate: DateTime.now(),
              initialDateRange: from != null && to != null
                  ? DateTimeRange(start: from, end: to)
                  : null,
              builder: (ctx, child) => Theme(
                data: Theme.of(ctx).copyWith(
                  colorScheme: Theme.of(ctx)
                      .colorScheme
                      .copyWith(primary: AppColor.primary),
                ),
                child: child!,
              ),
            );
            if (picked != null) {
              dateFrom.value = picked.start;
              dateTo.value = picked.end;
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: Sizes.sr, vertical: Sizes.xs + 2),
            decoration: BoxDecoration(
              color: from != null ? AppColor.primary : Colors.transparent,
              border: Border.all(
                  color: from != null ? AppColor.primary : AppColor.lightGrey),
              borderRadius: BorderRadius.circular(99),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.date_range,
                    size: 14,
                    color: from != null ? Colors.white : AppColor.grey),
                HGap.xs,
                Text(
                  from != null && to != null
                      ? "${_fmt(from)} – ${_fmt(to)}"
                      : "Tanggal",
                  style: AppTextStyle.ts12Reg.copyWith(
                      color: from != null ? Colors.white : AppColor.grey),
                ),
                if (from != null) ...[
                  HGap.xs,
                  GestureDetector(
                    onTap: onClear,
                    child:
                        const Icon(Icons.close, size: 14, color: Colors.white),
                  ),
                ],
              ],
            ),
          ),
        ),
      );
    });
  }

  String _fmt(DateTime d) =>
      "${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}";
}

InputDecoration _searchDecoration(
    String hint, VoidCallback onClear, RxString query) {
  return InputDecoration(
    hintText: hint,
    hintStyle: AppTextStyle.ts14Reg.copyWith(color: AppColor.lightGrey),
    prefixIcon: const Icon(Icons.search, color: AppColor.lightGrey),
    suffixIcon: Obx(() => query.value.isNotEmpty
        ? IconButton(
            icon: const Icon(Icons.close, size: 18), onPressed: onClear)
        : const SizedBox.shrink()),
    contentPadding: const EdgeInsets.symmetric(vertical: Sizes.s),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(99),
        borderSide: const BorderSide(color: AppColor.lightGrey)),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(99),
        borderSide: const BorderSide(color: AppColor.lightGrey)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(99),
        borderSide: const BorderSide(color: AppColor.primary)),
  );
}

Widget _loadingSkeleton(double hPad) => ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: hPad),
      itemCount: 6,
      itemBuilder: (_, __) => Container(
        height: 100,
        margin: const EdgeInsets.only(bottom: Sizes.r),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(Sizes.s)),
          color: Color(0xFFEEEEEE),
        ),
      ),
    );
