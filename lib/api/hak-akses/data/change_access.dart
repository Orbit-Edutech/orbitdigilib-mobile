import '../../api_client.dart';
import '../../api_path.dart';
import '../model/model_change_access.dart';

Future<APIResponse<ModelChangeAccess>> changeAccess(String perpustakaanId) async {
  final param = APIParam(
    path: APIPath.changeAccess(perpustakaanId),
    fromJson: ModelChangeAccess.fromJson,
  );
  final response = await apiClient.post<ModelChangeAccess>(param);
  return response;
}
