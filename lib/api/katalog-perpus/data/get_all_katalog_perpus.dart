import '../../api_client.dart';
import '../../api_path.dart';
import '../model/model_katalog_perpus_all.dart';

Future<APIResponse<KatalogPerpusAll>> getAllKatalogPerpus() async {
  final param = APIParam<KatalogPerpusAll>(
    path: APIPath.katalogBukuPerpustakaan,
    fromJson: KatalogPerpusAll.fromJson,
  );
  final response = await apiClient.get<KatalogPerpusAll>(param);
  return response;
}
