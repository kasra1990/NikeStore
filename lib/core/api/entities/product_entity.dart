class ProductEntity {
  final String? id;
  final String? name;
  final String? image1;
  final String? image2;
  final String? image3;
  final String? image4;
  final String? gender;
  final String? price;
  final String? description;
  final String? visited;
  final String? dateCreated;
  final int? favorite;

  ProductEntity(
      {this.id,
      this.name,
      this.image1,
      this.image2,
      this.image3,
      this.image4,
      this.gender,
      this.price,
      this.description,
      this.visited,
      this.dateCreated,
      this.favorite});
}
