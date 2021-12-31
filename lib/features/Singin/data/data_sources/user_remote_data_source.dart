import 'package:google_sign_in/google_sign_in.dart';
import 'package:oikosmobile/core/Usecases/usecases.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/features/Singin/data/models/profile_model.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';

abstract class UserRemoteDataSource {
  Future<String> login(LoginParams loginParams);
  Future<String> register(RegisterParams registerParams);
  Future<User> getProfile(String token);
  Future<List<String>> getDepartments();
  Future<String> getUserPicture(String token);
  Future<String> smsConfirm(String code);
  Future<GoogleSignInAccount> loginGoogle();
  Future<String> loginFacebook();
  Future<User> getUserById(GetUserByIdParams getUserByIdParams);
}