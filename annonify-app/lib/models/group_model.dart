class Group {
  final String name;
  final String description;
  final image;
  final bool pinned;
  final DateTime dateTime;

  Group({
    required this.name,
    required this.description,
    required this.image,
    this.pinned = false,
    required this.dateTime,
  });
}
