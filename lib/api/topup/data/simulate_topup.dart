import '../../api_client.dart';
import '../../api_path.dart';
import '../model/model_topup.dart';

/// SANDBOX ONLY: minta backend menandai transaksi PAID + kredit token tanpa bayar nyata.
/// Backend menolak (403) bila bukan mode sandbox.
Future<APIResponse<Topup>> simulateTopup(String id) async {
  final param = APIParam<Topup>(
    path: APIPath.topupSimulate(id),
    fromJson: Topup.fromJson,
    data: const {},
  );
  return apiClient.post<Topup>(param);
}
