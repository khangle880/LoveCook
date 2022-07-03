import 'package:dartz/dartz.dart';
import '../../core/base/base.dart';
import '../../data/data.dart';

import 'add_product_state.dart';

class AddProductBloc extends BaseBloc<AddProductState> {
  final IProductRepository _productRepository;
  final ILookupRepository _lookupRepository;
  final IUploadRepository _uploadRepository;
  AddProductBloc(
      this._productRepository, this._lookupRepository, this._uploadRepository);

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
      currencyUnit: product.currencyUnit,
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
    String? currencyUnit,
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
      currencyUnit: currencyUnit,
      saleLocations: saleLocations,
    ));
  }

  Future<String> uploadVideo(String filePath) async {
    final imageResponseEither =
        await _uploadRepository.uploadVideoData(filePath: filePath);
    return imageResponseEither.fold((failure) {
      return Future.error(failure);
    }, (data) {
      return data.item?.urls?[0] ?? '';
    });
  }

  Future<String> uploadImage(String filePath) async {
    final imageResponseEither =
        await _uploadRepository.uploadFileData(filePath: filePath);
    return imageResponseEither.fold((failure) {
      return Future.error(failure);
    }, (data) {
      return data.item?.urls?[0] ?? '';
    });
  }

  Future saveProduct() async {
    emitWaiting(true);
    final map = {
      'description': state?.description,
      'name': state?.name,
      'productTypeId': state?.productType?.id,
      'price': state?.price,
      'currencyUnit': state?.currencyUnit,
      'saleLocations': state?.saleLocations,
    };
    if (state?.photoUrls != null) {
      map['photoUrls'] = await Future.wait(state!.photoUrls!.map((e) async {
        if (!e.contains('/v1/')) {
          return await uploadImage(e);
        }
        return e;
      }));
    }
    if (state?.videoUrl != null) {
      map['videoUrl'] = !state!.videoUrl!.contains('/v1/')
          ? await uploadVideo(state!.videoUrl!)
          : state!.videoUrl;
      map['videoThumbnail'] = !state!.videoThumbnail!.contains('/v1/')
          ? await uploadImage(state!.videoThumbnail!)
          : state!.videoThumbnail;
    }

    map.removeWhere((key, value) => value == null);
    Either response;
    if (state?.id != null) {
      response =
          await _productRepository.update(productId: state!.id!, data: map);
    } else {
      response = await _productRepository.createProduct(data: map);
    }

    emitWaiting(false);
    return response.fold((failure) {
      return Future.error(failure);
    }, (data) {
      if (!data.success) {
        return Future.error(data.error?.errorMessage ?? '');
      }
      return data.item;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
