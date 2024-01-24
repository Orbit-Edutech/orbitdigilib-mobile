import '../../sql_helper.dart';
import '../model/model_buku_sql.dart';

Future<List<ModelBukuSql>> getBukuSQLite() async {
  final param = SQLParam(table: sqlHelper.constants.table.buku);
  final datas = await sqlHelper.read(param);
  print(datas);
  final result = datas.map((e) => ModelBukuSql.fromJson(e)).toList();
  return result;
}
