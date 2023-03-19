import 'package:actual/common/const/data.dart';
import 'package:actual/common/dio/dio.dart';
import 'package:actual/common/model/cursor_pagination_model.dart';
import 'package:actual/restaurant/model/restaurant_detail_model.dart';
import 'package:actual/restaurant/model/restaurant_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'restaurant_repository.g.dart';

final restaurantRepositoryProvider = Provider<RestaurantRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);
    final repository = RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant');

    return repository;
  },
);

@RestApi()
abstract class RestaurantRepository {
  factory RestaurantRepository(Dio dio, {String baseUrl}) 
  = _RestaurantRepository;

  // http://$ip/resautrant/
  @GET('/')
  @Headers({'accessToken' : 'true'})
  Future<CursorPagination<RestaurantModel>> paginate();

  // http://$ip/restaurant/:id/
  @GET('/{id}')
  @Headers({'accessToken' : 'true'})
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path() required String id,
  });
}