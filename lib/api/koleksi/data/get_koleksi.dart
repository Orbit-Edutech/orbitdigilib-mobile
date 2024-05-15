import 'package:dio/dio.dart';

import '../../api_client.dart';
import '../../api_path.dart';
import '../model/model_koleksi.dart';

Future<APIResponse<ModelKoleksi>> getCollections([
  Map<String, dynamic>? qp,
  CancelToken? cancelToken,
]) async {
  final param = APIParam<ModelKoleksi>(
    path: APIPath.koleksi,
    fromJson: ModelKoleksi.fromJson,
    queryParameters: qp,
  );
  final response = await apiClient.get<ModelKoleksi>(param, cancelToken);
  return response;
}
