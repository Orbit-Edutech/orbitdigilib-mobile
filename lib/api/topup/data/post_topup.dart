import '../../api_client.dart';
import '../../api_path.dart';
import '../model/model_topup.dart';

Future<APIResponse<Topup>> postTopup({
  required String paketTokenId,
  required String metode,
  String? bankCode,
}) async {
  final param = APIParam<Topup>(
    path: APIPath.topup,
    fromJson: Topup.fromJson,
    data: {
      "paketTokenId": paketTokenId,
      "metode": metode,
      if (bankCode != null) "bankCode": bankCode,
    },
  );
  return apiClient.post<Topup>(param);
}
