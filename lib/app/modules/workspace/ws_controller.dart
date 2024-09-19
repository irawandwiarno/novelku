import 'dart:convert';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:novelku/app/data/models/chapter.dart';
import 'package:novelku/app/data/models/novel.dart';
import 'package:novelku/app/data/services/autoComplete.dart';
import 'package:novelku/app/data/services/db_helper.dart';
import 'package:novelku/app/modules/novel/novel.dart';
import 'package:novelku/app/pakage.dart';

class WSController extends GetxController {
  QuillController quillController = QuillController.basic();
  TextEditingController titleController = TextEditingController();
  final argument = Get.arguments;
  late AutoCompleteController penyaranan;
  var wordList = ["Nara", "Gate", "Dungeon"];

  @override
  void onInit() {
    Chapter? chapter = argument["chapter"];

    if (chapter != null) {
      String jsonContent = chapter.content!;
      var jsonData = jsonDecode(jsonContent);
      final document = Document.fromJson(jsonData);
      quillController = QuillController(
          document: document, selection: TextSelection.collapsed(offset: 0));
      titleController.text = chapter.judul;
    }

    penyaranan = Get.put(AutoCompleteController(quillController: quillController, wordList: wordList));

    super.onInit();
  }

  @override
  void onClose() {
    penyaranan.dispose();
    super.onClose();
  }

  void saveChapter() async {
    NovelController novelController = Get.find<NovelController>();
    var novel = argument["novel"];
    var chapter = argument["chapter"];
    String content = jsonEncode(
        quillController.document.toDelta().toJson()); // Menggunakan jsonEncode

    Chapter newChapter = Chapter(
      id: chapter?.id,
      judul: titleController.text,
      content: content,
      novelId: novel.id,
    );

    if (chapter != null) {
      var res = await DBHelper.updateChapter(chapter.id, newChapter.toMap());
    } else {
      var res = await DBHelper.insertChapter(newChapter.toMap());
    }

    Fluttertoast.showToast(
      msg: "Berhasil menyimpan",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 16.0,
    );

    novelController.fetchChapters();
  }

  void insertKata(String kata){
    penyaranan.insertSuggestion(kata + " ");
  }
}
