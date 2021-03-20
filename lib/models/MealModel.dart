class MealModel {
  String imageURL;
  String name;
  String type;

  MealModel(this.name, this.type, this.imageURL);

  MealModel.fromJson(Map<String, dynamic> json):
    imageURL = json['image_url'],
    name = json['name'],
    type = json['type'];


}