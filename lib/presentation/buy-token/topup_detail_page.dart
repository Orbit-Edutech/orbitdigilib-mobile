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

  ({Color color, IconData icon, String label}) _statusMeta(String status) {
    switch (status) {
      case "PAID":
        return (
          color: AppColor.primary,
          icon: Icons.check_circle_rounded,
          label: "Pembayaran Berhasil",
        );
      case "PENDING":
        return (
          color: AppColor.orange,
          icon: Icons.access_time_rounded,
          label: "Menunggu Pembayaran",
        );
      default:
        return (
          color: AppColor.red,
          icon: Icons.cancel_rounded,
          label: "Pembayaran $status",
        );
    }
  }

  Widget _statusBanner(String status) {
    final m = _statusMeta(status);
    return Container(
      padding: const EdgeInsets.all(Sizes.sr),
      decoration: BoxDecoration(
        color: m.color.withOpacity(0.10),
        borderRadius: const BorderRadius.all(Radius.circular(Sizes.r)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(m.icon, color: m.color, size: 22),
          HGap.s,
          Text(m.label, style: AppTextStyle.ts16Bold.copyWith(color: m.color)),
        ],
      ),
    );
  }

  // Kartu "struk" — total bayar + token yang didapat.
  Widget _receiptCard(int? harga, num? jumlahToken) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Sizes.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(Sizes.r)),
        border: Border.all(color: AppColor.lightGrey.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          Text("Total Pembayaran",
              style: AppTextStyle.ts12Reg.copyWith(color: AppColor.grey)),
          VGap.xs,
          Text(_rupiah(harga), style: AppTextStyle.ts30Bold),
          VGap.sr,
          const Divider(height: 1, color: AppColor.lightGrey),
          VGap.sr,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.monetization_on_rounded,
                  color: AppColor.primary, size: 20),
              HGap.s,
              Text("Anda akan menerima ", style: AppTextStyle.ts14Reg),
              Text("${jumlahToken ?? 0} token",
                  style: AppTextStyle.ts16Bold.copyWith(color: AppColor.primary)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _instructionCard(String text) {
    return Container(
      padding: const EdgeInsets.all(Sizes.sr),
      decoration: const BoxDecoration(
        color: AppColor.bgScaffold,
        borderRadius: BorderRadius.all(Radius.circular(Sizes.s)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline_rounded, size: 18, color: AppColor.grey),
          HGap.s,
          Expanded(
            child: Text(text,
                style: AppTextStyle.ts12Reg.copyWith(color: AppColor.grey)),
          ),
        ],
      ),
    );
  }

  Widget _qrisView(String? qr) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Sizes.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(Sizes.r)),
        border: Border.all(color: AppColor.lightGrey.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          Text("Scan QRIS untuk membayar", style: AppTextStyle.ts14Bold),
          VGap.r,
          (qr == null || qr.isEmpty)
              ? Text("QR tidak tersedia",
                  style: AppTextStyle.ts12Reg.copyWith(color: AppColor.grey))
              : Container(
                  padding: const EdgeInsets.all(Sizes.sr),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(Sizes.s)),
                    border: Border.all(color: AppColor.lightGrey.withOpacity(0.5)),
                  ),
                  child: QrImageView(data: qr, size: 200),
                ),
        ],
      ),
    );
  }

  Widget _vaView(String? bank, String? va) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Sizes.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(Sizes.r)),
        border: Border.all(color: AppColor.lightGrey.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Virtual Account ${bank ?? ''}".trim(),
              style: AppTextStyle.ts12Reg.copyWith(color: AppColor.grey)),
          VGap.s,
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: Sizes.sr, vertical: Sizes.s),
            decoration: const BoxDecoration(
              color: AppColor.primary10,
              borderRadius: BorderRadius.all(Radius.circular(Sizes.s)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(va ?? "-",
                      style: AppTextStyle.ts20Bold.copyWith(color: AppColor.primary)),
                ),
                InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(Sizes.s)),
                  onTap: () {
                    if (va != null) {
                      Clipboard.setData(ClipboardData(text: va));
                      showSnackbar(
                          backgroundColor: AppColor.primary,
                          message: "Nomor VA disalin");
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(Sizes.xs),
                    child: Icon(Icons.copy_rounded, size: 20, color: AppColor.primary),
                  ),
                ),
              ],
            ),
          ),
          VGap.s,
          Text("Transfer tepat sejumlah total ke nomor VA di atas.",
              style: AppTextStyle.ts12Reg.copyWith(color: AppColor.grey)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = Get.find<BuyTokenController>();
    return Scaffold(
      backgroundColor: AppColor.bgScaffold,
      appBar: AppBar(title: const Text("Pembayaran")),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: ResponsiveHelper.getMaxContentWidth(context)),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
                horizontal: ResponsiveHelper.getHorizontalPadding(context)),
            child: Obx(() {
              final t = c.createdTopup.value;
              final status = c.pollStatus.value;
              if (t == null) {
                return Padding(
                  padding: const EdgeInsets.all(Sizes.l),
                  child: Text("Transaksi tidak ditemukan",
                      textAlign: TextAlign.center,
                      style: AppTextStyle.ts14Reg.copyWith(color: AppColor.grey)),
                );
              }
              final paid = status == "PAID";
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  VGap.r,
                  _statusBanner(status),
                  VGap.r,
                  _receiptCard(t.harga, t.jumlahToken),
                  if (!paid) ...[
                    VGap.r,
                    if (t.metode == "QRIS")
                      _qrisView(t.qrString)
                    else
                      _vaView(t.bankCode, t.vaNumber),
                    VGap.r,
                    _instructionCard(
                        "Pembayaran terkonfirmasi otomatis setelah berhasil. Anda boleh menutup halaman ini."),
                    VGap.r,
                    AppButton(
                      type: ButtonType.elevated,
                      state: ButtonState.enable,
                      onPressed: () => c.checkStatus(t.id ?? ""),
                      child: const Text("Cek Status Pembayaran"),
                    ),
                    // Tombol uji hanya di debug build; backend menolaknya di non-sandbox.
                    if (kDebugMode) ...[
                      VGap.s,
                      AppButton(
                        type: ButtonType.outlined,
                        state: c.simulating.value
                            ? ButtonState.loading
                            : ButtonState.enable,
                        onPressed: () => c.simulatePayment(t.id ?? ""),
                        child: const Text("Simulasi Bayar (Sandbox)"),
                      ),
                    ],
                  ] else ...[
                    VGap.l,
                    AppButton(
                      type: ButtonType.elevated,
                      state: ButtonState.enable,
                      onPressed: () => Get.back(),
                      child: const Text("Selesai"),
                    ),
                  ],
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
