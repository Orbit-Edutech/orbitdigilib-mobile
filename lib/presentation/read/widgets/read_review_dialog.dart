import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../../api/poin-membaca/data/check_status_poin_membaca.dart';
import '../../../api/poin-membaca/data/get_resensi_poin_membaca.dart';
import '../../../api/poin-membaca/data/post_resensi_poin_membaca.dart';
import '../../../shared/widget/app_button.dart';
import '../../../shared/widget/app_textfield.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_text_stlye.dart';

class ReadReviewDialog extends StatefulWidget {
  const ReadReviewDialog({
    super.key,
    required this.reviewController,
    required this.reviewFocusNode,
    this.bukuId,
  });

  final TextEditingController reviewController;
  final FocusNode reviewFocusNode;
  final String? bukuId;

  @override
  State<ReadReviewDialog> createState() => _ReadReviewDialogState();
}

class _ReadReviewDialogState extends State<ReadReviewDialog> {
  bool isAllowedToReview = false;
  bool isLoading = true;
  double readProgress = 0.0;

  @override
  void initState() {
    getResensi(widget.bukuId ?? '').then((res) {
      widget.reviewController.text = res.data?.resensi ?? "";
    });
    setState(() {
      isLoading = true;
    });
    checkStatusPoinMembaca(widget.bukuId ?? "").then((res) {
      if (res.data != null) {
        if ((res.data?.persentaseBacaBuku ?? 0.0) > 80.0) {
          setState(() {
            isAllowedToReview = true;
          });
        } else {
          setState(() {
            isAllowedToReview = true;
          });
          setState(() {
            readProgress = res.data?.persentaseBacaBuku ?? 0.0;
          });
        }
      }
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColor.white,
      surfaceTintColor: AppColor.white,
      title: const Text("Resensi"),
      content: isLoading
          ? const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
              ],
            )
          : isAllowedToReview
              ? AppTextField(
                  type: TextFieldType.normal,
                  controller: widget.reviewController,
                  focusNode: widget.reviewFocusNode,
                  keyboardType: TextInputType.multiline,
                  isError: false,
                  autoFocus: true,
                  onSubmitted: (text) {},
                  onChanged: (text) {},
                  maxLines: 8,
                  label: Text(
                    "Pesan",
                    style: AppTextStyle.ts14Reg.copyWith(color: AppColor.grey),
                  ),
                )
              : Text("Anda belum dapat memberi resensi, karena Anda belum menyelesaikan buku ini ($readProgress%)."),
      actions: isLoading
          ? []
          : [
              AppButton(
                type: ButtonType.text,
                onPressed: Get.back,
                child: Text(isAllowedToReview ? "Batal" : "Tutup"),
              ),
              if (isAllowedToReview)
                AppButton(
                  type: ButtonType.text,
                  onPressed: () {
                    postResensi(
                      bukuId: widget.bukuId ?? "",
                      resensi: widget.reviewController.text,
                    );
                    Get.back();
                  },
                  child: const Text("Kirim"),
                ),
            ],
    );
  }
}
