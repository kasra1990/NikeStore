import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_flutter/core/api/models/product_model.dart';
import 'package:nike_flutter/core/resources/data_state.dart';
import 'package:nike_flutter/core/utils/strings.dart';
import 'package:nike_flutter/features/root/category/domain/entities/category_entity.dart';
import 'package:nike_flutter/features/root/category/domain/useCases/get_category_data_usecase.dart';
import 'package:nike_flutter/features/root/category/domain/useCases/searh_in_category_usecese.dart';
import '../../../../../core/network/network_info.dart';
part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetCategoryDataUseCase _useCase;
  final SearchInCategoryUseCase _searchUseCase;
  final NetworkInfo _networkInfo;
  CategoryBloc(this._useCase, this._networkInfo, this._searchUseCase)
      : super(CategoryLoading()) {
    on<CategoryStarted>(_started);
    on<CategorySearchQuery>(_searchQuery);
    // on<CategoryCahgneCategory>(_changeCategory);
  }

  /// get list of product
  void _started(CategoryStarted event, Emitter<CategoryState> emit) async {
    emit(CategoryLoading());
    var netState = await _networkInfo.isConnected;
    if (netState) {
      DataState dataState = await _useCase.call(event.category);
      if (dataState is DataSuccess) {
        emit(CategorySuccess(dataState.data));
      }
      if (dataState is DataFaild) {
        emit(const CategoryError(error: netError));
      }
    } else {
      emit(const CategoryError(error: noConnection));
    }
  }

  /// serach in list
  void _searchQuery(CategorySearchQuery event, Emitter<CategoryState> emit) {
    if (state is CategorySuccess) {
      final String query = event.searchQuery.toLowerCase();
      final dataState = _searchUseCase.call(query: query);
      emit(CategorySuccess(
          CategoryEntity(categories: dataState.data!.categories)));
    }
  }
}
