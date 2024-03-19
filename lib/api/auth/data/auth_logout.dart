import '../../api_client.dart';
import '../../api_path.dart';

Future<APIResponse<Map<String, dynamic>>> logout() async {
  final param = APIParam<Map<String, dynamic>>(
    path: APIPath.logout,
    fromJson: (data) => data,
  );
  final response = apiClient.post<Map<String, dynamic>>(param);
  return response;
}
