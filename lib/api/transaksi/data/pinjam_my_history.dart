import 'package:dio/dio.dart';

import '../../api_client.dart';
import '../../api_path.dart';
import '../model/model_pinjam.dart';

Future<APIResponse<ModelAllPinjam>> getPinjamMyHistory([
  Map<String, dynamic>? queryParameters,
  CancelToken? cancelToken,
]) async {
  final param = APIParam(
    path: APIPath.pinjamMyHistory,
    fromJson: ModelAllPinjam.fromJson,
    queryParameters: queryParameters,
  );
  final response = await apiClient.get<ModelAllPinjam>(param, cancelToken);
  return response;
}
