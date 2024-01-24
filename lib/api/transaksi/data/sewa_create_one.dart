import '../../api_client.dart';
import '../../api_path.dart';
import '../model/model_sewa.dart';

Future<APIResponse<ModelSewa>> sewaCreateOne(String bukuId) async {
  final param = APIParam<ModelSewa>(
    path: APIPath.sewa,
    fromJson: ModelSewa.fromJson,
    data: {"bukuId": bukuId},
  );
  final response = await apiClient.post<ModelSewa>(param);
  return response;
}
