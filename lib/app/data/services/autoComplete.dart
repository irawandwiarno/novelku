import 'package:flutter_quill/flutter_quill.dart';
import 'package:novelku/app/pakage.dart';

class AutoCompleteController extends GetxController {
  AutoCompleteController(
      {required this.quillController, required this.wordList});
  QuillController quillController;
  List<String> wordList;

  // Daftar saran yang akan muncul
  RxList<String> suggestions = <String>[].obs;

  @override
  void onInit() {
    super.onInit();

    quillController.addListener(() {
      String currentWord = getWordNearCursor();
      updateSuggestions(currentWord);
    });
  }

  void updateSuggestions(String word) {
    word = word.trim();
    if (word.isEmpty) {
      suggestions.clear();
    } else {
      suggestions.value = wordList
          .where((w) => w.toLowerCase().startsWith(word.toLowerCase()))
          .toList();
    }
  }

  String getWordNearCursor() {
    String text = quillController.document.toPlainText();
    int cursorPos = quillController.selection.baseOffset;

    if (cursorPos == -1 || text.isEmpty) {
      print('not valid');
      return ""; // Jika tidak ada teks atau kursor tidak valid
    }

    int start = cursorPos;
    while (start > 0 && text[start - 1] != ' ') {
      start--;
    }

    int end = cursorPos;
    while (end < text.length && text[end] != ' ') {
      end++;
    }

    print('text: ${text.substring(start, end)}');
    return text.substring(start, end);
  }

  void insertSuggestion(String suggestion) {
    print('call');
    var currentSelection = quillController.selection;
    var text = quillController.document.toPlainText();
    int start = currentSelection.baseOffset;

    // Cari awal kata yang ingin diganti
    int wordStart = start;
    while (wordStart > 0 && text[wordStart - 1] != ' ') {
      wordStart--;
    }

    // Ganti teks
    quillController.replaceText(
      wordStart,
      currentSelection.baseOffset - wordStart,
      suggestion,
      TextSelection.collapsed(offset: wordStart + suggestion.length),
    );

    print('success');
  }

  bool isCursorAtEndOfText() {
    var currentSelection = quillController.selection;
    return currentSelection.isCollapsed &&
        currentSelection.baseOffset == quillController.document.length;
  }


  Widget buildSuggestionList(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Obx(() => ListView.builder(
        shrinkWrap: true,
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(suggestions[index]),
            onTap: () {
              insertSuggestion(suggestions[index]);
            },
          );
        },
      )),
    );
  }

  void showSuggestions(BuildContext context, double cursorOffset) {
    final overlay = Overlay.of(context);

    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: cursorOffset,
        left: 20,
        child: buildSuggestionList(context),
      ),
    );

    overlay.insert(overlayEntry);

    // Hapus overlay setelah beberapa waktu (atau setelah aksi tertentu)
    Future.delayed(Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }




}
