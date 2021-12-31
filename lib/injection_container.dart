import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/features/Calendar/data/data_sources/diponibility_remote_data_source_imp.dart';
import 'package:oikosmobile/features/Calendar/data/data_sources/implementation/disponibility_remote_data_source_imp.dart';
import 'package:oikosmobile/features/Calendar/data/repositories/disponibility_repository_imp.dart';
import 'package:oikosmobile/features/Calendar/domain/repositories/disponibility_repository.dart';
import 'package:oikosmobile/features/Calendar/domain/use_cases/addMany.dart';
import 'package:oikosmobile/features/Calendar/presentation/bloc/bloc.dart';
import 'package:oikosmobile/features/Home/presentation/bloc/bloc.dart';
import 'package:oikosmobile/features/Message/data/datasources/implementation/message_remote_data_source_imp.dart';
import 'package:oikosmobile/features/Message/data/datasources/message_remote_data_source.dart';
import 'package:oikosmobile/features/Message/data/repositories/message_repository_imp.dart';
import 'package:oikosmobile/features/Message/domain/repositories/message-repository.dart';
import 'package:oikosmobile/features/Message/domain/usecases/getMessageThread.dart';
import 'package:oikosmobile/features/Message/domain/usecases/getMessageThreads.dart';
import 'package:oikosmobile/features/Message/domain/usecases/sendMessage.dart';
import 'package:oikosmobile/features/Message/presentation/bloc/bloc.dart';
import 'package:oikosmobile/features/Notification/data/data_sources/implementation/notification_remote_data_source_imp.dart';
import 'package:oikosmobile/features/Notification/data/repositories/notifications_repository_imp.dart';
import 'package:oikosmobile/features/Notification/domain/repositories/notifications_repository.dart';
import 'package:oikosmobile/features/Notification/domain/use_cases/getUnRead.dart';
import 'package:oikosmobile/features/Notification/presentation/bloc/notification_bloc.dart';
import 'package:oikosmobile/features/Offer/data/datasources/implementation/offer_remote_data_source_imp.dart';
import 'package:oikosmobile/features/Offer/data/datasources/offer_remote_data_source.dart';
import 'package:oikosmobile/features/Offer/data/repositories/offer_repository_imp.dart';
import 'package:oikosmobile/features/Offer/domain/repositories/offer_repository.dart';
import 'package:oikosmobile/features/Offer/domain/usecases/acceptOffer.dart';
import 'package:oikosmobile/features/Offer/domain/usecases/counterOffer.dart';
import 'package:oikosmobile/features/Offer/domain/usecases/getOffersByProperties.dart';
import 'package:oikosmobile/features/Offer/domain/usecases/rejectOffer.dart';
import 'package:oikosmobile/features/Offer/presentation/bloc/bloc.dart';
import 'package:oikosmobile/features/Profile/data/data_sources/implementation/profile_remote_data_source_imp.dart';
import 'package:oikosmobile/features/Profile/data/data_sources/profile_remote_data_source.dart';
import 'package:oikosmobile/features/Profile/data/repositories/profile_repository_imp.dart';
import 'package:oikosmobile/features/Profile/domain/repositories/profile_repository.dart';
import 'package:oikosmobile/features/Profile/domain/use_cases/updateGeneralInformation.dart';
import 'package:oikosmobile/features/Profile/domain/use_cases/updatePassword.dart';
import 'package:oikosmobile/features/Profile/domain/use_cases/updatePicture.dart';
import 'package:oikosmobile/features/Profile/domain/use_cases/updateProfile.dart';
import 'package:oikosmobile/features/Properties/data/repositories/properties_repository_imp.dart';
import 'package:oikosmobile/features/Properties/domain/repositories/properties_repository.dart';
import 'package:oikosmobile/features/Properties/domain/use_cases/creat.dart';
import 'package:oikosmobile/features/Properties/domain/use_cases/deleteImages.dart';
import 'package:oikosmobile/features/Properties/domain/use_cases/deleteProperties.dart';
import 'package:oikosmobile/features/Properties/domain/use_cases/estimer.dart';
import 'package:oikosmobile/features/Properties/domain/use_cases/getById.dart';
import 'package:oikosmobile/features/Properties/domain/use_cases/getPropertiesTypes.dart';
import 'package:oikosmobile/features/Properties/domain/use_cases/myProperties.dart';
import 'package:oikosmobile/features/Properties/domain/use_cases/update.dart';
import 'package:oikosmobile/features/Properties/domain/use_cases/uploadPicture.dart';
import 'package:oikosmobile/features/Properties/presentation/bloc/properties_bloc.dart';
import 'package:oikosmobile/features/Service/data/datasources/services_remote_data_source.dart';
import 'package:oikosmobile/features/Service/data/repositories/services_repository_imp.dart';
import 'package:oikosmobile/features/Service/domain/repositories/service_repository.dart';
import 'package:oikosmobile/features/Service/domain/usecases/getServices.dart';
import 'package:oikosmobile/features/Service/domain/usecases/payService.dart';
import 'package:oikosmobile/features/Service/presentation/bloc/bloc.dart';
import 'package:oikosmobile/features/Singin/domain/use_cases/confirmSms.dart';
import 'package:oikosmobile/features/Singin/domain/use_cases/getDepartments.dart';
import 'package:oikosmobile/features/Singin/domain/use_cases/getProfile.dart';
import 'package:oikosmobile/features/Singin/domain/use_cases/getUserById.dart';
import 'package:oikosmobile/features/Singin/domain/use_cases/getUserPicture.dart';
import 'package:oikosmobile/features/Singin/domain/use_cases/loginFacebook.dart';
import 'package:oikosmobile/features/Singin/domain/use_cases/loginGoogle.dart';
import 'package:oikosmobile/features/Singin/presentation/bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features/Notification/data/data_sources/notifications_remote_data_source.dart';
import 'features/Notification/domain/use_cases/read.dart';
import 'features/Notification/presentation/bloc/notification_state.dart';
import 'features/Profile/presentation/bloc/profile_bloc.dart';
import 'features/Properties/data/data_sources/implementation/properties_remote_data_source_imp.dart';
import 'features/Properties/data/data_sources/properties_remote_data_source.dart';
import 'features/Service/data/datasources/implementation/services_remote_data_source_imp.dart';
import 'features/Singin/data/data_sources/implementation/user_remote_data_source_imp.dart';
import 'features/Singin/data/data_sources/user_remote_data_source.dart';
import 'features/Singin/data/repositories/user_repository_imp.dart';
import 'features/Singin/domain/repositories/user_repository.dart';
import 'features/Singin/domain/use_cases/login.dart';
import 'features/Singin/domain/use_cases/registre.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';

