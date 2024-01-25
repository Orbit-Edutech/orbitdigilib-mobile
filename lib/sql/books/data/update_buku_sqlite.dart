import '../../sql_helper.dart';

Future<int> updateBukuSQLite({
  required String bukuId,
  required String userId,
  required Map<String, Object> values,
}) async {
  final param = SQLParam(
    table: sqlHelper.constants.table.buku,
    values: values,
    where: "id_buku = ? and id_user = ?",
    whereArgs: [bukuId, userId],
  );
  final result = await sqlHelper.update(param);
  return result;
}
