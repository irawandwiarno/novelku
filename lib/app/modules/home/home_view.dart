import 'package:novelku/app/data/services/db_helper.dart';
import 'package:novelku/app/modules/home/home_controller.dart';
import 'package:novelku/app/pakage.dart';
import 'package:novelku/app/routes/route_name.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 3,
        title: const Text(
          "NovelKu",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Obx(() {
            // Menggunakan Obx dari GetX untuk memantau perubahan listNovel
            if (controller.listNovel.isEmpty) {
              return const Center(child: Text('Tidak ada novel.'));
            } else {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Jumlah kolom dalam grid
                  crossAxisSpacing: 10, // Spasi antar kolom
                  mainAxisSpacing: 10, // Spasi antar baris
                  childAspectRatio: 0.8, // Mengatur rasio item (lebar/tinggi)
                ),
                itemCount:
                    controller.listNovel.length, // Jumlah item dalam list
                itemBuilder: (context, index) {
                  // Mengambil novel dari list
                  final novel = controller.listNovel[index];

                  return GestureDetector(
                    onTap: () {
                      controller.openNovel(novel);
                    },
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, top: 20, bottom: 10, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              novel.judul,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              novel.deskripsi ?? "Kosong",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            Expanded(child: Container()),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    controller.deleteNovel(novel.id!);
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                                SizedBox(width: 10), // Spasi antara ikon
                                GestureDetector(
                                  onTap: () {
                                    controller.editNovel(novel);
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.addNovel();
        },
        backgroundColor: Colors.deepOrange,
        child: const Icon(Icons.add, color: Colors.white),
        tooltip: 'Simpan Chapter',
      ),
    );
  }
}
