import '../../katalog-perpus/model/model_katalog_perpus_all.dart';
import 'model_all_buku_perpustakaan.dart';

class CategoriesBooks {
  KatalogBukuPerpustakaan category;
  List<Payload> books;

  CategoriesBooks({required this.category, required this.books});
}
