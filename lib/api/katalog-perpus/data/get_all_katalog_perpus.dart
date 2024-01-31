import '../../api_client.dart';
import '../../api_path.dart';
import '../model/model_katalog_perpus_all.dart';

Future<APIResponse<KategoriPerpusAll>> getAllKatalogPerpus() async {
  final param = APIParam<KategoriPerpusAll>(
    path: APIPath.katalogBukuPerpustakaan,
    fromJson: KategoriPerpusAll.fromJson,
  );
  final response = await apiClient.get<KategoriPerpusAll>(param);
  return response;
}
