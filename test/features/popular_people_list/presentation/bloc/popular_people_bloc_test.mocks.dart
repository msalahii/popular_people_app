// Mocks generated by Mockito 5.1.0 from annotations
// in popular_people_app/test/features/popular_people_list/presentation/bloc/popular_people_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:popular_people_app/core/errors/failure.dart' as _i6;
import 'package:popular_people_app/features/popular_people_list/data/models/popular_people_search_result_model.dart'
    as _i7;
import 'package:popular_people_app/features/popular_people_list/domain/repositories/popular_people_repo.dart'
    as _i2;
import 'package:popular_people_app/features/popular_people_list/domain/usecases/fetch_popular_people_usecase.dart'
    as _i4;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakePopularPeopleRepository_0 extends _i1.Fake
    implements _i2.PopularPeopleRepository {}

class _FakeEither_1<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

/// A class which mocks [FetchPopularPeopleUsecase].
///
/// See the documentation for Mockito's code generation for more information.
class MockFetchPopularPeopleUsecase extends _i1.Mock
    implements _i4.FetchPopularPeopleUsecase {
  MockFetchPopularPeopleUsecase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.PopularPeopleRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
              returnValue: _FakePopularPeopleRepository_0())
          as _i2.PopularPeopleRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.PopularPeopleSearchResultModel>> call(
          _i4.FetchPopularPeopleParams? params) =>
      (super.noSuchMethod(Invocation.method(#call, [params]),
          returnValue:
              Future<_i3.Either<_i6.Failure, _i7.PopularPeopleSearchResultModel>>.value(
                  _FakeEither_1<_i6.Failure,
                      _i7.PopularPeopleSearchResultModel>())) as _i5
          .Future<_i3.Either<_i6.Failure, _i7.PopularPeopleSearchResultModel>>);
}
