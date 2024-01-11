import '../../kategori-perpus/model/model_kategori_perpus_all.dart';
import 'model_all_buku_perpustakaan.dart';

class CategoriesBooks {
  KategoriBukuPerpustakaan category;
  List<Payload> books;

  CategoriesBooks({required this.category, required this.books});
}
