class Offers {
  int totalPages;
  int totalElements;
  int size;
  List<Offer> content;
  int number;
  Sort sort;
  int numberOfElements;
  Pageable pageable;
  bool first;
  bool last;
  bool empty;

  Offers(
      {this.totalPages,
        this.totalElements,
        this.size,
        this.content,
        this.number,
        this.sort,
        this.numberOfElements,
        this.pageable,
        this.first,
        this.last,
        this.empty});

  Offers.fromJson(Map<String, dynamic> json) {
    totalPages = json['totalPages'];
    totalElements = json['totalElements'];
    size = json['size'];
    if (json['content'] != null) {
      content = new List<Offer>();
      json['content'].forEach((v) {
        content.add(new Offer.fromJson(v));
      });
    }
    number = json['number'];
    sort = json['sort'] != null ? new Sort.fromJson(json['sort']) : null;
    numberOfElements = json['numberOfElements'];
    pageable = json['pageable'] != null
        ? new Pageable.fromJson(json['pageable'])
        : null;
    first = json['first'];
    last = json['last'];
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalPages'] = this.totalPages;
    data['totalElements'] = this.totalElements;
    data['size'] = this.size;
    if (this.content != null) {
      data['content'] = this.content.map((v) => v.toJson()).toList();
    }
    data['number'] = this.number;
    if (this.sort != null) {
      data['sort'] = this.sort.toJson();
    }
    data['numberOfElements'] = this.numberOfElements;
    if (this.pageable != null) {
      data['pageable'] = this.pageable.toJson();
    }
    data['first'] = this.first;
    data['last'] = this.last;
    data['empty'] = this.empty;
    return data;
  }
}

class Offer {
  String id;
  String previousOfferID;
  String createdAt;
  String senderID;
  String recipientID;
  String propertyID;
  String endsAt;
  String status;
  double amount;

  Offer(
      {this.id,
        this.previousOfferID,
        this.createdAt,
        this.senderID,
        this.recipientID,
        this.propertyID,
        this.endsAt,
        this.status,
        this.amount});

  Offer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    previousOfferID = json['previousOfferID'];
    createdAt = json['createdAt'];
    senderID = json['senderID'];
    recipientID = json['recipientID'];
    propertyID = json['propertyID'];
    endsAt = json['endsAt'];
    status = json['status'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['previousOfferID'] = this.previousOfferID;
    data['createdAt'] = this.createdAt;
    data['senderID'] = this.senderID;
    data['recipientID'] = this.recipientID;
    data['propertyID'] = this.propertyID;
    data['endsAt'] = this.endsAt;
    data['status'] = this.status;
    data['amount'] = this.amount;
    return data;
  }
}

class Sort {
  bool unsorted;
  bool sorted;
  bool empty;

  Sort({this.unsorted, this.sorted, this.empty});

  Sort.fromJson(Map<String, dynamic> json) {
    unsorted = json['unsorted'];
    sorted = json['sorted'];
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unsorted'] = this.unsorted;
    data['sorted'] = this.sorted;
    data['empty'] = this.empty;
    return data;
  }
}

class Pageable {
  int page;
  int size;

  Pageable({this.page, this.size});

  Pageable.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['size'] = this.size;
    return data;
  }
}