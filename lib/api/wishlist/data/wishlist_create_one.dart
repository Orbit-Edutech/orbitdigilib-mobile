import 'package:dio/dio.dart';

import '../../api_client.dart';
import '../../api_path.dart';
import '../model/model_wishlist_all.dart';

Future<APIResponse<Wishlist>> createOneWishlist(String id, [CancelToken? cancelToken]) async {
  final param = APIParam<Wishlist>(
    path: APIPath.wishlist,
    fromJson: Wishlist.fromJson,
    data: {"bukuPerpustakaanId": id},
  );
  final response = await apiClient.post<Wishlist>(param, cancelToken);
  return response;
}
