import '../../api_client.dart';
import '../../api_path.dart';
import '../model/model_auth_perpustakaan.dart';

// TODO: Ini beneran get one perpustakaan
Future<APIResponse<AuthPerpustakaan>> getOnePerpustakaan(String kode) async {
  final param = APIParam(
    path: APIPath.perpustakaanGetOne(kode),
    fromJson: AuthPerpustakaan.fromJson,
  );
  final response = await apiClient.get(param);
  return response;
}
