import '../../api_client.dart';
import '../../api_path.dart';
import '../model/model_all_access.dart';

Future<APIResponse<ModelAllAccess>> getAllAccess() async {
  final param = APIParam(path: APIPath.allAccess, fromJson: ModelAllAccess.fromJson);
  final response = await apiClient.get<ModelAllAccess>(param);
  return response;
}
