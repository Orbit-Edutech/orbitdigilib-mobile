import '../../api_client.dart';
import '../../api_path.dart';
import '../model/model_pinjam.dart';

Future<APIResponse<ModelPinjam>> pinjamCreateOne(String id) async {
  final param = APIParam<ModelPinjam>(
    path: APIPath.pinjam,
    fromJson: ModelPinjam.fromJson,
    data: {"bukuPerpustakaanId": id},
  );
  final response = await apiClient.post<ModelPinjam>(param);
  return response;
}
