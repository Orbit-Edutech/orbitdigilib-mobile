import '../../api_client.dart';
import '../../api_path.dart';
import '../model/model_wishlist_all.dart';

Future<APIResponse<Wishlist>> createOneWishlist(String id) async {
  final param = APIParam<Wishlist>(
    path: APIPath.wishlist,
    fromJson: Wishlist.fromJson,
    data: {"bukuPerpustakaanId": id},
  );
  final response = await apiClient.post<Wishlist>(param);
  return response;
}
