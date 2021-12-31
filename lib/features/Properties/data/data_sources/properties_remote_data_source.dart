import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Properties/domain/entities/typesOfProperties_model.dart';

abstract class PropertiesRemoteDataSource{
  Future<PropertiesModel> create (CreatePropertiesParams createPropertiesParams);
  Future<List<PropertiesModel>> myProperties(String token);
  Future<List<PropertiesModel>> getAllProperties(String token);
  Future<PropertiesModel> getById(GetPropertiesByIdParams getPropertiesByIdParams);
  Future<List<double>>estimate(EstimateParams estimateParams);
  Future<PropertiesModel>update(CreatePropertiesParams createPropertiesParams);
  Future<String>uploadPicture(UploadPropImageParams uploadPropImageParams);
  Future<String>deleteImages(DeleteImagesParams deleteImagesParams);
  Future<String>deleteProperties(DeleteImPropertiesParams deleteImPropertiesParams);
  Future<List<TypesOfProperties>> getPropertiesTypes(String token);
  Future<List<PropertiesModel>> getAllPropertiesWithStatus(GetAllPropertiesWithStatusParams getAllPropertiesWithStatusParams);
  Future<List<PropertiesModel>> getMyPropertiesWithStatus(GetMyPropertiesWithStatusParams getMyPropertiesWithStatusParams);


}