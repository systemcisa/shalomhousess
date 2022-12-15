import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shalomhouse/constants/data_keys.dart';


class RecordModel {
  late String recordKey;
 // late List<String> imageDownloadUrls;
  late String title;
  late String category1;
  late num price1;
  late num price2;
  late num price3;
  late num price4;
  late num price5;
  late num price6;
  late num price7;
  late num price8;
  late num price9;
  late num price10;
  late num price11;
  late num price12;
  late String detail;
  late String address1;
  late String address2;
  late String address3;
  late String address4;
  late String address5;
  late String address6;
  late String address7;
  late String address8;
  late String address9;
  late String address10;
  late String address11;
  late String address12;

  late DateTime createdDate;

  RecordModel({required this.recordKey,

  //  required this.imageDownloadUrls,
    required this.title,
    required this.category1,
    required this.price1,
    required this.price2,
    required this.price3,
    required this.price4,
    required this.price5,
    required this.price6,
    required this.price7,
    required this.price8,
    required this.price9,
    required this.price10,
    required this.price11,
    required this.price12,
    required this.detail,
    required this.address1,
    required this.address2,
    required this.address3,
    required this.address4,
    required this.address5,
    required this.address6,
    required this.address7,
    required this.address8,
    required this.address9,
    required this.address10,
    required this.address11,
    required this.address12,
    required this.createdDate,
  });

  RecordModel.fromJson(Map<String, dynamic> json, this.recordKey,) {
    // imageDownloadUrls = json[DOC_IMAGEDOWNLOADURLS] != null
    //     ? json[DOC_IMAGEDOWNLOADURLS].cast<String>()
    //     : [];
    title = json[DOC_TITLE] ?? "";
    category1 = json[DOC_CATEGORY] ?? "none";
    price1 = json[DOC_PRICE1] ?? 0;
    price2 = json[DOC_PRICE2] ?? 0;
    price3 = json[DOC_PRICE3] ?? 0;
    price4 = json[DOC_PRICE4] ?? 0;
    price5 = json[DOC_PRICE5] ?? 0;
    price6 = json[DOC_PRICE6] ?? 0;
    price7 = json[DOC_PRICE7] ?? 0;
    price8 = json[DOC_PRICE8] ?? 0;
    price9 = json[DOC_PRICE9] ?? 0;
    price10 = json[DOC_PRICE10] ?? 0;
    price11 = json[DOC_PRICE11] ?? 0;
    price12 = json[DOC_PRICE12] ?? 0;
    detail = json[DOC_DETAIL] ?? "";
    address1 = json[DOC_ADDRESS1] ?? "";
    address2 = json[DOC_ADDRESS2] ?? "";
    address3 = json[DOC_ADDRESS3] ?? "";
    address4 = json[DOC_ADDRESS4] ?? "";
    address5 = json[DOC_ADDRESS5] ?? "";
    address6 = json[DOC_ADDRESS6] ?? "";
    address7 = json[DOC_ADDRESS7] ?? "";
    address8 = json[DOC_ADDRESS8] ?? "";
    address9 = json[DOC_ADDRESS9] ?? "";
    address10 = json[DOC_ADDRESS10] ?? "";
    address11 = json[DOC_ADDRESS11] ?? "";
    address12 = json[DOC_ADDRESS12] ?? "";
    createdDate = json[DOC_CREATEDDATE] == null
        ? DateTime.now().toUtc()
        : (json[DOC_CREATEDDATE] as Timestamp).toDate();
  }

  RecordModel.fromAlgoliaObject(Map<String, dynamic> json, this.recordKey) {
    // imageDownloadUrls = json[DOC_IMAGEDOWNLOADURLS] != null
    //     ? json[DOC_IMAGEDOWNLOADURLS].cast<String>()
    //     : [];
    title = json[DOC_TITLE] ?? "";
    category1 = json[DOC_CATEGORY] ?? "none";
    price1 = json[DOC_PRICE1] ?? 0;
    price2 = json[DOC_PRICE2] ?? 0;
    price3 = json[DOC_PRICE3] ?? 0;
    price4 = json[DOC_PRICE4] ?? 0;
    price5 = json[DOC_PRICE5] ?? 0;
    price6 = json[DOC_PRICE6] ?? 0;
    price7 = json[DOC_PRICE7] ?? 0;
    price8 = json[DOC_PRICE8] ?? 0;
    price9 = json[DOC_PRICE9] ?? 0;
    price10 = json[DOC_PRICE10] ?? 0;
    price11 = json[DOC_PRICE11] ?? 0;
    price12 = json[DOC_PRICE12] ?? 0;
    detail = json[DOC_DETAIL] ?? "";
    address1 = json[DOC_ADDRESS1] ?? "";
    address2 = json[DOC_ADDRESS2] ?? "";
    address3 = json[DOC_ADDRESS3] ?? "";
    address4 = json[DOC_ADDRESS4] ?? "";
    address5 = json[DOC_ADDRESS5] ?? "";
    address6 = json[DOC_ADDRESS6] ?? "";
    address7 = json[DOC_ADDRESS7] ?? "";
    address8 = json[DOC_ADDRESS8] ?? "";
    address9 = json[DOC_ADDRESS9] ?? "";
    address10 = json[DOC_ADDRESS10] ?? "";
    address11 = json[DOC_ADDRESS11] ?? "";
    address12 = json[DOC_ADDRESS12] ?? "";
    createdDate = DateTime.now().toUtc();
  }

  RecordModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data(), snapshot.id);

  RecordModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data()!, snapshot.id);

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    //map[DOC_IMAGEDOWNLOADURLS] = imageDownloadUrls;
    map[DOC_TITLE] = title;
    map[DOC_CATEGORY] = category1;
    map[DOC_PRICE1] = price1;
    map[DOC_PRICE2] = price2;
    map[DOC_PRICE3] = price3;
    map[DOC_PRICE4] = price4;
    map[DOC_PRICE5] = price5;
    map[DOC_PRICE6] = price6;
    map[DOC_PRICE7] = price7;
    map[DOC_PRICE8] = price8;
    map[DOC_PRICE9] = price9;
    map[DOC_PRICE10] = price10;
    map[DOC_PRICE11] = price11;
    map[DOC_PRICE12] = price12;
    map[DOC_DETAIL] = detail;
    map[DOC_ADDRESS1] = address1;
    map[DOC_ADDRESS2] = address2;
    map[DOC_ADDRESS3] = address3;
    map[DOC_ADDRESS4] = address4;
    map[DOC_ADDRESS5] = address5;
    map[DOC_ADDRESS6] = address6;
    map[DOC_ADDRESS7] = address7;
    map[DOC_ADDRESS8] = address8;
    map[DOC_ADDRESS9] = address9;
    map[DOC_ADDRESS10] = address10;
    map[DOC_ADDRESS11] = address11;
    map[DOC_ADDRESS12] = address12;


    map[DOC_CREATEDDATE] = createdDate;
    return map;
  }

  Map<String, dynamic> toMinJson() {
    var map = <String, dynamic>{};
   // map[DOC_IMAGEDOWNLOADURLS] = imageDownloadUrls.sublist(0, 1);
    map[DOC_TITLE] = title;
    map[DOC_PRICE1] = price1;
    return map;
  }

  static String generateItemKey(String uid) {
    String timeInMilli = DateTime
        .now()
        .millisecondsSinceEpoch
        .toString();
    return '${uid}_$timeInMilli';
  }
}