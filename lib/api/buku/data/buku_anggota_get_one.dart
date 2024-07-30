import '../../api_client.dart';
import '../../api_path.dart';
import '../../koleksi/model/model_koleksi.dart';
// import '../model/model_buku_anggota.dart';

Future<APIResponse<BukuAnggota>> getOneBukuAnggota(String id) async {
  final param = APIParam(
    path: APIPath.oneBukuAnggota(id),
    fromJson: BukuAnggota.fromJson,
  );
  final response = await apiClient.get(param);
  return response;
}
