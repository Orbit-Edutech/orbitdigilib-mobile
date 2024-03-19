import '../../api_client.dart';
import '../../api_path.dart';
import '../model/model_auth_login.dart';

Future<APIResponse<AuthLogin>> login({
  required String username,
  required String password,
  required String idPerpustakaan,
}) async {
  final payload = {
    "username": username,
    "password": password,
    "idPerpustakaan": idPerpustakaan,
  };
  final param = APIParam(
    path: APIPath.login,
    fromJson: AuthLogin.fromJson,
    data: payload,
  );
  final response = await apiClient.post(param);
  return response;
}
