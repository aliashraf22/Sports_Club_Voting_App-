import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn/services/security_monitoring_service.dart';

part 'security_check_state.dart';

class SecurityCheckCubit extends Cubit<SecurityCheckState> {
  SecurityCheckCubit() : super(SecurityCheckInitial());

  void checkIfSecure() async {
    emit(SecurityCheckLoading());
    bool isSecure = false;

    if (kReleaseMode) {
      try {
        isSecure = await SecurityMonitoringService.initSecurityCheck();
      } on PlatformException catch (e) {
        emit(SecurityCheckError(errorMessage: "${e.message}"));
      }
    } else {
      isSecure = true;
      await Future.delayed(const Duration(seconds: 1));
    }

    emit(SecurityCheckLoaded(isSecure));
  }
}
