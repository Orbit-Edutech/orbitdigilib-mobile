import 'package:dio/dio.dart';

import '../../api_client.dart';
import '../../api_path.dart';
import '../model/model_sewa.dart';

Future<APIResponse<ModelAllSewa>> getSewaMyHistory([
  Map<String, dynamic>? queryParameters,
  CancelToken? cancelToken,
]) async {
  final param = APIParam(
    path: APIPath.sewaMyHistory,
    fromJson: ModelAllSewa.fromJson,
    queryParameters: queryParameters,
  );
  final response = await apiClient.get<ModelAllSewa>(param, cancelToken);
  return response;
}
