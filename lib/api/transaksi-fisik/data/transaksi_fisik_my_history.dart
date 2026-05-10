import 'package:dio/dio.dart';

import '../../api_client.dart';
import '../../api_path.dart';
import '../model/model_transaksi_fisik.dart';

Future<APIResponse<ModelAllTransaksiFisik>> getTransaksiFisikMyHistory([
  Map<String, dynamic>? queryParameters,
  CancelToken? cancelToken,
]) async {
  final param = APIParam(
    path: APIPath.transaksiFisikMyHistory,
    fromJson: ModelAllTransaksiFisik.fromJson,
    queryParameters: queryParameters,
  );
  final response =
      await apiClient.get<ModelAllTransaksiFisik>(param, cancelToken);
  return response;
}
