import '../../api_client.dart';
import '../../api_path.dart';
import '../model/model_perpustakaan_banner_default.dart';

Future<APIResponse<BannerDefault>> getBannerDefault(String kode) async {
  final param = APIParam(
    path: APIPath.bannerDefault,
    fromJson: BannerDefault.fromJson,
  );
  final response = await apiClient.get(param);
  return response;
}
