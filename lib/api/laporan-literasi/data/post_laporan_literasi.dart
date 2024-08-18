import '../../api_client.dart';
import '../../api_path.dart';

Future<APIResponse<dynamic>> postLaporanLiterasi({
  required String? bukuId,
  required int halaman,
  required int durasi,
  required DateTime waktuMembaca,
}) async {
  final payload = {
    "bukuId": bukuId,
    "durasiHalaman": [
      {
        "halaman": halaman,
        "durasi": durasi,
        "waktuMembaca": waktuMembaca.toIso8601String(),
      }
    ]
  };
  final param = APIParam(
    path: APIPath.laporanLiterasi,
    fromJson: (e) => e,
    data: payload,
  );
  final response = await apiClient.post(param);
  return response;
}
