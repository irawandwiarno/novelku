import 'package:novelku/app/modules/workspace/workspace.dart';
import 'package:novelku/app/pakage.dart';
import 'package:flutter_quill/flutter_quill.dart';

class WSView extends StatelessWidget {
  WSView({super.key});

  final controller = Get.put(WSController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 3,
          backgroundColor: Colors.white,
          centerTitle: false,
          titleSpacing: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: Get.width / 2,
                child: TextField(
                  controller: controller.titleController,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    border: InputBorder.none, // Tanpa border
                    hintText: 'No Title', // Optional, jika ingin placeholder
                  ),
                ),
              ),
              TextButton(
                  onPressed: () {
                    controller.saveChapter();
                  },
                  child: Text(
                    "Simpan",
                    style: TextStyle(color: Colors.deepOrange, fontSize: 15),
                  ))
            ],
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: QuillEditor.basic(
                      configurations: QuillEditorConfigurations(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        controller: controller.quillController,
                        sharedConfigurations: const QuillSharedConfigurations(
                          locale: Locale('de'),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Positioned(
                  bottom: 0,
                  child: Container(
                    width: Get.width,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Obx(
                          () => Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            width: Get.width,
                            height: 50,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  controller.penyaranan.suggestions.length,
                              itemBuilder: (context, index) {
                                var kata =
                                    controller.penyaranan.suggestions[index];
                                return GestureDetector(
                                  onTap: (){
                                    controller.insertKata(kata);
                                  },
                                  child: Card(
                                    color: Colors.white,
                                    elevation: 2,
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      height: 40, // Atur tinggi sesuai kebutuhan
                                      child: Center(child: Text(kata)),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        QuillToolbar.simple(
                          configurations: QuillSimpleToolbarConfigurations(
                            showAlignmentButtons: false,
                            showBackgroundColorButton: false,
                            showCenterAlignment: false,
                            showClearFormat: false,
                            showCodeBlock: false,
                            showColorButton: false,
                            showDirection: false,
                            showFontFamily: false,
                            showDividers: false,
                            showFontSize: false,
                            showJustifyAlignment: false,
                            showHeaderStyle: false,
                            showIndent: false,
                            showInlineCode: false,
                            showLeftAlignment: false,
                            showLineHeightButton: false,
                            showLink: false,
                            showListCheck: false,
                            showListBullets: false,
                            showListNumbers: false,
                            showQuote: false,
                            showRightAlignment: false,
                            showSmallButton: false,
                            showStrikeThrough: false,
                            showSubscript: false,
                            showSuperscript: false,
                            showClipboardCut: false,
                            showUnderLineButton: false,
                            showClipboardCopy: false,
                            toolbarSectionSpacing: 1,
                            axis: Axis.horizontal,
                            controller: controller.quillController,
                            sharedConfigurations:
                                const QuillSharedConfigurations(
                              locale: Locale('in'),
                            ),
                          ),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ));
  }
}
