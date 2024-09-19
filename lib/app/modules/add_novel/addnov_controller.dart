import 'package:novelku/app/data/models/novel.dart';
import 'package:novelku/app/data/services/db_helper.dart';
import 'package:novelku/app/pakage.dart';
import 'package:novelku/app/routes/route_name.dart';

class AddNovelController extends GetxController {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final Novel? novel = Get.arguments as Novel?;

  @override
  void onInit() {
    if (novel != null) {
      titleController.text = novel!.judul;
      descriptionController.text = novel!.deskripsi!;
      print('id: ${novel!.id}, judul: ${novel!.judul}');
    }
    super.onInit();
  }

  // Fungsi untuk menambahkan novel baru ke database
  void addNovel() async {
    final String title = titleController.text;
    final String description = descriptionController.text;

    if (title.isNotEmpty && description.isNotEmpty) {
      Novel newNovel = Novel(
        id: novel?.id, // Menggunakan id jika novel tidak null
        judul: title,
        deskripsi: description,
      );

      if (novel != null && novel!.id != null) {
        await DBHelper.updateNovel(novel!.id!, newNovel.toMap());
      } else {
        // Menyimpan novel baru
        await DBHelper.insertNovel(newNovel.toMap());
      }

      Get.back(result: true); // Kembali ke halaman sebelumnya
      Get.snackbar('Sukses', 'Novel berhasil ditambahkan',
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar('Error', 'Judul dan deskripsi harus diisi',
          snackPosition: SnackPosition.BOTTOM);
    }
  }


  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
