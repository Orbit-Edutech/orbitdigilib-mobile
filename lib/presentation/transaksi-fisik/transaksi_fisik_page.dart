import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import '../../shared/widget/empty_list.dart';
import '../../theme/app_color.dart';
import '../../theme/app_text_stlye.dart';
import '../../utils/responsive_helper.dart';
import 'controller/transaksi_fisik_controller.dart';
import 'widgets/transaksi_fisik_card.dart';

class TransaksiFisikPage extends StatelessWidget {
  const TransaksiFisikPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TransaksiFisikController>();
    final hPad = ResponsiveHelper.getHorizontalPadding(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Riwayat Pinjam Fisik")),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: ResponsiveHelper.getMaxContentWidth(context)),
            child: Column(
              children: [
                // ── Filter section ──
                Padding(
                  padding: EdgeInsets.fromLTRB(hPad, Sizes.r, hPad, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Search
                      TextField(
                        controller: controller.searchCtrl,
                        onChanged: (v) => controller.searchQuery.value = v,
                        decoration: InputDecoration(
                          hintText: "Cari judul atau penulis...",
                          hintStyle: AppTextStyle.ts14Reg.copyWith(color: AppColor.lightGrey),
                          prefixIcon: const Icon(Icons.search, color: AppColor.lightGrey),
                          suffixIcon: Obx(() => controller.searchQuery.value.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.close, size: 18),
                                  onPressed: () {
                                    controller.searchCtrl.clear();
                                    controller.searchQuery.value = '';
                                  },
                                )
                              : const SizedBox.shrink()),
                          contentPadding: const EdgeInsets.symmetric(vertical: Sizes.s),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(99),
                            borderSide: const BorderSide(color: AppColor.lightGrey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(99),
                            borderSide: const BorderSide(color: AppColor.lightGrey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(99),
                            borderSide: const BorderSide(color: AppColor.primary),
                          ),
                        ),
                      ),
                      VGap.s,
                      // Status chips + date filter
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Obx(() {
                          final status = controller.filterStatus.value;
                          final from = controller.dateFrom.value;
                          final to = controller.dateTo.value;
                          return Row(
                            children: [
                              _StatusChip(label: "Semua", value: '', current: status, onTap: (v) => controller.filterStatus.value = v),
                              HGap.s,
                              _StatusChip(label: "Dipinjam", value: 'DIPINJAM', current: status, onTap: (v) => controller.filterStatus.value = v),
                              HGap.s,
                              _StatusChip(label: "Dikembalikan", value: 'DIKEMBALIKAN', current: status, onTap: (v) => controller.filterStatus.value = v),
                              HGap.s,
                              // Date range chip
                              GestureDetector(
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
                                        colorScheme: Theme.of(ctx).colorScheme.copyWith(primary: AppColor.primary),
                                      ),
                                      child: child!,
                                    ),
                                  );
                                  if (picked != null) {
                                    controller.dateFrom.value = picked.start;
                                    controller.dateTo.value = picked.end;
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: Sizes.sr, vertical: Sizes.xs + 2),
                                  decoration: BoxDecoration(
                                    color: from != null ? AppColor.primary : Colors.transparent,
                                    border: Border.all(
                                      color: from != null ? AppColor.primary : AppColor.lightGrey,
                                    ),
                                    borderRadius: BorderRadius.circular(99),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.date_range, size: 14, color: from != null ? Colors.white : AppColor.grey),
                                      HGap.xs,
                                      Text(
                                        from != null && to != null
                                            ? "${_fmtDate(from)} – ${_fmtDate(to)}"
                                            : "Tanggal",
                                        style: AppTextStyle.ts12Reg.copyWith(
                                          color: from != null ? Colors.white : AppColor.grey,
                                        ),
                                      ),
                                      if (from != null) ...[
                                        HGap.xs,
                                        GestureDetector(
                                          onTap: controller.clearFilters,
                                          child: const Icon(Icons.close, size: 14, color: Colors.white),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                      VGap.s,
                    ],
                  ),
                ),
                // ── List ──
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: controller.onInit,
                    child: Obx(() {
                      final list = controller.filtered;
                      if (list == null) {
                        return ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: hPad),
                          itemCount: 8,
                          itemBuilder: (_, __) => Container(
                            height: 100,
                            margin: const EdgeInsets.only(bottom: Sizes.r),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(Sizes.s)),
                              color: Color(0xFFEEEEEE),
                            ),
                          ),
                        );
                      }
                      if (list.isEmpty) {
                        return const SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          child: Column(
                            children: [
                              VGap.m,
                              EmptyList(description: "Tidak ada data peminjaman"),
                            ],
                          ),
                        );
                      }
                      return ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: hPad, vertical: Sizes.r),
                        itemCount: list.length,
                        itemBuilder: (_, index) => TransaksiFisikCard(item: list[index]),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _fmtDate(DateTime d) =>
      "${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}";
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({
    required this.label,
    required this.value,
    required this.current,
    required this.onTap,
  });

  final String label;
  final String value;
  final String current;
  final void Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    final active = current == value;
    return GestureDetector(
      onTap: () => onTap(value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.sr, vertical: Sizes.xs + 2),
        decoration: BoxDecoration(
          color: active ? AppColor.primary : Colors.transparent,
          border: Border.all(color: active ? AppColor.primary : AppColor.lightGrey),
          borderRadius: BorderRadius.circular(99),
        ),
        child: Text(
          label,
          style: AppTextStyle.ts12Reg.copyWith(
            color: active ? Colors.white : AppColor.grey,
          ),
        ),
      ),
    );
  }
}
