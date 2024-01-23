import 'package:dio/dio.dart';

import '../../api_client.dart';
import '../../api_path.dart';
import '../model/model_wishlist_all.dart';

Future<APIResponse<WishlistAll>> getAllWishlist([CancelToken? cancelToken]) async {
  final param = APIParam<WishlistAll>(
    path: APIPath.wishlist,
    fromJson: WishlistAll.fromJson,
  );
  final response = await apiClient.get<WishlistAll>(param, cancelToken);
  return response;
}
