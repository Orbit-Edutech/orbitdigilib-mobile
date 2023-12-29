import 'package:flutter/material.dart';

import '../../../constants/gaps.dart';
import 'collection_filter_card.dart';

class CollectionFilter extends StatelessWidget {
  const CollectionFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          HGap.m,
          CollectionFilterCard(
            text: 'Semua Koleksi',
            onTap: () {},
            isActive: true,
          ),
          HGap.s,
          CollectionFilterCard(
            text: 'Pinjam',
            onTap: () {},
            isActive: false,
          ),
          HGap.s,
          CollectionFilterCard(
            text: 'Sewa',
            onTap: () {},
            isActive: false,
          ),
          HGap.s,
          CollectionFilterCard(
            text: 'Beli',
            onTap: () {},
            isActive: false,
          ),
        ],
      ),
    );
  }
}
