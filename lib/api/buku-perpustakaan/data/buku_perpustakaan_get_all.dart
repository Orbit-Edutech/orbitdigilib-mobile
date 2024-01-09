import '../../api_client.dart';
import '../../api_path.dart';
import '../model/model_all_buku_perpustakaan.dart';

Future<APIResponse<ModelAllBukuPerpustakaan>> getAllBukuPerpustakaan([Map<String, dynamic>? queryParameters]) async {
  final param = APIParam(
    path: APIPath.allBukuPerpus,
    fromJson: ModelAllBukuPerpustakaan.fromJson,
    queryParameters: queryParameters,
  );
  final response = await apiClient.get<ModelAllBukuPerpustakaan>(param);
  return response;
}
