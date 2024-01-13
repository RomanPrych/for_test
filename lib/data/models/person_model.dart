import 'dart:convert';

PersonModel personModelFromJson(String str) => PersonModel.fromJson(json.decode(str));

String personModelToJson(PersonModel data) => json.encode(data.toJson());

class PersonModel {


  PersonModel({
    this.id,
    this.name,
    this.status,
    this.species,
    this.type,
    this.gender,
    this.origin,
    this.location,
    this.image,
    this.episode,
    this.url,
    this.created,
  });
  int? id;
  String? name;
  String? status;
  String? species;
  String? type;
  String? gender;
  Location? origin;
  Location? location;
  String? image;
  List<String>? episode;
  String? url;
  DateTime? created;

  PersonModel copyWith({
    int? id,
    String? name,
    String? status,
    String? species,
    String? type,
    String? gender,
    Location? origin,
    Location? location,
    String? image,
    List<String>? episode,
    String? url,
    DateTime? created,
  }) =>
      PersonModel(
        id: id ?? this.id,
        name: name ?? this.name,
        status: status ?? this.status,
        species: species ?? this.species,
        type: type ?? this.type,
        gender: gender ?? this.gender,
        origin: origin ?? this.origin,
        location: location ?? this.location,
        image: image ?? this.image,
        episode: episode ?? this.episode,
        url: url ?? this.url,
        created: created ?? this.created,
      );

  factory PersonModel.fromJson(Map<String, dynamic> json) => PersonModel(
    id: json["id"],
    name: json["name"],
    status: json["status"],
    species: json["species"],
    type: json["type"],
    gender: json["gender"],
    origin: Location.fromJson(json["origin"]),
    location: Location.fromJson(json["location"]),
    image: json["image"],
    episode: List<String>.from(json["episode"].map((x) => x)),
    url: json["url"],
    created: DateTime.parse(json["created"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "status": status,
    "species": species,
    "type": type,
    "gender": gender,
    "origin": origin?.toJson(),
    "location": location?.toJson(),
    "image": image,
    "episode": episode == null ? []:List<dynamic>.from(episode!.map((x) => x)),
    "url": url,
    "created": created?.toIso8601String(),
  };
}

class Location {
  String name;
  String url;

  Location({
    required this.name,
    required this.url,
  });

  Location copyWith({
    String? name,
    String? url,
  }) =>
      Location(
        name: name ?? this.name,
        url: url ?? this.url,
      );

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    name: json["name"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "url": url,
  };
}