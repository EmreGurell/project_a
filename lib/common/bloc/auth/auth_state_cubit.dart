import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_a/common/bloc/auth/auth_state.dart';
import 'package:project_a/core/di/service_locator.dart';
import 'package:project_a/domain/usecases/is_authenticated.dart';

class AuthStateCubit extends Cubit<AuthState> {
  AuthStateCubit() : super(AppInitialState());

  void appStarted()async{
    var isAuthendticated = await sl<IsAuthenticatedUseCase>().call();

    if(isAuthendticated){
      emit(Authenticated());
    }else{
      emit(UnAuthenticated());
    }
  }
}
