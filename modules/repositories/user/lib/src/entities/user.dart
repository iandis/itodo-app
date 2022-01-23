class User {
  const User({
    this.id,
    this.name,
    this.email,
    this.image,
    this.about,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      name: map['name'] as String?,
      email: map['email'] as String?,
      image: map['image'] as String?,
      about: map['about'] as String?,
    );
  }

  /// The id of the user
  ///
  /// `REQUIRED`
  final String? id;

  /// The name of the user
  ///
  /// Max length is `50` characters
  final String? name;

  /// The email of the user
  ///
  /// Max length is `100` characters
  final String? email;

  /// The url of the user's image
  ///
  /// Max length is `150` characters
  final String? image;

  /// The about text of the user
  ///
  /// Max length is `250` characters
  final String? about;

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? image,
    String? about,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      image: image ?? this.image,
      about: about ?? this.about,
    );
  }

  User copyFrom(covariant User other) {
    return copyWith(
      id: other.id,
      name: other.name,
      email: other.email,
      image: other.image,
      about: other.about,
    );
  }
}
