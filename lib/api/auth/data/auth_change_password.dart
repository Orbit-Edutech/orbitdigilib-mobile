import '../../api_client.dart';
import '../../api_path.dart';
import '../model/model_auth_change_password.dart';

Future<APIResponse<AuthChangePassword>> changePassword({
  required String oldPass,
  required String newPass,
}) async {
  final param = APIParam<AuthChangePassword>(
    path: APIPath.changePassword,
    fromJson: AuthChangePassword.fromJson,
    data: {"currentPassword": oldPass, "newPassword": newPass},
  );
  final response = await apiClient.patch<AuthChangePassword>(param);
  return response;
}
