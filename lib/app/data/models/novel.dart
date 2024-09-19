class Novel {
  int? id;
  String judul;
  String? deskripsi;

  Novel({
    this.id,
    required this.judul,
    this.deskripsi,
  });

  // Mengubah Novel menjadi map untuk keperluan database (insert, update)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'judul': judul,
      'deskripsi': deskripsi,
    };
  }

  // Membuat instance Novel dari map (fetch dari database)
  factory Novel.fromMap(Map<String, dynamic> map) {
    return Novel(
      id: map['id'],
      judul: map['judul'],
      deskripsi: map['deskripsi'],
    );
  }
}
