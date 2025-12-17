import '../../sql_helper.dart';
import '../model/model_stared_pages_sql.dart';

Future<List<ModelStaredPagesSql>> getStaredPagesSQLite(String idBuku, String idUser) async {
  final param = SQLParam(
    table: sqlHelper.constants.table.bukuHalamanBintang,
    where: "id_buku = ? and id_user = ?",
    whereArgs: [idBuku, idUser],
  );
  final datas = await sqlHelper.read(param);
  final result = datas.map((e) => ModelStaredPagesSql.fromJson(e)).toList();
  return result;
}
