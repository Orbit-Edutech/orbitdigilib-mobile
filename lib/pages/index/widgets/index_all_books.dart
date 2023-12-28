import "dart:developer";

import "package:flutter/material.dart";
import "package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart";
import "package:get/route_manager.dart";

import "../../../api/auth/data/auth_logout.dart";
import "../../../constants/gaps.dart";
import "../../../constants/sizes.dart";
import "../../../routes/app_routes.dart";
import "../../../shared/widget/app_button.dart";
import "../../../shared/widget/book_card.dart";
import "../../../theme/app_text_stlye.dart";
import "../../../theme/app_theme.dart";
import "../../../utils/shared_preferences_manager.dart";

class IndexAllBooks extends StatelessWidget {
  const IndexAllBooks({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.m),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          VGap.m,
          Text(
            "Semua Buku",
            style: AppTextStyle.ts14Bold,
          ),
          VGap.r,
          AlignedGridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            itemCount: 10,
            mainAxisSpacing: Sizes.r,
            crossAxisSpacing: Sizes.r,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return const BookCard();
            },
          ),
          VGap.r,
          AppButton(
            type: ButtonType.elevated,
            onPressed: () => Get.toNamed(AppRoutes.books),
            child: const Text("Lihat Semua"),
          ),
          AppButton(
            type: ButtonType.elevated,
            onPressed: () async {
              await logout().then((res) {
                if (res.data != null) {
                  log(res.data.toString());
                } else {
                  log(res.error.toString());
                }
              });
              final prefs = {
                "isLogin": false,
                "access": "",
                "refresh": "",
              };
              await AppTheme.changePerpusTheme();
              await SharedPreferencesManager.writePrefs(prefs);
              Get.offAllNamed(AppRoutes.authLibrary);
            },
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }
}
