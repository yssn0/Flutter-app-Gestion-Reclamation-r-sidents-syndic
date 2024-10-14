class ResourcesReclamation {
  String name;
  String image;

  ResourcesReclamation(this.name, this.image);

  static List<ResourcesReclamation> list = [
    ResourcesReclamation("Piscine", "assets/piscine.png"),
    ResourcesReclamation("Ascenseur", "assets/elevator.png"),
    ResourcesReclamation("Gazon", "assets/gazon.png"),
    ResourcesReclamation("Plomberie", "assets/Plomeberie.png"),
  ];
}
