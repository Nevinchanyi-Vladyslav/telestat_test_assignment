import 'package:easy_localization/easy_localization.dart';
import 'package:telestat_test_assignment/core/domain/failures/failures.dart';

mixin FailureToMessageMapper {
  final _cacheFailureMessage = 'cache_failure_message'.tr();
  final _generalFailureMessage = 'general_failure_message'.tr();

  String mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case CacheFailure:
        return _cacheFailureMessage;
      default:
        return _generalFailureMessage;
    }
  }
}
