class PropertiesModel {
  /*
  "doc-description":"Catégorie de Bien "
	"doc-type":"String",
    "typeofprop": "[APPARTEMENT,MAISON,VILLA,ATELIER,PROPRIETE,VIAGER]",
   */
  String typeofprop;
  int typepropInt;
  /*
  "doc-vueProp":"La vue de votre Bien",
	"doc-type":"String",
    "vueProp": "[VIS_A_VIS	,DEGAGEE	,EXCEPTIONNELLE]",
   */
  String vueProp;
  /*
  "doc-description":"Emplacement de votre Bien",
	"doc-type":"String",
    "propLocation": "[Bruyant,Standard,Calme]",
   */
  String propLocation;
  /*
  "doc-description":"La vue de votre Bien",
	"doc-type":"String",
    "propStanding": "[MOYEN,STANDARD,Exceptionnel]"
   */
  String propStanding;
  /*
  "doc-description":"Surface m2",
	"doc-type":"double",
    "allArea": 0,
   */
  double allArea;
  /*
  	"doc-description":"Surface en m2 de terrain ( Bâti de la maison inclus )",
	"doc-type":"double",
    "homeArea": 0,
   */
  double homeArea;
  /*
  	"doc-description":"Surface en m2 de séjour",
	"doc-type":"double",
    "livingArea": 0,
   */
  double livingArea;
  /*
   "location": {
		"doc-type":"double",
			"latitude": 0,
		"doc-type":"double",
			"longitude": 0
    },
   */
  Location location;
  /*
  "address": {
      "street": "string",
      "zipCode": "string",
      "city": "string",
      "stateFull": "string"
    },
   */
  Address address;
  /*
  "doc-description":"Avez-vous une dépendance",
    "hasDependancy": true,
   */
  bool hasDependancy;
  /*
  "doc-description":"autre description du bien ",
    "description": "string",
   */
  String description;
  /*
  "doc-description":"Nombre de chambre",
	"doc-type":"int",
    "nbBedrooms": 150,
   */
  int nbBedrooms;
  /*
  "doc-description":"Nombre de pièces",
	"doc-type":"int",
    "nbRooms": 150,
   */
  int nbRooms;
  /*
  doc-description":"Nombre des places de parking",
	"doc-type":"int",
    "nbParkingPlaces": 150,
   */
  int nbParkingPlaces;
  /*
  "doc-description":"Des travaux à prévoir",
	"doc-type":"boolean",
    "hasPlannedWork": true,
   */
  bool hasPlannedWork;
  /*
  "doc-description":"A enlever cet attribut n'existe pas selon l'interface mobile",
    "doc-type":"int",
	"nbFloors": 150,
   */
  int nbFloors;
  /*
  "doc-description":"Année de construction",
    "doc-type":"string",
    "yearConstruction": "string",
   */
  String yearConstruction;
  /*
  "doc-description":"Duplicated a enlever cet attribut existe livingArea,
    "doc-type":"int",
    "livingSpace": 100000,
   */
  int livingSpace;
  /*
  "doc-description":"prix par defaut 0 avant estimation",
    "doc-type":"int",
    "price": 0,
   */
  double price;
  /*
  "piecesOfProperty": {
      "hasSallon": true,
      "hasCuisine": true,
      "hasTerrasse": true,
      "hasGarage": true,
      "hasBalcon": true,
      "hasJardin": true,
      "hasCave": true,
      "hasPiscine": true
    },
   */
  PiecesOfProperty piecesOfProperty;
  /*
  "doc-description":"	Exportation de votre Bien",
    "propExport": {
      "isNord": true,
      "isSud": true,
      "isEst": true,
      "isOuest": true
    },
   */
  PropExport propExport;
  /*
  "doc-description":"Vous-êtes le propriétaire de ce bien",
    "owner": true
   */
  bool owner;

