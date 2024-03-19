import '../../api_client.dart';
import '../../api_path.dart';
import '../model/model_auth_profile.dart';

Future<APIResponse<AuthProfile>> authProfile() async {
  final param = APIParam<AuthProfile>(path: APIPath.profile, fromJson: AuthProfile.fromJson);
  final response = apiClient.get<AuthProfile>(param);
  return response;
}
