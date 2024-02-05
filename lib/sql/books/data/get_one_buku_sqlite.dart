import 'dart:developer';

import '../../sql_helper.dart';
import '../model/model_buku_sql.dart';

Future<ModelBukuSql> getOneBukuSQLite(String idBuku, String idUser) async {
  final param = SQLParam(
    table: sqlHelper.constants.table.buku,
    where: "id_buku = ? and id_user= ?",
    whereArgs: [idBuku, idUser],
  );
  final datas = await sqlHelper.read(param);
  log(datas.toString());
  final result = ModelBukuSql.fromJson(datas[0]);
  return result;
}