  /*
  "doc-description":"	Votre Bien est mitoyen",
    "adjoining": true,
   */
  bool adjoining;
  String id;
  String createdAt;
  String updatedAt;
  String status;
  String keyPoints;
  String mainPic;
  String userId;
  List<FileBien> fileBien;
  List<Proplikes> proplikes;
  PropertiesModel(
      {this.typeofprop,
        this.vueProp,
        this.propLocation,
        this.propStanding,
        this.allArea,
        this.homeArea,
        this.livingArea,
        this.location,
        this.address,
        this.hasDependancy,
        this.description,
        this.nbBedrooms,
        this.nbRooms,
        this.nbParkingPlaces,
        this.hasPlannedWork,
        this.nbFloors,
        this.yearConstruction,
        this.livingSpace,
        this.price,
        this.piecesOfProperty,
        this.propExport,
        this.owner,
        this.adjoining,
        this.id,
        this.createdAt,
        this.updatedAt,
        this.status,
        this.keyPoints,
        this.mainPic,
        this.userId,
        this.fileBien,
        this.proplikes,
        this.typepropInt
      });

  PropertiesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    status = json['status'];
    typeofprop = json['typeofprop'];
    vueProp = json['vueProp'];
    propLocation = json['propLocation'];
    propStanding = json['propStanding'];
    allArea = json['allArea'];
    homeArea = json['homeArea'];
    livingArea = json['livingArea'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
    piecesOfProperty = json['piecesOfProperty'] != null
        ? new PiecesOfProperty.fromJson(json['piecesOfProperty'])
        : null;
    propExport = json['propExport'] != null
        ? new PropExport.fromJson(json['propExport'])
        : null;
    hasDependancy = json['hasDependancy'];
    description = json['description'];
    keyPoints = json['keyPoints'];
    nbBedrooms = json['nbBedrooms'];
    nbRooms = json['nbRooms'];
    nbParkingPlaces = json['nbParkingPlaces'];
    hasPlannedWork = json['hasPlannedWork'];
    nbFloors = json['nbFloors'];
    yearConstruction = json['yearConstruction'];
    livingSpace = json['livingSpace'];
    mainPic = json['mainPic'];
    price = json['price'].toDouble();
    userId = json['userId'];
    if (json['fileBien'] != null) {
      fileBien = new List<FileBien>();
      json['fileBien'].forEach((v) {
        fileBien.add(new FileBien.fromJson(v));
      });
    }
    if (json['proplikes'] != null) {
      proplikes = new List<Proplikes>();
      json['proplikes'].forEach((v) {
        proplikes.add(new Proplikes.fromJson(v));
      });
    }
    owner = json['owner'];
    adjoining = json['adjoining'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['status'] = this.status;
    data['typepropInt'] = this.typepropInt;
    data['vueProp'] = this.vueProp;
    data['propLocation'] = this.propLocation;
    data['propStanding'] = this.propStanding;
    data['allArea'] = this.allArea;
    data['homeArea'] = this.homeArea;
    data['livingArea'] = this.livingArea;
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    if (this.piecesOfProperty != null) {
      data['piecesOfProperty'] = this.piecesOfProperty.toJson();
    }
    if (this.propExport != null) {
      data['propExport'] = this.propExport.toJson();
    }
    data['hasDependancy'] = this.hasDependancy;
    data['description'] = this.description;
    data['keyPoints'] = this.keyPoints;
    data['nbBedrooms'] = this.nbBedrooms;
    data['nbRooms'] = this.nbRooms;
    data['nbParkingPlaces'] = this.nbParkingPlaces;
    data['hasPlannedWork'] = this.hasPlannedWork;
    data['nbFloors'] = this.nbFloors;
    data['yearConstruction'] = this.yearConstruction;
    data['livingSpace'] = this.livingSpace;
    data['mainPic'] = this.mainPic;
    data['price'] = this.price;
    data['userId'] = this.userId;
    if (this.fileBien != null) {
      data['fileBien'] = this.fileBien.map((v) => v.toJson()).toList();
    }
    if (this.proplikes != null) {
      data['proplikes'] = this.proplikes.map((v) => v.toJson()).toList();
    }
    data['owner'] = this.owner;
    data['adjoining'] = this.adjoining;
    return data;
  }

}

class Location {
  double latitude;
  double longitude;

