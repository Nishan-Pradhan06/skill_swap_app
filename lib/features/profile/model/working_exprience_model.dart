class WorkingExprienceModel {
  final String title;
  final String image;
  final String companyName;
  final String experience;
  final String location;

  WorkingExprienceModel({
    required this.title,
    required this.image,
    required this.companyName,
    required this.experience,
    required this.location,
  });

  factory WorkingExprienceModel.fromMap(Map<String, dynamic> map) {
    return WorkingExprienceModel(
      title: map['title']?.toString() ?? '',
      image: map['image']?.toString() ?? '',
      companyName: map['companyName']?.toString() ?? '',
      experience: map['exprience']?.toString() ?? '',
      location: map['location']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'image': image,
      'companyName': companyName,
      'exprience': experience,
      'location': location,
    };
  }
}
