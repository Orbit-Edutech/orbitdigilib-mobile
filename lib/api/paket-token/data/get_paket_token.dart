import '../../api_client.dart';
import '../../api_path.dart';
import '../model/model_paket_token.dart';

Future<APIResponse<PaketTokenList>> getPaketToken() async {
  final param = APIParam<PaketTokenList>(
    path: APIPath.paketToken,
    fromJson: PaketTokenList.fromJson,
  );
  return apiClient.get<PaketTokenList>(param);
}
