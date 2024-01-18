import '../../api_client.dart';
import '../../api_path.dart';
import '../model/model_koleksi.dart';

Future<APIResponse<ModelKoleksi>> getCollections([Map<String, dynamic>? qp]) async {
  final param = APIParam<ModelKoleksi>(
    path: APIPath.koleksi,
    fromJson: ModelKoleksi.fromJson,
    queryParameters: qp,
  );
  final response = await apiClient.get<ModelKoleksi>(param);
  return response;
}
