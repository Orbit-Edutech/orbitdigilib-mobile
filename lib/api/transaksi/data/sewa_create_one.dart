import '../../api_client.dart';
import '../../api_path.dart';

Future<APIResponse<dynamic>> sewaCreateOne(String bukuId) async {
  final param = APIParam<dynamic>(
    path: APIPath.sewa,
    fromJson: (data) => data,
    data: {"bukuId": bukuId},
  );
  final response = await apiClient.post<dynamic>(param);
  return response;
}
