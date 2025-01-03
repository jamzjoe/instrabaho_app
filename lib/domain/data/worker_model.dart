class WorkerModel {
  final String name;
  final String position;
  final double rating;
  final String? image;
  final String? bio;
  final String? location;
  final bool? isHired;

  WorkerModel({
    required this.name,
    required this.position,
    required this.rating,
    this.image,
    this.bio,
    this.location,
    this.isHired,
  });

  WorkerModel copyWith({
    String? name,
    String? position,
    double? rating,
    String? image,
    String? bio,
    String? location,
    bool? isHired,
  }) {
    return WorkerModel(
      name: name ?? this.name,
      position: position ?? this.position,
      rating: rating ?? this.rating,
      image: image ?? this.image,
      bio: bio ?? this.bio,
      location: location ?? this.location,
      isHired: isHired ?? this.isHired,
    );
  }

  factory WorkerModel.fromJson(Map<String, dynamic> json) {
    return WorkerModel(
      name: json['name'],
      position: json['position'],
      rating: json['rating'],
      image: json['image'],
      bio: json['bio'],
      location: json['location'],
      isHired: json['isHired'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'position': position,
      'rating': rating,
      'image': image,
      'bio': bio,
      'location': location,
      'isHired': isHired,
    };
  }
}
