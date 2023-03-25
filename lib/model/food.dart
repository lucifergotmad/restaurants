class Food {
  Food({
    required this.name,
  });

  final String name;

  factory Food.fromJson(Map<String, dynamic> json) => Food(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
