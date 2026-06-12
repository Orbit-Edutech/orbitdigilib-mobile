import '../../api_client.dart';
import '../../api_path.dart';
import '../model/model_topup.dart';

Future<APIResponse<Topup>> getTopupStatus(String id) async {
  final param = APIParam<Topup>(
    path: APIPath.topupStatus(id),
    fromJson: Topup.fromJson,
  );
  return apiClient.get<Topup>(param);
}
