import '../../api_client.dart';
import '../../api_path.dart';
import '../model/model_one_buku_perpustakaan.dart';

Future<APIResponse<BukuPerpustakaan>> getOneBukuPerpustakaan(String id) async {
  final param = APIParam<BukuPerpustakaan>(path: APIPath.oneBukuPerpus(id), fromJson: BukuPerpustakaan.fromJson);
  final response = await apiClient.get<BukuPerpustakaan>(param);
  return response;
}
