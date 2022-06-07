import '../../core/base/base_response.dart';
import 'models.dart';

class ProductModel extends BaseResponse {
  final String? id;
  final User? creator;
  final ProductTypeModel? productType;
  final List<String>? photoUrls;
  final String? videoUrl;
  final String? description;
  final double? price;
  final UnitModel? unit;
  final List<String>? saleLocations;
  ProductModel({
    this.id,
    this.creator,
    this.productType,
    this.photoUrls,
    this.videoUrl,
    this.description,
    this.price,
    this.unit,
    this.saleLocations,
  });

  ProductModel copyWith({
    String? id,
    User? creator,
    ProductTypeModel? productType,
    List<String>? photoUrls,
    String? videoUrl,
    String? description,
    double? price,
    UnitModel? unit,
    List<String>? saleLocations,
  }) {
    return ProductModel(
      id: id ?? this.id,
      creator: creator ?? this.creator,
      productType: productType ?? this.productType,
      photoUrls: photoUrls ?? this.photoUrls,
      videoUrl: videoUrl ?? this.videoUrl,
      description: description ?? this.description,
      price: price ?? this.price,
      unit: unit ?? this.unit,
      saleLocations: saleLocations ?? this.saleLocations,
    );
  }

  @override
  T fromJson<T extends BaseResponse>(Map<String, dynamic> json) {
    return ProductModel.fromJson(json) as T;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'creator': creator?.toJson(),
      'productType': productType?.toJson(),
      'photoUrls': photoUrls,
      'videoUrl': videoUrl,
      'description': description,
      'price': price,
      'unit': unit?.toJson(),
      'saleLocations': saleLocations,
    };
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      creator: json['creator'] != null ? User.fromJson(json['creator']) : null,
      productType: json['productType'] != null
          ? ProductTypeModel.fromJson(json['productType'])
          : null,
      photoUrls: List<String>.from(json['photoUrls']),
      videoUrl: json['videoUrl'],
      description: json['description'],
      price: json['price']?.toDouble(),
      unit: json['unit'] != null ? UnitModel.fromJson(json['unit']) : null,
      saleLocations: List<String>.from(json['saleLocations']),
    );
  }

  @override
  String toString() {
    return 'CommentModel(id: $id, creator: $creator, productType: $productType, photoUrls: $photoUrls, videoUrl: $videoUrl, description: $description, price: $price, unit: $unit, saleLocations: $saleLocations)';
  }

  @override
  List<Object?> get props => [
        id,
        creator,
        productType,
        photoUrls,
        videoUrl,
        description,
        price,
        unit,
        saleLocations,
      ];
}
