import '../../sql_helper.dart';

Future<int> deleteStaredPageSQLite({
  required String idBuku,
  required String idUser,
  required int halaman,
}) async {
  final param = SQLParam(
    table: sqlHelper.constants.table.bukuHalamanBintang,
    where: "id_buku = ?  and id_user = ? and halaman = ?",
    whereArgs: [idBuku, idUser, halaman],
  );
  final result = await sqlHelper.delelte(param);
  return result;
}
