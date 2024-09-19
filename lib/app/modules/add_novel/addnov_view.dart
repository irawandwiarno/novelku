import 'package:novelku/app/modules/add_novel/add_novel.dart';
import 'package:novelku/app/pakage.dart';

class AddNovelPage extends GetView<AddNovelController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Novel'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // TextField untuk Judul
            TextField(
              controller: controller.titleController,
              decoration: InputDecoration(
                labelText: 'Judul Novel',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),

            // TextField untuk Deskripsi
            TextField(
              controller: controller.descriptionController,
              decoration: InputDecoration(
                labelText: 'Deskripsi Novel',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            SizedBox(height: 16),

            // Tombol Simpan
            ElevatedButton(
              onPressed: controller.addNovel,
              child: Text('Simpan Novel', style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