final sl = GetIt.instance;
void init() {
  //* ---------------------------------  Feature Sign in  --------------------------

  // ? Bloc
  sl.registerFactory(() => LoginBloc(
    login: sl(),
    register: sl(),
    getDepartments: sl(),
    getUserPicture: sl(),
    myProperties: sl(),
    loginGoogle: sl(),
    loginFacebook: sl(),
    getUserById: sl(),
    getProfile: sl(),
    smsConfirm: sl(),
  ));
  sl.registerFactory(() => HomeBloc(
      InitialHomeState()
  ));
  // ? Use cases
  sl.registerLazySingleton(() => Login(sl()));
  sl.registerLazySingleton(() => Register(sl()));
  sl.registerLazySingleton(() => GetProfile(sl()));
  sl.registerLazySingleton(() => GetUserById(sl()));
  sl.registerLazySingleton(() => GetDepartments(sl()));
  sl.registerLazySingleton(() => GetUserPicture(sl()));
  sl.registerLazySingleton(() => MyProperties(sl()));
  sl.registerLazySingleton(() => LoginGoogle(sl()));
  sl.registerLazySingleton(() => LoginFacebook(sl()));
  sl.registerLazySingleton(() => SmsConfirm(sl()));

  // ? Repository
  sl.registerLazySingleton<UserRepository>(
          () => UserRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));


  // ? Data sources
  sl.registerLazySingleton<UserRemoteDataSource>(
          () => UserRemoteDataSourceImpl(client: sl()));

  //* ---------------------------------  Feature Properties  --------------------------
  // ? Bloc
  sl.registerFactory(() => PropertiesBloc(
    create: sl(),
    estimate: sl(),
    update: sl(),
    uploadPicture: sl(),
    getById: sl(),
    deleteImages: sl(),
    getPropertiesTypes: sl(),
    myProperties: sl(),
    deleteProperties: sl(),
  ));
  // ? Use cases
  sl.registerLazySingleton(() => Create(sl()));
  sl.registerLazySingleton(() => Estimate(sl()));
  sl.registerLazySingleton(() => Update(sl()));
  sl.registerLazySingleton(() => UploadPicture(sl()));
  sl.registerLazySingleton(() => GetById(sl()));
  sl.registerLazySingleton(() => DeleteImages(sl()));
  sl.registerLazySingleton(() => GetPropertiesTypes(sl()));
  sl.registerLazySingleton(() => DeleteProperties(sl()));


  // ? Repository
  sl.registerLazySingleton<PropertiesRepository>(
          () => PropertiesRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));

  // ? Data sources
  sl.registerLazySingleton<PropertiesRemoteDataSource>(
          () => PropertiesRemoteDataSourceImpl(client: sl()));
  //* ---------------------------------  Feature Offers  --------------------------
  // ? Bloc
  sl.registerFactory(() => OfferBloc(
    acceptOffer: sl(),
    counterOffer: sl(),
    getOffersByProperties: sl(),
    rejectOffer: sl(),
    getUserById: sl()
  ));
  // ? Use cases
  sl.registerLazySingleton(() => AcceptOffer(sl()));
  sl.registerLazySingleton(() => CounterOffer(sl()));
  sl.registerLazySingleton(() => GetOffersByProperties(sl()));
  sl.registerLazySingleton(() => RejectOffer(sl()));

  // ? Repository
  sl.registerLazySingleton<OfferRepository>(
          () => OfferRepositoryImpl(remoteDataSource: sl(),networkInfo: sl()));

  // ? Data sources
  sl.registerLazySingleton<OfferRemoteDataSource>(
          () => OfferRemoteDataSourceImpl(client: sl()));


  //* ---------------------------------  Feature Profile  --------------------------
  // ? Bloc
  sl.registerFactory(() => ProfileBloc(
    updatePicture: sl(),
    getDepartments: sl(),
    updateProfile: sl(),
    updatePassword: sl(),
    updateGeneralInformation: sl(),
    getProfile: sl(),
  ));
  // ? Use cases
  sl.registerLazySingleton(() => UpdatePicture(sl()));
  sl.registerLazySingleton(() => UpdateProfile(sl()));
  sl.registerLazySingleton(() => UpdatePassword(sl()));
  sl.registerLazySingleton(() => UpdateGeneralInformation(sl()));

  // ? Repository
  sl.registerLazySingleton<ProfileRepository>(
          () => ProfileRepositoryImpl(remoteDataSource: sl(),networkInfo: sl()));

  // ? Data sources
  sl.registerLazySingleton<ProfileRemoteDataSource>(
          () => ProfileRemoteDataSourceImpl(client: sl()));
  //* ---------------------------------  Feature Disponibility  --------------------------
  // ? Bloc
  sl.registerFactory(() => CalendarBloc(
      addMany: sl(),
  ));
  // ? Use cases
  sl.registerLazySingleton(() => AddMany(sl()));

  // ? Repository
  sl.registerLazySingleton<DisponibilityRepository>(
          () => DisponibilityRepositoryImpl(remoteDataSource: sl(),networkInfo: sl()));

  // ? Data sources
  sl.registerLazySingleton<DisponibilityRemoteDataSource>(
          () => DisponibilityRemoteDataSourceImpl(client: sl()));

  //* ---------------------------------  Feature Notifications  --------------------------
  // ? Bloc
  sl.registerFactory(() => NotificationBloc(
    getUnRead: sl(),
    read: sl()
  ));
  // ? Use cases
  sl.registerLazySingleton(() => GetUnRead(sl()));
  sl.registerLazySingleton(() => Read(sl()));

  // ? Repository
  sl.registerLazySingleton<NotificationsRepository>(
          () => NotificationsRepositoryImpl(remoteDataSource: sl(),networkInfo: sl()));

  // ? Data sources
  sl.registerLazySingleton<NotificationsRemoteDataSource>(
          () => NotificationsRemoteDataSourceImpl(client: sl()));

  //* ---------------------------------  Feature Message  --------------------------
  // ? Bloc
  sl.registerFactory(() => MessageBloc(
    getMessagesThread: sl(),
    getMessagesThreads: sl(),
    getUserById: sl(),
    sendMessage: sl(),
  ));
  // ? Use cases
  sl.registerLazySingleton(() => GetMessagesThread(sl()));
  sl.registerLazySingleton(() => GetMessagesThreads(sl()));
  sl.registerLazySingleton(() => SendMessage(sl()));
  // ? Repository
  sl.registerLazySingleton<MessageRepository>(
          () => MessageRepositoryImpl(remoteDataSource: sl(),networkInfo: sl()));

  // ? Data sources
  sl.registerLazySingleton<MessageRemoteDataSource>(
          () => MessageRemoteDataSourceImpl(client: sl()));
  //* ---------------------------------  Feature Services  --------------------------
  // ? Bloc
  sl.registerFactory(() => ServiceBloc(
      getServices: sl(),
    payService: sl(),
  ));
  // ? Use cases
  sl.registerLazySingleton(() => GetServices(sl()));
  sl.registerLazySingleton(() => PayService(sl()));
  // ? Repository
  sl.registerLazySingleton<ServiceRepository>(
          () => ServiceRepositoryImpl(remoteDataSource: sl(),networkInfo: sl()));

  // ? Data sources
  sl.registerLazySingleton<ServiceRemoteDataSource>(
          () => ServiceDataSourceImpl(client: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));





  //*--------------------------------------- External  --------------------------------------


  sl.registerLazySingleton(() => DataConnectionChecker());
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => SharedPreferences.getInstance());

  Stripe.publishableKey = 'pk_test_51JyO7uBeozUEAEmFG5LPRupCDIyK3gLJLN1xzRmuUjPkFbvDEUlXGJogcd5KSx17uedUD4wQnQaJIt8U0dby3iwA00qCR02qJu';


}


