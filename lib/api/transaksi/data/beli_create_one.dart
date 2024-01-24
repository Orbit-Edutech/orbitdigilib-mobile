import '../../api_client.dart';
import '../../api_path.dart';
import '../model/model_beli.dart';

Future<APIResponse<ModelBeli>> beliCreateOne(String idBuku) async {
  final param = APIParam<ModelBeli>(
    path: APIPath.beli,
    fromJson: ModelBeli.fromJson,
    data: {"bukuId": idBuku},
  );
  final response = await apiClient.post<ModelBeli>(param);
  return response;
}
