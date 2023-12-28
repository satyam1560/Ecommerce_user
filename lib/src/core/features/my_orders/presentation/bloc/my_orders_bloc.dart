import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/datasources/myorder_repo.dart';
import '../../data/models/myorder_model.dart';

part 'my_orders_event.dart';
part 'my_orders_state.dart';

class MyOrdersBloc extends Bloc<MyOrdersEvent, MyOrderState> {
  MyOrdersBloc() : super(MyOrderState.initial()) {
    on<PurchasedItems>((event, emit) async {
      emit(state.copyWith(myOrderStatus: MyOrderStatus.loading));
      MyOrderRepo myOrderRepo = MyOrderRepo();
      List<OrderModel> result =
          await myOrderRepo.getAllOrder(userID: event.userId);
      emit(state.copyWith(
          myOrderStatus: MyOrderStatus.success, myOrder: result));
    });
  }
}
