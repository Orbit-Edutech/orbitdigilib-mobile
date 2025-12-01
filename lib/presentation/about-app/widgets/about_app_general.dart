import 'package:flutter/material.dart';

import '../../../constants/gaps.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_text_stlye.dart';

class AboutAppGeneral extends StatelessWidget {
  const AboutAppGeneral({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const features = {
      "1": "Tampilan Dalam Aplikasi Sesuai Identitas Sekolah",
      "2": "Pinjam Buku Gratis Atau Sewa Dengan Harga Murah",
      "3": "Tersedia Ribuan Buku Menarik Beragam Kategori",
      "4": "Mudah Menandai Halaman Atau Mencari Isi Buku",
      "5": "Dashboard Pustakawan",
    };
    return Column(
      children: [
        Image.asset(
          "assets/logo/istiqlal-logo.png",
          width: size.width / 2,
        ),
        VGap.s,
        Text("ISTIQLAL DIGILIB", style: AppTextStyle.ts18Bold),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Dikembangkan oleh ", style: AppTextStyle.ts12Reg),
            Text(
              "ORBIT EDUTECH",
              style: AppTextStyle.ts12Bold.copyWith(color: AppColor.orange),
            ),
          ],
        ),
        VGap.r,
        Align(
          alignment: Alignment.centerLeft,
          child: Text.rich(
            TextSpan(
              text: "ISTIQLAL DIGILIB",
              style: AppTextStyle.ts10Bold,
              children: [
                TextSpan(
                  text: ", Perpustakaan Digital Untuk Semua",
                  style: AppTextStyle.ts10Light,
                )
              ],
            ),
            style: AppTextStyle.ts10Light,
            textAlign: TextAlign.justify,
          ),
        ),
        VGap.s,
        Text.rich(
          TextSpan(
            text: "ISTIQLAL DIGILIB",
            style: AppTextStyle.ts10Bold,
            children: [
              TextSpan(
                text:
                    " adalah platform perpustakaan digital yang dapat digunakan sekolah-sekolah di Indonesia untuk menyediakan Perpustakaan Digital bagi siswa-siswanya. Siswa dapat meminjam atau menyewa buku-buku digital dengan beragam tema yang menarik di mana pun dan kapan pun. Aplikasi ini sesuai dengan kebijakan Kurikulum Merdeka yang mendorong peningkatan literasi siswa. ",
                style: AppTextStyle.ts10Light,
              )
            ],
          ),
          style: AppTextStyle.ts10Light,
          textAlign: TextAlign.justify,
        ),
        VGap.s,
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Fitur Unggulan: ",
            style: AppTextStyle.ts10Bold,
            textAlign: TextAlign.left,
          ),
        ),
        VGap.xs,
        for (String key in features.keys) ...[
          Row(
            children: [
              Text(
                "$key.  ",
                style: AppTextStyle.ts10Light,
              ),
              Flexible(
                  child: Text(
                features[key].toString(),
                style: AppTextStyle.ts10Light,
              )),
            ],
          ),
          const SizedBox(height: 2),
        ],
        VGap.s,
        Text(
          "Sekolah-sekolah yang bergabung sebagai Mitra ISTIQLAL DIGILIB berkesempatan tergabung dalam The Habibie Literacy Networks, sebuah jejaring kolaborasi peningkatan literasi di sekolah.",
          style: AppTextStyle.ts10Light,
          textAlign: TextAlign.justify,
        ),
        VGap.s,
        Text(
          "ISTIQLAL DIGILIB adalah langkah maju dalam dunia Literasi Digital, menjadi mitra setia dan progresif bagi pustakawan, siswa, dan sekolah.",
          style: AppTextStyle.ts10Light,
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}
