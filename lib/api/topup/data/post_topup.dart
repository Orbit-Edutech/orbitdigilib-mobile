import '../../api_client.dart';
import '../../api_path.dart';
import '../model/model_topup.dart';

Future<APIResponse<Topup>> postTopup({
  String? paketTokenId,
  int? customAmount,
  required String metode,
  String? bankCode,
}) async {
  final param = APIParam<Topup>(
    path: APIPath.topup,
    fromJson: Topup.fromJson,
    data: {
      if (paketTokenId != null) "paketTokenId": paketTokenId,
      if (customAmount != null) "customAmount": customAmount,
      "metode": metode,
      if (bankCode != null) "bankCode": bankCode,
    },
  );
  return apiClient.post<Topup>(param);
}
