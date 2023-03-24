import 'package:actual/product/model/product_model.dart';
import 'package:actual/user/model/basket_item_model.dart';
import 'package:actual/user/model/patch_basket_body.dart';
import 'package:actual/user/repository/user_me_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';

final basketProvider =
    StateNotifierProvider<BasketProvider, List<BasketItemModel>>(
  (ref) {
    final repository = ref.watch(userMeRepositoryProvider);

    return BasketProvider(
      repository: repository,
    );
  },
);

class BasketProvider extends StateNotifier<List<BasketItemModel>> {
  final UserMeRepository repository;

  BasketProvider({
    required this.repository,
  }) : super([]);

  Future<void> patchBasket() async {
    await repository.patchBasket(
      body: PatchBasketBody(
        basket: state
            .map(
              (e) => PatchBasketBodyBasket(
                productId: e.product.id,
                count: e.count,
              ),
            )
            .toList(),
      ),
    );
  }

  Future<void> addToBasket({
    required ProductModel product,
  }) async {
// 1) 장바구니에 해당 상품이 없다면, 장바구니에 상품을 추가한다.
// 2) 장바구니에 해당 상품이 이미 들어있다면, 장바구니에 있는 값에 +1을 한다.

    final exist =
        state.firstWhereOrNull((e) => e.product.id == product.id) != null;

    if (exist) {
      state = state
          .map(
            (e) => e.product.id == product.id
                ? e.copyWith(
                    count: e.count + 1,
                  )
                : e,
          )
          .toList();
    } else {
      state = [
        ...state,
        BasketItemModel(
          product: product,
          count: 1,
        ),
      ];
    }

    // Optimistic Response (긍정적 응답)
    // 응답이 성공할거라고 가정하고 상태를 먼저 업데이트 함
    await patchBasket();
  }

  Future<void> removeFromBasket({
    required ProductModel product,
    bool isDelete = false, // true라면 카운트와 관계없이 아예 삭제
  }) async {
// 1) 장바구니에 해당 상품이 존재할 때,
//    (1) 상품의 카운트가 1보다 크면 -1 한다.
//    (2) 상품의 카운트가 1이면 삭제한다.
// 2) 장바구니에 해당 상품이 존재하지 않을 때, 즉시 함수를 반환하고 아무것도 하지 않는다.

    final exist =
        state.firstWhereOrNull((e) => e.product.id == product.id) != null;

    if (exist) {
      final existingProduct =
          state.firstWhere((e) => e.product.id == product.id);

      if (existingProduct.count == 1 || isDelete) {
        state = state
            .where(
              (e) => e.product.id != product.id,
            )
            .toList();
      } else {
        state = state
            .map(
              (e) => e.product.id == product.id
                  ? e.copyWith(
                      count: e.count - 1,
                    )
                  : e,
            )
            .toList();
      }
    } else {
      return;
    }

    await patchBasket();
  }
}
