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

  String _rupiah(int? n) =>
      "Rp ${(n ?? 0).toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}";

  BoxDecoration get _cardDecoration => const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(Sizes.s)),
        border: Border.fromBorderSide(BorderSide(color: AppColor.lightGrey, width: 1)),
      );

  // ── Saldo token (kartu flat, selaras gaya app) ─────────────────────
  Widget _balanceCard(BuyTokenController c, Color primary) {
    return Container(
      padding: const EdgeInsets.all(Sizes.r),
      decoration: _cardDecoration,
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: primary.withOpacity(0.1),
              borderRadius: const BorderRadius.all(Radius.circular(Sizes.xs)),
            ),
            child: Icon(Icons.account_balance_wallet_outlined, color: primary),
          ),
          HGap.r,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Saldo Token Anda",
                    style: AppTextStyle.ts12Reg.copyWith(color: AppColor.grey)),
                VGap.xs,
                Obx(() {
                  final token =
                      c.profileController.profile.value?.token?.split(".").first ?? "0";
                  return Text.rich(
                    TextSpan(
                      text: token,
                      style: AppTextStyle.ts24Bold.copyWith(color: primary),
                      children: [
                        TextSpan(text: " token", style: AppTextStyle.ts12Reg),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Kartu paket ────────────────────────────────────────────────────
  Widget _paketCard(BuyTokenController c, PaketToken paket, Color primary) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Sizes.s),
      child: InkWell(
        onTap: () =>
            _showMethodSheet(primary: primary, onSelect: (m, b) => c.submitTopup(paket, m, b)),
        borderRadius: const BorderRadius.all(Radius.circular(Sizes.s)),
        child: Container(
          padding: const EdgeInsets.all(Sizes.sr),
          decoration: _cardDecoration,
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: primary.withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(Sizes.xs)),
                ),
                child: Icon(Icons.monetization_on_outlined, color: primary),
              ),
              HGap.r,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${paket.jumlahToken ?? 0} token", style: AppTextStyle.ts16Bold),
                    VGap.xs,
                    Text(
                      "Berlaku ${paket.tambahanMasaAktif ?? 0} hari",
                      style: AppTextStyle.ts12Reg.copyWith(color: AppColor.grey),
                    ),
                  ],
                ),
              ),
              Text(_rupiah(paket.harga),
                  style: AppTextStyle.ts16Bold.copyWith(color: primary)),
              HGap.xs,
              Icon(Icons.arrow_forward_ios_rounded, color: primary, size: 14),
            ],
          ),
        ),
      ),
    );
  }

  // ── Kartu nominal bebas ────────────────────────────────────────────
  Widget _customCard(BuyTokenController c, Color primary) {
    return Container(
      padding: const EdgeInsets.all(Sizes.r),
      decoration: _cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Nominal Bebas", style: AppTextStyle.ts16Bold),
          VGap.xs,
          Text("Setiap Rp 1 = 10 token",
              style: AppTextStyle.ts12Reg.copyWith(color: AppColor.grey)),
          VGap.r,
          TextField(
            keyboardType: TextInputType.number,
            style: AppTextStyle.ts16Bold,
            cursorColor: primary,
            decoration: InputDecoration(
              prefixText: "Rp  ",
              prefixStyle: AppTextStyle.ts16Bold.copyWith(color: AppColor.grey),
              hintText: "0",
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: Sizes.sr, vertical: Sizes.sr),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(Sizes.s)),
                borderSide: BorderSide(color: AppColor.lightGrey),
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(Sizes.s)),
                borderSide: BorderSide(color: AppColor.lightGrey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(Sizes.s)),
                borderSide: BorderSide(color: primary, width: 1.5),
              ),
            ),
            onChanged: (v) =>
                c.customAmount.value = int.tryParse(v.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0,
          ),
          VGap.sr,
          Obx(() => Text.rich(
                TextSpan(
                  text: "Anda akan menerima ",
                  style: AppTextStyle.ts12Reg.copyWith(color: AppColor.grey),
                  children: [
                    TextSpan(
                      text: "${c.customTokens} token",
                      style: AppTextStyle.ts14Bold.copyWith(color: primary),
                    ),
                  ],
                ),
              )),
          VGap.r,
          Obx(() => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: AppColor.lightGrey,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: Sizes.sr),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(Sizes.s)),
                    ),
                  ),
                  onPressed: c.customAmount.value < 1
                      ? null
                      : () => _showMethodSheet(
                            primary: primary,
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
  void _showMethodSheet({
    required Color primary,
    required void Function(String metode, String? bank) onSelect,
  }) {
    const banks = ["BCA", "BNI", "BRI", "MANDIRI", "PERMATA"];
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.fromLTRB(Sizes.r, Sizes.sr, Sizes.r, Sizes.m),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(Sizes.r)),
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
            Text("Metode Pembayaran", style: AppTextStyle.ts16Bold),
            VGap.r,
            _methodTile(
              primary: primary,
              icon: Icons.qr_code_scanner_rounded,
              title: "QRIS",
              subtitle: "Scan dengan bank / e-wallet apa pun",
              onTap: () {
                Get.back();
                onSelect("QRIS", null);
              },
            ),
            VGap.r,
            Text("Virtual Account", style: AppTextStyle.ts14Bold),
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
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(Sizes.s)),
                            border: Border.fromBorderSide(
                                BorderSide(color: AppColor.lightGrey)),
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
    required Color primary,
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
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(Sizes.s)),
          border: Border.fromBorderSide(BorderSide(color: AppColor.lightGrey)),
        ),
        child: Row(
          children: [
            Icon(icon, color: primary),
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
            Icon(Icons.arrow_forward_ios_rounded, color: primary, size: 14),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = Get.find<BuyTokenController>();
    final primary = Theme.of(context).primaryColor;
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
                _balanceCard(c, primary),
                VGap.r,
                Text("Pilih Paket", style: AppTextStyle.ts16Bold),
                VGap.s,
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
                  return Column(
                      children: list.map((paket) => _paketCard(c, paket, primary)).toList());
                }),
                VGap.s,
                Row(
                  children: [
                    const Expanded(child: Divider(color: AppColor.lightGrey)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Sizes.sr),
                      child: Text("atau",
                          style: AppTextStyle.ts12Reg.copyWith(color: AppColor.grey)),
                    ),
                    const Expanded(child: Divider(color: AppColor.lightGrey)),
                  ],
                ),
                VGap.r,
                _customCard(c, primary),
                VGap.l,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
