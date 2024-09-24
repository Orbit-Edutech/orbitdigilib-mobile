import '../../api_client.dart';
import '../../api_path.dart';
import '../model/model_resensi_poin_membaca.dart';

Future<APIResponse<ResensiPoinMembaca>> postResensi({required String bukuId, required String resensi}) async {
  final param = APIParam(
    path: APIPath.resensiPoinMembaca(bukuId),
    data: {"resensi": resensi},
    fromJson: ResensiPoinMembaca.fromJson,
  );
  final response = await apiClient.post(param);
  return response;
}
