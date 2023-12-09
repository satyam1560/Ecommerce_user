part of 'display_products_bloc.dart';

abstract class DisplayProductsEvent extends Equatable {
  const DisplayProductsEvent();

  @override
  List<Object> get props => [];
}

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class DisplayProductItems extends DisplayProductsEvent {}
