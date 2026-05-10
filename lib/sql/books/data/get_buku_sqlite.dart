import '../../sql_helper.dart';
import '../model/model_buku_sql.dart';

Future<List<ModelBukuSql>> getBukuSQLite(String idUser) async {
  final param = SQLParam(table: sqlHelper.constants.table.buku, where: "id_user = ?", whereArgs: [idUser]);
  final datas = await sqlHelper.read(param);
  final result = datas.map((e) => ModelBukuSql.fromJson(e)).toList();
  return result;
}
