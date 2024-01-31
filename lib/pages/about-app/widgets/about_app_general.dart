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
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage("assets/icons/icon.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        VGap.s,
        Text("ORBIT DIGILIB", style: AppTextStyle.ts24Bold),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Dikembangkan oleh ", style: AppTextStyle.ts12Reg),
            Text(
              "Orbit360",
              style: AppTextStyle.ts12Bold.copyWith(color: AppColor.orange),
            ),
          ],
        ),
        VGap.r,
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Klik, Baca, Berkembang",
            style: AppTextStyle.ts10Light,
            textAlign: TextAlign.justify,
          ),
        ),
        VGap.s,
        Text(
          """ORBIT Digital Library, Solusi Perpustakaan Digital Mudah & Lengkap.\n 
Selamat datang di ORBIT Digital Library, solusi perpustakaan digital yang dirancang untuk membantu sekolah untuk mengelola perpustakaan berbasis digital sekaligus meningkatkan literasi siswa. Jelajahi ilmu tak terbatas dengan ribuan buku digital dengan ragam tema yang menarik akan menjadi sumber belajar yang menyenangkan untuk siswa dalam meningkatkan pengetahuan.\n
Dilengkapi oleh koleksi buku yang kaya akan ragam topik untuk memenuhi kebutuhan dan minat pembaca. Mudah diakses oleh semua, termasuk memudahkan pustakawan sekolah dalam mengelola perpustakaan digital. Aplikasi ini bersifat interaktif yang memungkinkan siswa untuk terlibat aktif dan membuat proses membaca jadi lebih menarik. Efisiensi dalam hal peminjaman, penyewaan, dan pembelian buku semakin mempermudah pustakawan, siswa, maupun sekolah dalam menggunakan perpustakaan digital. Sekolah akan mendapatkan aplikasi Perpustakaan Digital secara eksklusif, tanpa perlu khawatir mengenai keamanan data dan privasi yang tersebar.\n
ORBIT Digital Library adalah langkah maju dalam dunia Literasi Digital, menjadi mitra setia dan progresif bagi pustakawan, siswa, dan sekolah.
""",
          style: AppTextStyle.ts10Light,
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}
