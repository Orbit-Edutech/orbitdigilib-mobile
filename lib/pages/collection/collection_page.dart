import 'package:flutter/material.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import 'widgets/collection_book_card.dart';
import 'widgets/collection_filter.dart';

class CollectionPage extends StatelessWidget {
  const CollectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Koleksi Saya"),
      ),
      body: Column(
        children: [
          VGap.m,
          const CollectionFilter(),
          VGap.s,
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.m),
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (ctx, idx) {
                if (idx == 0) return VGap.r;
                return Column(
                  children: [
                    CollectionBookCard(
                      status: idx % 2 == 0
                          ? "Selesai Dibaca"
                          : idx % 3 == 1
                              ? "Belum Dibaca"
                              : "Belum Selesai",
                    ),
                    VGap.r,
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
