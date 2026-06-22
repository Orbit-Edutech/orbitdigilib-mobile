import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import '../../shared/widget/app_button.dart';
import '../../shared/widget/show_snackbar.dart';
import '../../theme/app_color.dart';
import '../../theme/app_text_stlye.dart';
import '../../utils/responsive_helper.dart';
import 'controller/buy_token_controller.dart';

class TopupDetailPage extends StatelessWidget {
  const TopupDetailPage({super.key});

  String _rupiah(int? n) =>
      "Rp ${(n ?? 0).toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}";

  Widget _statusBanner(String status) {
    final paid = status == "PAID";
    final color = paid ? AppColor.green : (status == "PENDING" ? AppColor.primary : AppColor.red);
    final label = paid
        ? "Pembayaran Berhasil"
        : (status == "PENDING" ? "Menunggu Pembayaran" : "Pembayaran $status");
    return Container(
      padding: const EdgeInsets.all(Sizes.s),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(Sizes.s)),
        border: Border.all(color: color),
      ),
      child: Text(label, style: AppTextStyle.ts16Reg.copyWith(color: color), textAlign: TextAlign.center),
    );
  }

  Widget _qrisView(String? qr) {
    if (qr == null || qr.isEmpty) {
      return const Text("QR tidak tersedia", textAlign: TextAlign.center);
    }
    return Column(
      children: [
        Text("Scan QRIS berikut", style: AppTextStyle.ts12Reg),
        VGap.s,
        Center(child: QrImageView(data: qr, size: 220)),
      ],
    );
  }

  Widget _vaView(String? bank, String? va) {
    return Container(
      padding: const EdgeInsets.all(Sizes.r),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(Sizes.s)),
        border: Border.all(color: AppColor.lightGrey),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Virtual Account ${bank ?? ''}", style: AppTextStyle.ts12Reg),
          VGap.xs,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(child: Text(va ?? "-", style: AppTextStyle.ts16Bold)),
              IconButton(
                icon: const Icon(Icons.copy, size: 20),
                onPressed: () {
                  if (va != null) {
                    Clipboard.setData(ClipboardData(text: va));
                    showSnackbar(backgroundColor: AppColor.green, message: "Nomor VA disalin");
                  }
                },
              ),
            ],
          ),
          VGap.xs,
          Text(
            "Transfer tepat sejumlah total ke nomor VA di atas.",
            style: AppTextStyle.ts12Reg.copyWith(color: AppColor.black),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = Get.find<BuyTokenController>();
    return Scaffold(
      appBar: AppBar(title: const Text("Pembayaran")),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: ResponsiveHelper.getMaxContentWidth(context)),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.getHorizontalPadding(context)),
            child: Obx(() {
              final t = c.createdTopup.value;
              final status = c.pollStatus.value;
              if (t == null) {
                return const Padding(
                  padding: EdgeInsets.all(24),
                  child: Text("Transaksi tidak ditemukan", textAlign: TextAlign.center),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  VGap.l,
                  _statusBanner(status),
                  VGap.l,
                  Text("Total Pembayaran", style: AppTextStyle.ts12Reg, textAlign: TextAlign.center),
                  VGap.xs,
                  Text(_rupiah(t.harga), style: AppTextStyle.ts16Bold, textAlign: TextAlign.center),
                  VGap.l,
                  if (t.metode == "QRIS") _qrisView(t.qrString) else _vaView(t.bankCode, t.vaNumber),
                  VGap.l,
                  AppButton(
                    type: ButtonType.elevated,
                    state: ButtonState.enable,
                    onPressed: () => c.checkStatus(t.id ?? ""),
                    child: const Text("Cek Status Pembayaran"),
                  ),
                  // Tombol uji hanya di debug build + saat masih menunggu bayar.
                  // Backend juga menolaknya bila bukan sandbox (double-safe).
                  if (kDebugMode && status == "PENDING") ...[
                    VGap.s,
                    AppButton(
                      type: ButtonType.outlined,
                      state: c.simulating.value ? ButtonState.loading : ButtonState.enable,
                      onPressed: () => c.simulatePayment(t.id ?? ""),
                      child: const Text("Simulasi Bayar (Sandbox)"),
                    ),
                  ],
                  VGap.s,
                  Text(
                    "Pembayaran akan terkonfirmasi otomatis setelah berhasil. Anda boleh menutup halaman ini.",
                    style: AppTextStyle.ts12Reg.copyWith(color: AppColor.black),
                    textAlign: TextAlign.center,
                  ),
                  VGap.l,
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
