part of 'my_orders_bloc.dart';

abstract class MyOrdersEvent extends Equatable {
  const MyOrdersEvent();

  @override
  List<Object?> get props => [];
}

class PurchasedItems extends MyOrdersEvent {
  final String userId;
  const PurchasedItems({required this.userId});
}
