import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../api/model/perpus_model.dart';

class AuthUserController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode usernameFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  Rx<Perpus?> perpus = Rx<Perpus?>(null);
  Rx<bool> isError = false.obs;
  Rx<AuthUserError?> errorType = Rx<AuthUserError?>(null);

  void onSubmit() {}

  void resetError() {}
}

enum AuthUserError {
  usernameError,
  passwordError,
}
