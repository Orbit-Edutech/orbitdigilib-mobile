import '../../api_client.dart';
import '../../api_path.dart';
import '../model/model_status_poin_membaca.dart';

Future<APIResponse<StatusPoinMembaca>> checkStatusPoinMembaca(String bukuId) async {
  final payload = {"bukuId": bukuId};
  final param = APIParam<StatusPoinMembaca>(
    path: APIPath.statusPoinMembaca(bukuId),
    fromJson: StatusPoinMembaca.fromJson,
    data: payload,
  );
  final response = await apiClient.post<StatusPoinMembaca>(param);
  return response;
}
