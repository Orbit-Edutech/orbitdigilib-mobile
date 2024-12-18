import '../../api_client.dart';
import '../../api_path.dart';
import '../model/model_check_access.dart';

Future<APIResponse<ModelCheckAccess>> checkAccess(String perpustakaanId) async {
  final param = APIParam(
    path: APIPath.checkAccess(perpustakaanId),
    fromJson: ModelCheckAccess.fromJson,
  );
  final response = await apiClient.post<ModelCheckAccess>(param);
  return response;
}
