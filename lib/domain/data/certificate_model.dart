class CertificateModel {
  final int id;
  final String title;
  final String? imageUrl;

  CertificateModel({required this.id, required this.title, this.imageUrl});

  factory CertificateModel.fromJson(Map<String, dynamic> json) {
    return CertificateModel(
      id: json['id'],
      title: json['title'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
    };
  }
}
