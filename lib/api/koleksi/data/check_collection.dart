import '../../api_client.dart';
import '../../api_path.dart';

Future<APIResponse<dynamic>> checkCollection(String id) async {
  final param = APIParam<dynamic>(path: APIPath.koleksiCheck(id), fromJson: (data) => data);
  final response = await apiClient.get<dynamic>(param);
  return response;
}
