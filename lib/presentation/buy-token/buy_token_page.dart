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

  void _showMethodSheet({required void Function(String metode, String? bank) onSelect}) {
    const banks = ["BCA", "BNI", "BRI", "MANDIRI", "PERMATA"];
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(Sizes.r),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(Sizes.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Pilih Metode Pembayaran", style: AppTextStyle.ts16Bold),
            VGap.s,
            Text("Virtual Account (min. Rp 10.000)",
                style: AppTextStyle.ts12Reg.copyWith(color: AppColor.black)),
            VGap.xs,
            Wrap(
              spacing: 8,
              children: banks
                  .map((b) => ActionChip(
                        label: Text(b),
                        onPressed: () {
                          Get.back();
                          onSelect("VA", b);
                        },
                      ))
                  .toList(),
            ),
            VGap.r,
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.qr_code_2),
              title: const Text("QRIS"),
              subtitle: const Text("Scan dengan bank / e-wallet apa pun"),
              onTap: () {
                Get.back();
                onSelect("QRIS", null);
              },
            ),
            VGap.r,
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _paketCard(BuyTokenController c, PaketToken paket) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Sizes.s),
      child: InkWell(
        onTap: () => _showMethodSheet(onSelect: (m, b) => c.submitTopup(paket, m, b)),
        borderRadius: const BorderRadius.all(Radius.circular(Sizes.s)),
        child: Container(
          padding: const EdgeInsets.all(Sizes.r),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(Sizes.s)),
            border: Border.all(color: AppColor.lightGrey),
            color: Colors.white,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(paket.nama ?? "-", style: AppTextStyle.ts16Bold),
                    VGap.xs,
                    Text(
                      "${paket.jumlahToken ?? 0} token • masa aktif ${paket.tambahanMasaAktif ?? 0} hari",
                      style: AppTextStyle.ts12Reg,
                    ),
                    if ((paket.deskripsi ?? "").isNotEmpty) ...[
                      VGap.xs,
                      Text(paket.deskripsi!, style: AppTextStyle.ts12Reg.copyWith(color: AppColor.primary)),
                    ],
                  ],
                ),
              ),
              Text(_rupiah(paket.harga), style: AppTextStyle.ts16Bold.copyWith(color: AppColor.primary)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _customCard(BuyTokenController c) {
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
          Text("Nominal Bebas", style: AppTextStyle.ts16Bold),
          VGap.xs,
          Text("Rp 1 = 10 token (berlaku kelipatan)", style: AppTextStyle.ts12Reg),
          VGap.s,
          TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              prefixText: "Rp ",
              hintText: "Masukkan nominal",
              border: OutlineInputBorder(),
              isDense: true,
            ),
            onChanged: (v) =>
                c.customAmount.value = int.tryParse(v.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0,
          ),
          VGap.xs,
          Obx(() => Text(
                "= ${c.customTokens} token",
                style: AppTextStyle.ts16Bold.copyWith(color: AppColor.primary),
              )),
          VGap.s,
          Obx(() => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: c.customAmount.value < 1
                      ? null
                      : () => _showMethodSheet(
                            onSelect: (m, b) =>
                                c.submitCustomTopup(c.customAmount.value, m, b),
                          ),
                  child: const Text("Pilih Metode Pembayaran"),
                ),
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = Get.find<BuyTokenController>();
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Beli Token")),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: ResponsiveHelper.getMaxContentWidth(context)),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.getHorizontalPadding(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                VGap.l,
                Obx(() {
                  final token = c.profileController.profile.value?.token;
                  return Text.rich(
                    TextSpan(text: "Token DIGILIB Anda ", children: [
                      TextSpan(
                        text: token?.split(".")[0],
                        style: TextStyle(color: theme.primaryColor, fontWeight: FontWeight.bold),
                      )
                    ]),
                    style: AppTextStyle.ts16Reg,
                    textAlign: TextAlign.center,
                  );
                }),
                VGap.l,
                Text("Pilih Paket", style: AppTextStyle.ts16Bold),
                VGap.s,
                Obx(() {
                  if (c.loadingPaket.value) {
                    return const Padding(
                      padding: EdgeInsets.all(24),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  final list = c.paketList.value ?? [];
                  if (list.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(24),
                      child: Text("Belum ada paket tersedia", textAlign: TextAlign.center),
                    );
                  }
                  return Column(children: list.map((paket) => _paketCard(c, paket)).toList());
                }),
                VGap.l,
                Text("Atau Nominal Bebas", style: AppTextStyle.ts16Bold),
                VGap.s,
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
