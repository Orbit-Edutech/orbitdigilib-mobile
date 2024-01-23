import '../../api_client.dart';
import '../../api_path.dart';
import '../model/model_buku.dart';

Future<APIResponse<ModelBuku>> getOneBuku(String id) async {
  final param = APIParam(path: APIPath.oneBuku(id), fromJson: ModelBuku.fromJson);
  final response = await apiClient.get(param);
  return response;
}
