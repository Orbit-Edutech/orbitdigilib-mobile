import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';
import '../../../shared/widget/app_button.dart';
import '../../../shared/widget/app_textfield.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_text_stlye.dart';
import '../controller/auth_user_controller.dart';

class AuthRegisterForm extends StatefulWidget {
  const AuthRegisterForm({super.key, required this.controller});

  final AuthUserController controller;

  @override
  State<AuthRegisterForm> createState() => _AuthRegisterFormState();
}

class _AuthRegisterFormState extends State<AuthRegisterForm> {
  late TextEditingController passwordConfirmController;
  late FocusNode usernameFocusNode;
  late FocusNode emailFocusNode;
  late FocusNode namaFocusNode;
  late FocusNode passwordFocusNode;
  late FocusNode passwordConfirmFocusNode;
  late FocusNode noTeleponFocusNode;

  @override
  void initState() {
    super.initState();
    passwordConfirmController = TextEditingController();
    usernameFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    namaFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    passwordConfirmFocusNode = FocusNode();
    noTeleponFocusNode = FocusNode();
  }

  @override
  void dispose() {
    passwordConfirmController.dispose();
    usernameFocusNode.dispose();
    emailFocusNode.dispose();
    namaFocusNode.dispose();
    passwordFocusNode.dispose();
    passwordConfirmFocusNode.dispose();
    noTeleponFocusNode.dispose();
    super.dispose();
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    if (value.length < 8) {
      return "Password minimal 8 karakter";
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return "Password harus mengandung huruf besar (A-Z)";
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return "Password harus mengandung huruf kecil (a-z)";
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return "Password harus mengandung angka (0-9)";
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return "Password harus mengandung simbol (!@#\$%^&*)";
    }
    return null;
  }

  String? _validatePasswordConfirm(String? value) {
    if (value != widget.controller.passwordController.text) {
      return "Konfirmasi password tidak cocok";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(() {
        final isLoading = widget.controller.registerButtonState.value == ButtonState.loading;
        final isError = widget.controller.isRegisterError.value;
        final errorMsg = widget.controller.registerErrorMsg.value;

        return Column(
          children: [
            if (isError)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(Sizes.m),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      border: Border.all(color: Colors.red.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      errorMsg,
                      style: AppTextStyle.ts12Reg.copyWith(color: Colors.red.shade700),
                    ),
                  ),
                  VGap.r,
                ],
              ),
            AppTextField(
              type: TextFieldType.normal,
              controller: widget.controller.usernameController,
              focusNode: usernameFocusNode,
              onTapOutside: (_) => usernameFocusNode.unfocus(),
              onChanged: widget.controller.onRegisterFormChange,
              onSubmitted: (_) => emailFocusNode.requestFocus(),
              enabled: !isLoading,
              isError: false,
              label: Text("Username (min 3 karakter)", style: AppTextStyle.ts14Reg),
            ),
            VGap.r,
            AppTextField(
              type: TextFieldType.normal,
              controller: widget.controller.emailController,
              focusNode: emailFocusNode,
              onTapOutside: (_) => emailFocusNode.unfocus(),
              onChanged: widget.controller.onRegisterFormChange,
              onSubmitted: (_) => namaFocusNode.requestFocus(),
              enabled: !isLoading,
              isError: false,
              label: Text("Email", style: AppTextStyle.ts14Reg),
              keyboardType: TextInputType.emailAddress,
            ),
            VGap.r,
            AppTextField(
              type: TextFieldType.normal,
              controller: widget.controller.namaController,
              focusNode: namaFocusNode,
              onTapOutside: (_) => namaFocusNode.unfocus(),
              onChanged: widget.controller.onRegisterFormChange,
              onSubmitted: (_) => noTeleponFocusNode.requestFocus(),
              enabled: !isLoading,
              isError: false,
              label: Text("Nama Lengkap", style: AppTextStyle.ts14Reg),
            ),
            VGap.r,
            if (!Platform.isIOS && !Platform.isMacOS)
              Obx(() {
                final selectedGender = widget.controller.selectedJenisKelamin.value;
                return DropdownButtonFormField<String>(
                  value: selectedGender,
                  decoration: InputDecoration(
                    labelText: "Jenis Kelamin",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabled: !isLoading,
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: "Laki-Laki",
                      child: Text("Laki-laki"),
                    ),
                    DropdownMenuItem(
                      value: "Perempuan",
                      child: Text("Perempuan"),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      widget.controller.selectedJenisKelamin.value = value;
                    }
                  },
                );
              }),
            VGap.r,
            AppTextField(
              type: TextFieldType.normal,
              controller: widget.controller.noTeleponController,
              focusNode: noTeleponFocusNode,
              onTapOutside: (_) => noTeleponFocusNode.unfocus(),
              enabled: !isLoading,
              isError: false,
              label: Text("No. Telepon (opsional)", style: AppTextStyle.ts14Reg),
              keyboardType: TextInputType.phone,
              onSubmitted: (_) => passwordFocusNode.requestFocus(),
            ),
            VGap.r,
            Obx(() {
              final isObscure = widget.controller.isObscure.value;
              final passwordError = _validatePassword(widget.controller.passwordController.text);
              return AppTextField(
                type: TextFieldType.normal,
                controller: widget.controller.passwordController,
                focusNode: passwordFocusNode,
                onTapOutside: (_) => passwordFocusNode.unfocus(),
                onChanged: (value) {
                  setState(() {});
                  widget.controller.onRegisterFormChange(value);
                },
                enabled: !isLoading,
                isError: passwordError != null,
                errorText: passwordError ?? "",
                isObscure: isObscure,
                suffix: GestureDetector(
                  onTap: widget.controller.toggleObscure,
                  child: Icon(
                    isObscure ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                    color: AppColor.lightGrey,
                  ),
                ),
                label: Text(
                  "Password",
                  style: AppTextStyle.ts14Reg,
                ),
                onSubmitted: (_) => passwordConfirmFocusNode.requestFocus(),
              );
            }),
            VGap.r,
            Obx(() {
              final isObscure = widget.controller.isObscure.value;
              final confirmError = _validatePasswordConfirm(passwordConfirmController.text);
              return AppTextField(
                type: TextFieldType.normal,
                controller: passwordConfirmController,
                focusNode: passwordConfirmFocusNode,
                onTapOutside: (_) => passwordConfirmFocusNode.unfocus(),
                onChanged: (value) {
                  setState(() {});
                },
                enabled: !isLoading,
                isError: confirmError != null,
                errorText: confirmError ?? "",
                isObscure: isObscure,
                suffix: GestureDetector(
                  onTap: widget.controller.toggleObscure,
                  child: Icon(
                    isObscure ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                    color: AppColor.lightGrey,
                  ),
                ),
                label: Text(
                  "Konfirmasi Password",
                  style: AppTextStyle.ts14Reg,
                ),
              );
            }),
            VGap.r,
            Obx(() {
              final state = widget.controller.registerButtonState.value;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppButton(
                    type: ButtonType.elevated,
                    state: state,
                    onPressed: widget.controller.onSubmitRegister,
                    child: const Text("Daftar"),
                  ),
                  VGap.s,
                  AppButton(
                    type: ButtonType.outlined,
                    state: state == ButtonState.disable ? ButtonState.enable : state,
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Kembali"),
                  ),
                ],
              );
            }),
            VGap.h,
          ],
        );
      }),
    );
  }
}
