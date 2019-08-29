/**
 * 分类模型
 */
class CategoryListModel {
  List<CategoryBigModel> data;
  CategoryListModel(this.data);
  factory CategoryListModel.formJson(List json) {
    return CategoryListModel(
        json.map((i) => CategoryBigModel.fromJson((i))).toList());
  }
}

/**
 * 分类的大分类
 */
class CategoryBigModel {
  String mallCategoryId;
  String mallCategoryName;
  String image;
  Null comments;
  List<CategorySmallModel> bxMallSubDto;

  CategoryBigModel(
      {this.mallCategoryId,
      this.mallCategoryName,
      this.image,
      this.comments,
      this.bxMallSubDto});

  //工厂模式-用这种模式可以省略New关键字
  factory CategoryBigModel.fromJson(dynamic json) {
    List<CategorySmallModel> smallCategoryInfo =
        (json['bxMallSubDto'] as List<dynamic>).map((smalInfo) {
      return CategorySmallModel.fromJson(smalInfo);
    }).toList();
    return CategoryBigModel(
        mallCategoryId: json["mallCategoryId"],
        mallCategoryName: json["mallCategoryName"],
        image: json["image"],
        comments: json["comments"],
        bxMallSubDto: smallCategoryInfo);
  }
}

/**
 * 分类中的子分类
 */
class CategorySmallModel {
  String mallSubId;
  String mallCategoryId;
  String mallSubName;
  String comments;

  CategorySmallModel(
      {this.mallSubId, this.mallCategoryId, this.mallSubName, this.comments});

  factory CategorySmallModel.fromJson(dynamic json) {
    return CategorySmallModel(
        mallCategoryId: json["mallCategoryId"],
        mallSubName: json["mallSubName"],
        comments: json["comments"],
        mallSubId: json["mallSubId"]);
  }
}
