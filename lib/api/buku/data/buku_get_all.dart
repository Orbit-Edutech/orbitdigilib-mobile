import '../../api_client.dart';
import '../../api_path.dart';
import '../model/model_all_buku.dart';

Future<APIResponse<ModelAllBuku>> getAllBuku([Map<String, dynamic>? queryParameters]) async {
  final param = APIParam(
    path: APIPath.allBuku,
    fromJson: ModelAllBuku.fromJson,
    queryParameters: queryParameters,
  );
  final response = await apiClient.get<ModelAllBuku>(param);
  return response;
}
