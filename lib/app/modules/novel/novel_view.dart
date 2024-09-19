import 'package:novelku/app/data/models/chapter.dart';
import 'package:novelku/app/modules/novel/novel.dart';
import 'package:novelku/app/pakage.dart';

class NovelView extends GetView<NovelController> {
  const NovelView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.white,
        centerTitle: false,
        titleSpacing: 0,
        title: Text("${controller.sliceString(controller.novel.judul)}", style: TextStyle(
          fontWeight: FontWeight.bold
        ),),
      ),
      body: Obx(
        () => SafeArea(
          child: controller.chapterList.isEmpty
              ? const Center(child: Text('Tidak ada chapter.'))
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: ListView.builder(
                      itemCount: controller.chapterList.length,
                      itemBuilder: (context, index) {
                        Chapter chapter = controller.chapterList[index];
                        return GestureDetector(
                          onTap: () {
                            controller.editChapter(chapter);
                          },
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              height: 50,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Center(
                                      child: Text(
                                    "${chapter.judul}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  )),
                                  GestureDetector(
                                    onTap: () async {
                                      controller.deleteChapter(chapter.id!);
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.addChapter();
        },
        backgroundColor: Colors.deepOrange,
        child: const Icon(Icons.add, color: Colors.white),
        tooltip: 'Simpan Chapter',
      ),
    );
  }
}
