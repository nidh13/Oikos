import 'package:dartz/dartz.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Properties/domain/entities/typesOfProperties_model.dart';

abstract class PropertiesRepository{
  Future<Either<Failure,PropertiesModel>> create(CreatePropertiesParams createPropertiesParams);
  Future<Either<Failure,List<PropertiesModel>>> myProperties(String token);
  Future<Either<Failure,List<PropertiesModel>>> getAllProperties(String token);
  Future<Either<Failure,PropertiesModel>> getById(GetPropertiesByIdParams getPropertiesByIdParams);
  Future<Either<Failure,List<TypesOfProperties>>> getPropertiesTypes(String token);
  Future<Either<Failure,PropertiesModel>> update(CreatePropertiesParams createPropertiesParams);
  Future<Either<Failure,String>> uploadPicture(UploadPropImageParams uploadPropImageParams);
  Future<Either<Failure,List<FileBien>>> getPropertiesFiles(GetPropertiesFilesParams getPropertiesFilesParams);
  Future<Either<Failure,List<PropertiesModel>>> allProperties(String token);
  Future<Either<Failure,List<double>>> estimate(EstimateParams estimateParams);
  Future<Either<Failure,String>> deleteImages(DeleteImagesParams deleteImagesParams);
  Future<Either<Failure,List<PropertiesModel>>> getAllPropertiesWithStatus(GetAllPropertiesWithStatusParams getAllPropertiesWithStatusParams);
  Future<Either<Failure,List<PropertiesModel>>> getMyPropertiesWithStatus(GetMyPropertiesWithStatusParams getMyPropertiesWithStatusParams);
  Future<Either<Failure,String>> deleteProperties(DeleteImPropertiesParams deleteImPropertiesParams);

}