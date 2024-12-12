import '../../api_client.dart';
import '../../api_path.dart';
import '../model/model_last_access.dart';

Future<APIResponse<ModelLastAccess>> getLastAccess() async {
  final param = APIParam(path: APIPath.lastAccess, fromJson: ModelLastAccess.fromJson);
  final response = await apiClient.get<ModelLastAccess>(param);
  return response;
}
