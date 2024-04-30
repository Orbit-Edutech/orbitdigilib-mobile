import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';

import '../../../constants/gaps.dart';
import '../controller/collection_controller.dart';
import 'collection_filter_card.dart';

class CollectionFilter extends StatelessWidget {
  const CollectionFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CollectionController>();
    return Obx(() {
      final filter = controller.filter.value;
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            HGap.m,
            CollectionFilterCard(
              text: 'Semua Koleksi',
              onTap: () => controller.onChangeFilter("Semua Koleksi"),
              isActive: filter == "Semua Koleksi" ? true : false,
            ),
            HGap.s,
            CollectionFilterCard(
              text: 'Pinjam',
              onTap: () => controller.onChangeFilter("Pinjam"),
              isActive: filter == "Pinjam" ? true : false,
            ),
            HGap.s,
            CollectionFilterCard(
              text: 'Sewa',
              onTap: () => controller.onChangeFilter("Sewa"),
              isActive: filter == "Sewa" ? true : false,
            ),
            HGap.s,
            CollectionFilterCard(
              text: 'Beli',
              onTap: () => controller.onChangeFilter("Beli"),
              isActive: filter == "Beli" ? true : false,
            ),
            HGap.m,
          ],
        ),
      );
    });
  }
}
