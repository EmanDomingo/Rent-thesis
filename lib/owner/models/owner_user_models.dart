


class OwnerUserModel{
  final bool? approved;
  final String? ownerId;
  final String? bussinessName;
  final String? cityValue;
  final String? countryValue;
  final String? email;
  final String? phoneNumber;
  final String? stateValue;
  final String? storeImage;
  // final String? taxNumber;
  // final String? taxRegistered;

  OwnerUserModel(
    {required this.approved,
    required this.ownerId,
    required this.bussinessName,
    required this.cityValue,
    required this.countryValue,
    required this.email,
    required this.phoneNumber,
    required this.stateValue,
    required this.storeImage,
    // required this.taxNumber,
    // required this.taxRegistered
    });

    OwnerUserModel.fromJson(Map<String, Object?> json)
    :this(
      approved: json['approved']! as bool,
      ownerId: json['ownerId']! as String,
      bussinessName: json['bussinessName']! as String,
      cityValue: json['cityValue']! as String,
      countryValue: json['countryValue']! as String,
      email: json['email']! as String,
      phoneNumber: json['phoneNumber']! as String,
      stateValue: json['stateValue']! as String,
      storeImage: json['storeImage']! as String,
      // taxNumber: json['taxNumber']! as String,
      // taxRegistered: json['taxRegistered']! as String,
    );

    Map<String, Object?> toJson() {
      return {
        'approve':approved,
        'ownerId':ownerId,
        'bussinessName':bussinessName,
        'cityValue':approved,
        'countryValue':countryValue,
        'email':email,
        'phoneNumber':phoneNumber,
        'stateValue':stateValue,
        'storeImage':storeImage,
        // 'taxNumber':taxNumber,
        // 'taxRegistered':taxRegistered,
      };
    }
}