  Location({this.latitude, this.longitude});

  Location.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}

class Address {
  String street;
  String zipCode;
  String city;
  String stateFull;

  Address({this.street, this.zipCode, this.city, this.stateFull});

  Address.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    zipCode = json['zipCode'];
    city = json['city'];
    stateFull = json['stateFull'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['street'] = this.street;
    data['zipCode'] = this.zipCode;
    data['city'] = this.city;
    data['stateFull'] = this.stateFull;
    return data;
  }
}

class PiecesOfProperty {
  bool hasSallon;
  bool hasCuisine;
  bool hasTerrasse;
  bool hasGarage;
  bool hasBalcon;
  bool hasJardin;
  bool hasCave;
  bool hasPiscine;

  PiecesOfProperty(
      {this.hasSallon,
        this.hasCuisine,
        this.hasTerrasse,
        this.hasGarage,
        this.hasBalcon,
        this.hasJardin,
        this.hasCave,
        this.hasPiscine});

  PiecesOfProperty.fromJson(Map<String, dynamic> json) {
    hasSallon = json['hasSallon'];
    hasCuisine = json['hasCuisine'];
    hasTerrasse = json['hasTerrasse'];
    hasGarage = json['hasGarage'];
    hasBalcon = json['hasBalcon'];
    hasJardin = json['hasJardin'];
    hasCave = json['hasCave'];
    hasPiscine = json['hasPiscine'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hasSallon'] = this.hasSallon;
    data['hasCuisine'] = this.hasCuisine;
    data['hasTerrasse'] = this.hasTerrasse;
    data['hasGarage'] = this.hasGarage;
    data['hasBalcon'] = this.hasBalcon;
    data['hasJardin'] = this.hasJardin;
    data['hasCave'] = this.hasCave;
    data['hasPiscine'] = this.hasPiscine;
    return data;
  }
}

class PropExport {
  bool isNord;
  bool isSud;
  bool isEst;
  bool isOuest;

  PropExport({this.isNord, this.isSud, this.isEst, this.isOuest});

  PropExport.fromJson(Map<String, dynamic> json) {
    isNord = json['isNord'];
    isSud = json['isSud'];
    isEst = json['isEst'];
    isOuest = json['isOuest'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isNord'] = this.isNord;
    data['isSud'] = this.isSud;
    data['isEst'] = this.isEst;
    data['isOuest'] = this.isOuest;
    return data;
  }
}
class FileBien {
  String createdAt;
  String updatedAt;
  int version;
  String createdBy;
  String updatedBy;
  int size;
  String id;
  String fileName;
  String originalName;
  String fileType;

  FileBien(
      {this.createdAt,
        this.updatedAt,
        this.version,
        this.createdBy,
        this.updatedBy,
        this.size,
        this.id,
        this.fileName,
        this.originalName,
        this.fileType});

  FileBien.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    version = json['version'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    size = json['size'];
    id = json['id'];
    fileName = json['fileName'];
    originalName = json['originalName'];
    fileType = json['fileType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['version'] = this.version;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['size'] = this.size;
    data['id'] = this.id;
    data['fileName'] = this.fileName;
    data['originalName'] = this.originalName;
    data['fileType'] = this.fileType;
    return data;
  }
}
class Proplikes {
  String createdAt;
  String updatedAt;
  int version;
  String createdBy;
  String updatedBy;
  String id;
  String userId;
  String status;

  Proplikes(
      {this.createdAt,
        this.updatedAt,
        this.version,
        this.createdBy,
        this.updatedBy,
        this.id,
        this.userId,
        this.status});

  Proplikes.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    version = json['version'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    id = json['id'];
    userId = json['userId'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['version'] = this.version;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['status'] = this.status;
    return data;
  }
}