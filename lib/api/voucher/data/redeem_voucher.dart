import '../../api_client.dart';
import '../../api_path.dart';
import '../model/model_redeem.dart';

Future<APIResponse<dynamic>> redeemVoucher(String voucher) async {
  final param = APIParam<Redeem>(
    path: APIPath.redeemVoucher(voucher),
    fromJson: Redeem.fromJson,
  );
  final response = await apiClient.post<Redeem>(param);
  return response;
}
