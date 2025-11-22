import '../../api_client.dart';
import '../../api_path.dart';
import '../model/model_auth_register.dart';

Future<APIResponse<AuthRegister>> register({
  required String username,
  required String email,
  required String password,
  required String nama,
  required String jenisKelamin,
  String? noTelepon,
  String? kodePerpustakaan,
}) async {
  final payload = {
    "username": username,
    "email": email,
    "password": password,
    "nama": nama,
    "jenisKelamin": jenisKelamin,
    if (noTelepon != null && noTelepon.isNotEmpty) "noTelepon": noTelepon,
    if (kodePerpustakaan != null && kodePerpustakaan.isNotEmpty) "kodePerpustakaan": kodePerpustakaan,
  };
  final param = APIParam(
    path: APIPath.register,
    fromJson: AuthRegister.fromJson,
    data: payload,
  );
  final response = await apiClient.post(param);
  return response;
}
