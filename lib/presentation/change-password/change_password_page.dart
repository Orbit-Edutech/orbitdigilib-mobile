import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import '../../shared/widget/app_button.dart';
import '../../shared/widget/app_divider.dart';
import '../../shared/widget/app_textfield.dart';
import '../../theme/app_color.dart';
import '../../theme/app_text_stlye.dart';
import '../../utils/responsive_helper.dart';
import 'controller/change_password_controller.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = Get.find<ChangePasswordController>();
    return Scaffold(
      appBar: AppBar(title: const Text("Keamanan Akun")),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: ResponsiveHelper.getMaxContentWidth(context),
          ),
          child: Padding(
            padding: EdgeInsets.all(
              ResponsiveHelper.getHorizontalPadding(context),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
            Obx(() {
              final isFocus = controller.focus.value == "oldPass";
              final isLoading = controller.buttonState.value == ButtonState.loading;
              final isError = controller.isError.value;
              final isObscure = controller.isOldPassObscure.value;
              return Focus(
                canRequestFocus: false,
                onFocusChange: (focus) => controller.setFocus = focus ? "oldPass" : "",
                child: AppTextField(
                  type: TextFieldType.normal,
                  controller: controller.oldPassController,
                  focusNode: controller.oldPassFN,
                  onTapOutside: (_) => controller.oldPassFN.unfocus(),
                  onChanged: controller.onFormChange,
                  onSubmitted: (_) => controller.newPassFN.requestFocus(),
                  enabled: !isLoading,
                  isError: isError,
                  errorText: "",
                  isObscure: isObscure,
                  suffix: GestureDetector(
                    onTap: () {
                      controller.isOldPassObscure.value = !isObscure;
                    },
                    child: Icon(
                      isObscure ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                      color: isError
                          ? Colors.red.shade800
                          : isFocus && !isLoading
                              ? theme.primaryColor
                              : AppColor.lightGrey,
                    ),
                  ),
                  label: Text(
                    "Password Lama",
                    style: AppTextStyle.ts14Reg,
                  ),
                ),
              );
            }),
            const AppDivider(height: Sizes.xh),
            Obx(() {
              final isFocus = controller.focus.value == "newPass";
              final isLoading = controller.buttonState.value == ButtonState.loading;
              final isError = controller.isError.value;
              final isObscure = controller.isNewPassObscure.value;
              return Focus(
                canRequestFocus: false,
                onFocusChange: (focus) => controller.setFocus = focus ? "newPass" : "",
                child: AppTextField(
                  type: TextFieldType.normal,
                  controller: controller.newPassController,
                  focusNode: controller.newPassFN,
                  onTapOutside: (_) => controller.newPassFN.unfocus(),
                  onChanged: controller.onFormChange,
                  onSubmitted: (_) => controller.conPassFN.requestFocus(),
                  enabled: !isLoading,
                  isError: isError,
                  errorText: "",
                  isObscure: isObscure,
                  suffix: GestureDetector(
                    onTap: () {
                      controller.isNewPassObscure.value = !isObscure;
                    },
                    child: Icon(
                      isObscure ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                      color: isError
                          ? Colors.red.shade800
                          : isFocus && !isLoading
                              ? theme.primaryColor
                              : AppColor.lightGrey,
                    ),
                  ),
                  label: Text(
                    "Password Baru",
                    style: AppTextStyle.ts14Reg,
                  ),
                ),
              );
            }),
            VGap.r,
            Obx(() {
              final isFocus = controller.focus.value == "conPass";
              final isLoading = controller.buttonState.value == ButtonState.loading;
              final isValid = controller.buttonState.value == ButtonState.enable;
              final isError = controller.isError.value;
              final errorMsg = controller.errorMsg.value;
              final isObscure = controller.isConPassObscure.value;
              return Focus(
                canRequestFocus: false,
                onFocusChange: (focus) => controller.setFocus = focus ? "conPass" : "",
                child: AppTextField(
                  type: TextFieldType.normal,
                  controller: controller.conPassController,
                  focusNode: controller.conPassFN,
                  onTapOutside: (_) => controller.conPassFN.unfocus(),
                  onChanged: controller.onFormChange,
                  onSubmitted: (_) => isValid ? controller.resetPassword() : null,
                  enabled: !isLoading,
                  isError: isError,
                  errorText: errorMsg,
                  isObscure: isObscure,
                  suffix: GestureDetector(
                    onTap: () {
                      controller.isConPassObscure.value = !isObscure;
                    },
                    child: Icon(
                      isObscure ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                      color: isError
                          ? Colors.red.shade800
                          : isFocus && !isLoading
                              ? theme.primaryColor
                              : AppColor.lightGrey,
                    ),
                  ),
                  label: Text(
                    "Konfirmasi Password Baru",
                    style: AppTextStyle.ts14Reg,
                  ),
                ),
              );
            }),
            const Spacer(),
            Obx(() {
              final state = controller.buttonState.value;
              return AppButton(
                state: state,
                type: ButtonType.elevated,
                onPressed: controller.resetPassword,
                child: const Text("Kirim"),
              );
            })
          ],
            ),
          ),
        ),
      ),
    );
  }
}
