class Chapter {
  int? id;
  String judul;
  String? content;
  int? novelId;

  Chapter({
    this.id,
    required this.judul,
    this.content,
    this.novelId,
  });

  // Mengubah Chapter menjadi map untuk keperluan database (insert, update)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'judul': judul,
      'content': content,
      'novel_id': novelId, // Sesuai nama kolom foreign key
    };
  }

  // Membuat instance Chapter dari map (fetch dari database)
  factory Chapter.fromMap(Map<String, dynamic> map) {
    return Chapter(
      id: map['id'],
      judul: map['judul'],
      content: map['content'],
      novelId: map['novel_id'],
    );
  }
}

