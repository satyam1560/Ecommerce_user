part of 'display_products_bloc.dart';

enum ProductStatus { initial, loading, success, failure }

class DisplayProductState extends Equatable {
  final ProductStatus productStatus;
  final List<Product>? products;
  final Product? product;
  final String failure;
  const DisplayProductState({
    required this.productStatus,
    required this.products,
    this.product,
    required this.failure,
  });

  DisplayProductState copyWith({
    ProductStatus? productStatus,
    List<Product>? products,
    Product? product,
    String? failure,
  }) {
    return DisplayProductState(
      productStatus: productStatus ?? this.productStatus,
      products: products ?? this.products,
      product: product ?? this.product,
      failure: failure ?? this.failure,
    );
  }

  factory DisplayProductState.inital() => const DisplayProductState(
        productStatus: ProductStatus.initial,
        products: [],
        failure: '',
      );

  @override
  bool get stringify => true;
  @override
  List<Object?> get props => [productStatus, products, product, failure];
}
