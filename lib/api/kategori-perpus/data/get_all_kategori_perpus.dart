import '../../api_client.dart';
import '../../api_path.dart';
import '../model/model_kategori_perpus_all.dart';

Future<APIResponse<KategoriPerpusAll>> getAllKategoriPerpus() async {
  final param = APIParam<KategoriPerpusAll>(
    path: APIPath.kategoriBukuPerpustakaan,
    fromJson: KategoriPerpusAll.fromJson,
  );
  final response = await apiClient.get<KategoriPerpusAll>(param);
  return response;
}
