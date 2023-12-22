import '../../api_client.dart';
import '../../api_path.dart';
import '../model/model_auth_forgot.dart';

Future<APIResponse<AuthForgot>> forgotPassword(String email) async {
  final param = APIParam(
    path: APIPath.forgotPassword,
    fromJson: AuthForgot.fromJson,
    data: {"email": email},
  );
  final response = await apiClient.post(param);
  return response;
}
