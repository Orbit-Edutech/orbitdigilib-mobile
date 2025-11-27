import '../../api_client.dart';
import '../../api_path.dart';
import '../model/model_auth_register.dart';

Future<APIResponse<AuthRegister>> register({
  required String username,
  required String email,
  required String password,
  required String nama,
  required String jenisKelamin,
  required String kodePerpustakaan,
  String? noTelepon,
}) async {
  final payload = {
    "username": username,
    "email": email,
    "password": password,
    "nama": nama,
    "jenisKelamin": jenisKelamin,
    "kodePerpustakaan": kodePerpustakaan,
    if (noTelepon != null && noTelepon.isNotEmpty) "noTelepon": noTelepon,
  };
  final param = APIParam(
    path: APIPath.register,
    fromJson: AuthRegister.fromJson,
    data: payload,
  );
  final response = await apiClient.post(param);
  return response;
}
