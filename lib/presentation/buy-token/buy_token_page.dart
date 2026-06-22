import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../api/paket-token/model/model_paket_token.dart';
import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import '../../theme/app_color.dart';
import '../../theme/app_text_stlye.dart';
import '../../utils/responsive_helper.dart';
import 'controller/buy_token_controller.dart';

class BuyTokenPage extends StatelessWidget {
  const BuyTokenPage({super.key});

  // Teal gelap untuk ujung gradien kartu saldo (pasangan AppColor.primary).
  static const Color _primaryDark = Color(0xFF008C84);

  String _rupiah(int? n) =>
      "Rp ${(n ?? 0).toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}";

  // ── Kartu saldo (hero) ─────────────────────────────────────────────
  Widget _balanceCard(BuyTokenController c) {
    return Container(
      padding: const EdgeInsets.all(Sizes.r),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(Sizes.r)),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColor.primary, _primaryDark],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.primary.withOpacity(0.25),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Saldo Token Anda",
                    style: AppTextStyle.ts12Reg.copyWith(color: Colors.white70)),
                VGap.xs,
                Obx(() {
                  final token =
                      c.profileController.profile.value?.token?.split(".").first ?? "0";
                  return Text.rich(
                    TextSpan(
                      text: token,
                      style: AppTextStyle.ts30Bold.copyWith(color: Colors.white),
                      children: [
                        TextSpan(
                          text: "  token",
                          style: AppTextStyle.ts14Reg.copyWith(color: Colors.white70),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.account_balance_wallet_rounded,
                color: Colors.white, size: 28),
          ),
        ],
      ),
    );
  }

  // ── Badge koin (token) ─────────────────────────────────────────────
  Widget _coinBadge() {
    return Container(
      width: 46,
      height: 46,
      decoration: const BoxDecoration(color: AppColor.primary10, shape: BoxShape.circle),
      child: const Icon(Icons.monetization_on_rounded, color: AppColor.primary, size: 26),
    );
  }

  Widget _pricePill(int? harga) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.sr, vertical: Sizes.xs),
      decoration: const BoxDecoration(
        color: AppColor.primary10,
        borderRadius: BorderRadius.all(Radius.circular(Sizes.l)),
      ),
      child: Text(_rupiah(harga),
          style: AppTextStyle.ts14Bold.copyWith(color: AppColor.primary)),
    );
  }

  // ── Kartu paket ────────────────────────────────────────────────────
  Widget _paketCard(BuyTokenController c, PaketToken paket) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Sizes.sr),
      child: Material(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(Sizes.r)),
        child: InkWell(
          onTap: () => _showMethodSheet(onSelect: (m, b) => c.submitTopup(paket, m, b)),
          borderRadius: const BorderRadius.all(Radius.circular(Sizes.r)),
          child: Ink(
            padding: const EdgeInsets.all(Sizes.sr),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(Sizes.r)),
              border: Border.all(color: AppColor.lightGrey.withOpacity(0.5)),
              color: Colors.white,
            ),
            child: Row(
              children: [
                _coinBadge(),
                HGap.sr,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${paket.jumlahToken ?? 0} token", style: AppTextStyle.ts18Bold),
                      VGap.xs,
                      Text(
                        "Berlaku ${paket.tambahanMasaAktif ?? 0} hari",
                        style: AppTextStyle.ts12Reg.copyWith(color: AppColor.grey),
                      ),
                    ],
                  ),
                ),
                _pricePill(paket.harga),
                HGap.xs,
                const Icon(Icons.chevron_right_rounded, color: AppColor.lightGrey),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Kartu nominal bebas ────────────────────────────────────────────
  Widget _customCard(BuyTokenController c) {
    return Container(
      padding: const EdgeInsets.all(Sizes.r),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(Sizes.r)),
        border: Border.all(color: AppColor.lightGrey.withOpacity(0.5)),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.tune_rounded, color: AppColor.primary, size: 20),
              HGap.s,
              Text("Nominal Bebas", style: AppTextStyle.ts16Bold),
            ],
          ),
          VGap.xs,
          Text("Setiap Rp 1 = 10 token",
              style: AppTextStyle.ts12Reg.copyWith(color: AppColor.grey)),
          VGap.r,
          TextField(
            keyboardType: TextInputType.number,
            style: AppTextStyle.ts18Bold,
            decoration: InputDecoration(
              prefixText: "Rp  ",
              prefixStyle: AppTextStyle.ts18Bold.copyWith(color: AppColor.grey),
              hintText: "0",
              filled: true,
              fillColor: AppColor.bgScaffold,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: Sizes.r, vertical: Sizes.sr),
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(Sizes.s)),
                borderSide: BorderSide(color: AppColor.lightGrey.withOpacity(0.5)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(Sizes.s)),
                borderSide: BorderSide(color: AppColor.lightGrey.withOpacity(0.5)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(Sizes.s)),
                borderSide: BorderSide(color: AppColor.primary, width: 1.5),
              ),
            ),
            onChanged: (v) =>
                c.customAmount.value = int.tryParse(v.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0,
          ),
          VGap.sr,
          Obx(() => Row(
                children: [
                  const Icon(Icons.monetization_on_rounded,
                      color: AppColor.primary, size: 18),
                  HGap.xs,
                  Text("Anda akan menerima ", style: AppTextStyle.ts12Reg),
                  Text("${c.customTokens} token",
                      style: AppTextStyle.ts14Bold.copyWith(color: AppColor.primary)),
                ],
              )),
          VGap.r,
          Obx(() => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: AppColor.lightGrey.withOpacity(0.4),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: Sizes.sr),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(Sizes.s)),
                    ),
                  ),
                  onPressed: c.customAmount.value < 1
                      ? null
                      : () => _showMethodSheet(
                            onSelect: (m, b) =>
                                c.submitCustomTopup(c.customAmount.value, m, b),
                          ),
                  child: Text("Pilih Metode Pembayaran", style: AppTextStyle.ts14Bold),
                ),
              )),
        ],
      ),
    );
  }

  // ── Bottom sheet metode ────────────────────────────────────────────
  void _showMethodSheet({required void Function(String metode, String? bank) onSelect}) {
    const banks = ["BCA", "BNI", "BRI", "MANDIRI", "PERMATA"];
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.fromLTRB(Sizes.r, Sizes.sr, Sizes.r, Sizes.m),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(Sizes.sm)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColor.lightGrey,
                  borderRadius: BorderRadius.circular(Sizes.xs),
                ),
              ),
            ),
            VGap.r,
            Text("Metode Pembayaran", style: AppTextStyle.ts18Bold),
            VGap.r,
            Row(
              children: [
                const Icon(Icons.qr_code_2_rounded, size: 18, color: AppColor.primary),
                HGap.xs,
                Text("QRIS", style: AppTextStyle.ts14Bold),
              ],
            ),
            VGap.s,
            _methodTile(
              icon: Icons.qr_code_scanner_rounded,
              title: "QRIS",
              subtitle: "Scan dengan bank / e-wallet apa pun",
              onTap: () {
                Get.back();
                onSelect("QRIS", null);
              },
            ),
            VGap.r,
            Row(
              children: [
                const Icon(Icons.account_balance_rounded, size: 18, color: AppColor.primary),
                HGap.xs,
                Text("Virtual Account", style: AppTextStyle.ts14Bold),
              ],
            ),
            VGap.xs,
            Text("Minimal Rp 10.000",
                style: AppTextStyle.ts10Reg.copyWith(color: AppColor.grey)),
            VGap.s,
            Wrap(
              spacing: Sizes.s,
              runSpacing: Sizes.s,
              children: banks
                  .map((b) => InkWell(
                        borderRadius: const BorderRadius.all(Radius.circular(Sizes.s)),
                        onTap: () {
                          Get.back();
                          onSelect("VA", b);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Sizes.r, vertical: Sizes.s),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(Sizes.s)),
                            border: Border.all(color: AppColor.lightGrey.withOpacity(0.7)),
                          ),
                          child: Text(b, style: AppTextStyle.ts12Bold),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _methodTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(Sizes.s)),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(Sizes.sr),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(Sizes.s)),
          border: Border.all(color: AppColor.lightGrey.withOpacity(0.7)),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColor.primary),
            HGap.sr,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyle.ts14Bold),
                  VGap.xs,
                  Text(subtitle, style: AppTextStyle.ts12Reg.copyWith(color: AppColor.grey)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: AppColor.lightGrey),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = Get.find<BuyTokenController>();
    return Scaffold(
      backgroundColor: AppColor.bgScaffold,
      appBar: AppBar(title: const Text("Beli Token")),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: ResponsiveHelper.getMaxContentWidth(context)),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
                horizontal: ResponsiveHelper.getHorizontalPadding(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                VGap.r,
                _balanceCard(c),
                VGap.l,
                Text("Pilih Paket", style: AppTextStyle.ts18Bold),
                VGap.xs,
                Text("Token dipakai untuk membaca koleksi digital",
                    style: AppTextStyle.ts12Reg.copyWith(color: AppColor.grey)),
                VGap.r,
                Obx(() {
                  if (c.loadingPaket.value) {
                    return const Padding(
                      padding: EdgeInsets.all(Sizes.l),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  final list = c.paketList.value ?? [];
                  if (list.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(Sizes.l),
                      child: Text("Belum ada paket tersedia",
                          textAlign: TextAlign.center,
                          style: AppTextStyle.ts12Reg.copyWith(color: AppColor.grey)),
                    );
                  }
                  return Column(children: list.map((paket) => _paketCard(c, paket)).toList());
                }),
                VGap.s,
                Row(
                  children: [
                    Expanded(child: Divider(color: AppColor.lightGrey.withOpacity(0.6))),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Sizes.sr),
                      child: Text("atau",
                          style: AppTextStyle.ts12Reg.copyWith(color: AppColor.grey)),
                    ),
                    Expanded(child: Divider(color: AppColor.lightGrey.withOpacity(0.6))),
                  ],
                ),
                VGap.r,
                _customCard(c),
                VGap.l,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
