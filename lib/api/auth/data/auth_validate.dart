import '../../api_client.dart';
import '../../api_path.dart';
import '../model/model_auth_validate.dart';

Future<APIResponse<AuthValidate>> authValidate() async {
  final param = APIParam(
    path: APIPath.validate,
    fromJson: AuthValidate.fromJson,
  );
  final response = await apiClient.post(param);
  return response;
}
