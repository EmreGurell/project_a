import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:project_a/core/network/api_endpoints.dart';
import 'package:project_a/core/network/dio_client.dart';
import 'package:project_a/core/di/service_locator.dart';

import '../../models/auth/signin_req_params.dart';
import '../../models/auth/signup_req_params.dart';


abstract class AuthApiService{
  Future<Either> signUp(SignUpReqParam signUpReq);
  Future<Either> signIn(SignInReqParam signInReq);

}

class AuthApiServiceImpl extends AuthApiService{

  @override
  Future<Either> signUp(SignUpReqParam signUpReq) async {
  try{
  
    var response = await sl<DioClient>().post(ApiEndpoints.register,
    data:signUpReq.toMap());

    return Left(response);
   
  }on DioException catch(e){
   
    return Right(e.response!.data['message']);
  }}

  @override
  Future<Either> signIn(SignInReqParam signInReq) async{
    try{
      var response = await sl<DioClient>().post(ApiEndpoints.login,data:signInReq.toMap());
      return Left(response);
    }on DioException catch(e){
      return Right(e.response!.data['message']);
    }
  }


}