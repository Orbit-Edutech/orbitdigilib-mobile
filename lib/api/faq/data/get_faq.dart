import '../../api_client.dart';
import '../../api_path.dart';
import '../model/model_faq.dart';

Future<APIResponse<ModelFaq>> getFaq() async {
  final param = APIParam<ModelFaq>(
    path: APIPath.faq,
    fromJson: ModelFaq.fromJson,
  );
  final response = await apiClient.get<ModelFaq>(param);
  return response;
}
