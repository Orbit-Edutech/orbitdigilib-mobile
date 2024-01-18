import '../../api_client.dart';
import '../../api_path.dart';

Future<APIResponse<dynamic>> pinjamCreateOne(String id) async {
  final param = APIParam<dynamic>(
    path: APIPath.pinjam,
    fromJson: (data) => data,
    data: {"bukuPerpustakaanId": id},
  );
  final response = await apiClient.post<dynamic>(param);
  return response;
}
