import 'package:novelku/app/data/models/chapter.dart';
import 'package:novelku/app/data/models/novel.dart';
import 'package:novelku/app/data/services/db_helper.dart';
import 'package:novelku/app/pakage.dart';
import 'package:novelku/app/routes/route_name.dart';

class NovelController extends GetxController {
  var chapterList = <Chapter>[].obs;
  final Novel novel = Get.arguments as Novel;

  @override
  void onInit() {
    fetchChapters();
    super.onInit();
  }

  void fetchChapters() async {
    chapterList.clear();

    var dataChapter = await DBHelper.getChaptersByNovelId(novel.id!);

    List<Chapter> novelList =
    dataChapter.map((novelMap) => Chapter.fromMap(novelMap)).toList();
    chapterList.addAll(novelList);
  }

  String sliceString(String input) {
    if (input.length > 20) {
      return input.substring(0, 20) + '...';
    }
    return input; // Kembali string asli jika tidak lebih dari 10 karakter
  }

  void addChapter(){
    var argumen = {
      "novel": novel,
      "chapter": null
    };

    Get.toNamed(RouteName.workspace, arguments: argumen);
  }

  void editChapter(Chapter chapter)async{
    var argumen = {
      "novel": novel,
      "chapter": chapter
    };

    Get.toNamed(RouteName.workspace, arguments: argumen);
  }

  void deleteChapter(int id)async{
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
      DBHelper.deleteChapter(id);
      fetchChapters();
    }
  }
}
