import '../../api_client.dart';
import '../../api_path.dart';
import '../model/model_ringkasan_bacaan.dart';

Future<APIResponse<RingkasanBacaan>> getRingkasanBacaan() async {
  final param = APIParam<RingkasanBacaan>(
    path: APIPath.ringkasanAnggota,
    fromJson: (e) => RingkasanBacaan.fromJson(e),
  );
  final response = await apiClient.get(param);
  return response;
}
