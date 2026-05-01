import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';
import '../../../theme/app_text_stlye.dart';
import '../../../utils/compute_luminance.dart';
import '../controller/profile_controller.dart';

class KartuAnggotaWidget extends StatelessWidget {
  const KartuAnggotaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = Get.find<ProfileController>();
    final profile = controller.profile.value;

    if (profile == null) return const SizedBox.shrink();

    final primaryColor = theme.primaryColor;
    final textColor = calculateLuminance(primaryColor);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.r),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              primaryColor,
              HSLColor.fromColor(primaryColor).withLightness(
                (HSLColor.fromColor(primaryColor).lightness - 0.15).clamp(0.0, 1.0),
              ).toColor(),
            ],
          ),
          borderRadius: BorderRadius.circular(Sizes.r),
          boxShadow: [
            BoxShadow(
              color: primaryColor.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(Sizes.sm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "KARTU ANGGOTA",
                    style: AppTextStyle.ts12CBold.copyWith(
                      color: textColor.withValues(alpha: 0.8),
                      letterSpacing: 2,
                    ),
                  ),
                  Icon(
                    Icons.library_books_rounded,
                    color: textColor.withValues(alpha: 0.6),
                    size: 20,
                  ),
                ],
              ),
              VGap.r,
              // Content: Photo + Info
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Photo
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(Sizes.s),
                      border: Border.all(
                        color: textColor.withValues(alpha: 0.3),
                        width: 2,
                      ),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: profile.urlFotoProfil != null
                        ? Image.network(
                            profile.urlFotoProfil.toString(),
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => _buildPlaceholderIcon(profile.jenisKelamin),
                          )
                        : _buildPlaceholderIcon(profile.jenisKelamin),
                  ),
                  HGap.r,
                  // Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profile.nama ?? "-",
                          style: AppTextStyle.ts16Bold.copyWith(color: textColor),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        VGap.xs,
                        _buildInfoRow(
                          Icons.badge_outlined,
                          profile.nomorKeanggotaan ?? "-",
                          textColor,
                        ),
                        VGap.xs,
                        _buildInfoRow(
                          Icons.account_balance_outlined,
                          profile.perpustakaan?.nama ?? "-",
                          textColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              VGap.r,
              // Divider
              Container(
                height: 1,
                color: textColor.withValues(alpha: 0.2),
              ),
              VGap.s,
              // Footer
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "ORBIT DIGILIB",
                    style: AppTextStyle.ts10Bold.copyWith(
                      color: textColor.withValues(alpha: 0.6),
                      letterSpacing: 1.5,
                    ),
                  ),
                  Text(
                    profile.perpustakaan?.kode ?? "",
                    style: AppTextStyle.ts10Bold.copyWith(
                      color: textColor.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholderIcon(String? jenisKelamin) {
    return Icon(
      jenisKelamin == "Perempuan" ? Icons.person_2 : Icons.person,
      size: 44,
      color: Colors.grey.shade400,
    );
  }

  Widget _buildInfoRow(IconData icon, String text, Color textColor) {
    return Row(
      children: [
        Icon(icon, size: 14, color: textColor.withValues(alpha: 0.7)),
        HGap.xs,
        Expanded(
          child: Text(
            text,
            style: AppTextStyle.ts12Reg.copyWith(
              color: textColor.withValues(alpha: 0.9),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
