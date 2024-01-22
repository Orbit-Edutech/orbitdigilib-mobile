import '../../sql_helper.dart';
import '../model/model_buku_sql.dart';

Future<List<Map<String, dynamic>>> getBukuLocal(SQLParam param) async {
  final result = await sqlHelper.read(param);
  return result;
}
