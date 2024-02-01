import '../../sql_helper.dart';

Future<int> insertStaredPageSQLite({
  required String idBuku,
  required String idUser,
  required int halaman,
}) async {
  final param = SQLParam(
    table: sqlHelper.constants.table.bukuHalamanBintang,
    values: {"id_buku": idBuku, "id_user": idUser, "halaman": halaman},
  );
  final result = await sqlHelper.insert(param);
  return result;
}
