class Avatar {
  final String name;
  final String imageUrl;
  String? svgData; // Stores the binary data of the image

  Avatar({required this.name, required this.imageUrl, this.svgData});
}
