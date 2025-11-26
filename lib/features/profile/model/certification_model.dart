/// Certification model
class CertificationModel {
  final String title;
  final String image;

  CertificationModel({required this.title, required this.image});

  factory CertificationModel.fromMap(Map<String, dynamic> map) {
    return CertificationModel(
      title: map['title']?.toString() ?? '',
      image: map['image']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'title': title, 'image': image};
  }

  @override
  String toString() => 'Certification(title: $title, image: $image)';
}
