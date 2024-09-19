import 'package:novelku/app/data/models/novel.dart';
import 'package:novelku/app/data/services/db_helper.dart';
import 'package:novelku/app/pakage.dart';
import 'package:novelku/app/routes/route_name.dart';

class HomeController extends GetxController {
  var listNovel = <Novel>[].obs; // Ubah menjadi List<Novel>

  @override
  void onInit() async {
    super.onInit();
    fetchNovels(); // Memperbarui daftar novel
  }

  @override
  void onReady() {
    super.onReady();

    // Menangkap argumen saat halaman ini dipanggil
    final bool? isNovelAdded = Get.arguments as bool?;
    if (isNovelAdded == true) {
      fetchNovels(); // Memperbarui daftar novel
    }
  }

  void fetchNovels() async {
    listNovel.clear();

    var dataNovel = await DBHelper.getNovels();

    List<Novel> novelList =
        dataNovel.map((novelMap) => Novel.fromMap(novelMap)).toList();
    listNovel.addAll(novelList);
  }

  void addNovel() async {
    var result = await Get.toNamed(RouteName.addNovel);
    if (result == true) {
      fetchNovels(); // Memperbarui daftar novel
    }
  }

  void editNovel(Novel novel) async {
    var result = await Get.toNamed(RouteName.addNovel, arguments: novel);
    if (result == true) {
      fetchNovels(); // Memperbarui daftar novel
    }
  }

  void deleteNovel(int id) async {
    bool confirmDelete = await Get.dialog(
      AlertDialog(
        title: Text('Konfirmasi'),
        content: Text('Apakah Anda yakin ingin menghapus novel ini?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false), // Kembali dengan false
            child: Text('Batal'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true), // Kembali dengan true
            child: Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirmDelete == true) {
      DBHelper.deleteNovel(id);
      fetchNovels();
    }
  }

  void openNovel(Novel novel){
    Get.toNamed(RouteName.novel, arguments: novel);
  }
}
