import '../../api_client.dart';
import '../../api_path.dart';
import '../model/model_perpustakaan.dart';

Future<APIResponse<Perpustakaan>> getOnePerpustakaan(String kode) async {
  final param = APIParam(
    path: APIPath.perpustakaanGetOne(kode),
    fromJson: Perpustakaan.fromJson,
  );
  final response = await apiClient.get(param);
  return response;
}
