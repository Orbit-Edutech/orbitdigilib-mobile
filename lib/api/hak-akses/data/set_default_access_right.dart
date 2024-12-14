import '../../api_client.dart';
import '../../api_path.dart';
import '../model/model_set_default_access_right.dart';

Future<APIResponse<ModelSetDefaultAccessRight>> setDefaultAccessRight() async {
  final param = APIParam(path: APIPath.setDefaultAccessRight, fromJson: ModelSetDefaultAccessRight.fromJson);
  final response = await apiClient.post<ModelSetDefaultAccessRight>(param);
  return response;
}
