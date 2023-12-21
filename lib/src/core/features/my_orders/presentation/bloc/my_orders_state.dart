// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'my_orders_bloc.dart';

enum MyOrderStatus { initial, loading, success }

class MyOrderState extends Equatable {
  final MyOrderStatus? myOrderStatus;
  final List<OrderModel>? myOrder;
  const MyOrderState({
    required this.myOrderStatus,
    this.myOrder,
  });

  MyOrderState copyWith({
    MyOrderStatus? myOrderStatus,
    List<OrderModel>? myOrder,
  }) {
    return MyOrderState(
      myOrderStatus: myOrderStatus ?? this.myOrderStatus,
      myOrder: myOrder ?? this.myOrder,
    );
  }

  factory MyOrderState.initial() =>
      const MyOrderState(myOrderStatus: MyOrderStatus.initial, myOrder: []);

  @override
  List<Object?> get props => [myOrderStatus, myOrder];
}
