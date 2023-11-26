import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/datasources/product_repo.dart';
import '../../data/models/product_model.dart';

part 'display_products_event.dart';
part 'display_products_state.dart';

class DisplayProductsBloc
    extends Bloc<DisplayProductsEvent, DisplayProductState> {
  final ProductRepository _productRepository = ProductRepository();

  DisplayProductsBloc() : super(DisplayProductState.inital()) {
    on<DisplayProductItems>((event, emit) async {
      try {
        emit(state.copyWith(productStatus: ProductStatus.loading));

        final products = await _productRepository.getProducts();

        emit(state.copyWith(
          products: products,
          productStatus: ProductStatus.success,
        ));
      } catch (e) {
        emit(state.copyWith(
          productStatus: ProductStatus.failure,
          failure: e.toString(),
        ));
      }
    });
  }
}
