import 'package:equatable/equatable.dart';

import 'package:lovecook/data/data.dart';
import 'package:lovecook/utils/utils.dart';

class ProductState extends Equatable {
  final String? query;
  final ProductTypeModel? productType;
  final String? currencyUnit;
  final LookupModel? lookup;
  final User? user;
  ProductState({
    this.user,
    this.lookup,
    this.query,
    this.productType,
    this.currencyUnit,
  });

  ProductState copyWith({
    User? user,
    LookupModel? lookup,
    Nullable<ProductTypeModel?>? productType,
    Nullable<String?>? currencyUnit,
    Nullable<String?>? query,
  }) {
    return ProductState(
      user: user ?? this.user,
      lookup: lookup ?? this.lookup,
      productType: productType != null ? productType.value : this.productType,
      currencyUnit:
          currencyUnit != null ? currencyUnit.value : this.currencyUnit,
      query: query != null ? query.value : this.query,
    );
  }

  @override
  List<Object?> get props => [productType, currencyUnit, query, user];
}
