import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurants/data/api/api_services.dart';
import 'package:restaurants/data/api/response/restaurant_response.dart';
import 'package:restaurants/provider/restaurant_provider.dart';

import '../json_reader.dart';
import 'restaurant_provider_test.mocks.dart';

@GenerateMocks([ApiService])
void main() {
  MockApiService mockApiService = MockApiService();
  late RestaurantProvider provider;

  setUp(() {
    provider = RestaurantProvider(apiService: mockApiService);
  });

  group("Api Service", () {
    final tRestaurantResponse = RestaurantResponse.fromJson(
        json.decode(readJson("mock/restaurant_response_dummy.json")));

    test("should return the right response", () async {
      when(await mockApiService.getListRestaurant())
          .thenReturn(tRestaurantResponse);

      final result = await provider.fetchAllRestaurant();

      expect(result, tRestaurantResponse);
    });
  });
}
