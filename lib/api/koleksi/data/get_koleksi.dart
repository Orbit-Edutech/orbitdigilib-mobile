import '../../api_client.dart';
import '../../api_path.dart';

Future<APIResponse<dynamic>> getCollections() async {
  final param = APIParam<dynamic>(path: APIPath.koleksi, fromJson: (data) => data);
  final response = await apiClient.get<dynamic>(param);
  return response;
}
