import '../../api_client.dart';
import '../../api_path.dart';

Future<APIResponse<dynamic>> catatKunjungan({
  String platform = 'mobile',
}) async {
  final payload = {
    "platform": platform,
  };
  final param = APIParam(
    path: APIPath.catatKunjungan,
    fromJson: (e) => e,
    data: payload,
  );
  final response = await apiClient.post(param);
  return response;
}
