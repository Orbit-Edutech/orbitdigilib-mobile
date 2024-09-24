import '../../api_client.dart';
import '../../api_path.dart';
import '../model/model_resensi_poin_membaca.dart';

Future<APIResponse<ResensiPoinMembaca>> getResensi(String bukuId) async {
  final param = APIParam(
    path: APIPath.resensiPoinMembaca(bukuId),
    fromJson: ResensiPoinMembaca.fromJson,
  );
  final response = await apiClient.get(param);
  return response;
}
