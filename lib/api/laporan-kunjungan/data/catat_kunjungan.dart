import '../../api_client.dart';
import '../../api_path.dart';

Future<void> catatKunjungan() async {
  final param = APIParam(
    path: APIPath.catatKunjungan,
    fromJson: (e) => e,
    data: {"platform": "mobile"},
  );
  await apiClient.post(param);
}
