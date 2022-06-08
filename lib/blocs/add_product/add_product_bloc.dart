import 'package:dartz/dartz.dart';
import '../../core/base/base.dart';
import '../../data/data.dart';

import 'add_product_state.dart';

class AddProductBloc extends BaseBloc<AddProductState> {
  final IProductRepository _productRepository;
  final ILookupRepository _lookupRepository;
  AddProductBloc(this._productRepository, this._lookupRepository);

  Stream<LookupModel?> get lookupStream =>
      stateStream.map((event) => event.lookup);

  init() async {
    final responseEither = await _lookupRepository.getLookup();
    responseEither.fold((failure) {}, (data) {
      emit((state ?? AddProductState()).copyWith(lookup: data.item));
    });
  }

  loadProduct(ProductModel product) async {
    emit((state ?? AddProductState()).copyWith(
      productType: product.productType,
      photoUrls: product.photoUrls,
      videoUrl: product.videoUrl,
      videoThumbnail: product.videoThumbnail,
      description: product.description,
      name: product.name,
      price: product.price,
      unit: product.unit,
      saleLocations: product.saleLocations,
      id: product.id,
    ));
    init();
  }

  updateField({
    ProductTypeModel? productType,
    List<String>? photoUrls,
    String? videoUrl,
    String? videoThumbnail,
    String? description,
    String? name,
    double? price,
    UnitModel? unit,
    List<String>? saleLocations,
  }) {
    emit((state ?? AddProductState()).copyWith(
      productType: productType,
      photoUrls: photoUrls,
      videoUrl: videoUrl,
      videoThumbnail: videoThumbnail,
      description: description,
      name: name,
      price: price,
      unit: unit,
      saleLocations: saleLocations,
    ));
  }

  Future<ProductModel> saveProduct() async {
    emitWaiting(true);
    final map = {
      'description': state?.description,
      'name': state?.name,
      'photoUrls': state?.photoUrls,
      'videoUrl': state?.videoUrl,
      'videoThumbnail': state?.videoThumbnail,
      'productTypeId': state?.productType?.id,
      'price': state?.price,
      'unitId': state?.unit?.id,
      'saleLocations': state?.saleLocations,
    };

    map.removeWhere((key, value) => value == null);
    Either response;
    if (state?.id != null) {
      response =
          await _productRepository.update(productId: state!.id!, data: map);
    } else {
      response = await _productRepository.createProduct(data: map);
    }

    return response.fold((failure) {
      emitWaiting(false);
      return Future.error(failure);
    }, (data) {
      emitWaiting(false);
      return data.item;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
