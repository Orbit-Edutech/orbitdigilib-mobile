import '../../api_client.dart';
import '../../api_path.dart';
import '../model/model_voucher_info_all.dart';

Future<APIResponse<VoucherInfoAll>> getVoucherInfoAll() async {
  final param = APIParam<VoucherInfoAll>(path: APIPath.listGetVoucherAll, fromJson: VoucherInfoAll.fromJson);
  final result = await apiClient.get<VoucherInfoAll>(param);
  return result;
}
