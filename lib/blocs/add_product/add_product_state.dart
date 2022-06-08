import 'package:equatable/equatable.dart';

import '../../data/data.dart';

class AddProductState extends Equatable {
  final LookupModel? lookup;
  final ProductTypeModel? productType;
  final List<String>? photoUrls;
  final String? videoUrl;
  final String? videoThumbnail;
  final String? description;
  final String? name;
  final double? price;
  final UnitModel? unit;
  final List<String>? saleLocations;
  final String? id;
  AddProductState({
    this.lookup,
    this.productType,
    this.photoUrls,
    this.videoUrl,
    this.videoThumbnail,
    this.description,
    this.name,
    this.price,
    this.unit,
    this.saleLocations,
    this.id,
  });

  @override
  List<Object?> get props {
    return [
      id,
      lookup,
      productType,
      photoUrls,
      videoUrl,
      videoThumbnail,
      description,
      name,
      price,
      unit,
      saleLocations,
    ];
  }

  AddProductState copyWith({
    LookupModel? lookup,
    ProductTypeModel? productType,
    List<String>? photoUrls,
    String? videoUrl,
    String? videoThumbnail,
    String? description,
    String? name,
    double? price,
    UnitModel? unit,
    List<String>? saleLocations,
    String? id,
  }) {
    return AddProductState(
      lookup: lookup ?? this.lookup,
      productType: productType ?? this.productType,
      photoUrls: photoUrls ?? this.photoUrls,
      videoUrl: videoUrl ?? this.videoUrl,
      videoThumbnail: videoThumbnail ?? this.videoThumbnail,
      description: description ?? this.description,
      name: name ?? this.name,
      price: price ?? this.price,
      unit: unit ?? this.unit,
      saleLocations: saleLocations ?? this.saleLocations,
      id: id ?? this.id,
    );
  }
}
