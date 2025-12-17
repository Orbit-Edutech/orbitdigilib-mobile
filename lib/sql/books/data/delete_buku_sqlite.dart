import '../../sql_helper.dart';

Future<int> deleteBukuSQLite({required String idBuku, required String idUser}) async {
  final param = SQLParam(
    table: sqlHelper.constants.table.buku,
    where: "id_buku = ? and id_user = ?",
    whereArgs: [idBuku, idUser],
  );
  final result = await sqlHelper.delete(param);
  return result;
}
