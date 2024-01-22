import '../../sql_helper.dart';

import '../model/model_buku_sql.dart';

Future<int> insertBukuLocal<T>(ModelBukuSql value) async {
  final param = SQLParam<ModelBukuSql>(
    table: sqlHelper.constants.table.buku,
    values: value.toJson(),
  );
  final result = await sqlHelper.insert(param);
  return result;
}
