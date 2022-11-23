import 'media_model.dart';
import 'parents/model.dart';

class User extends Model {
  String name;
  String email;
  String password;
  Media avatar;
  String apiToken;
  String deviceToken;
  String phoneNumber;
  bool verifiedPhone;
  String verificationId;
  String address;
  String bio;
  String latitude="0.0";
  String longitude="0.0";
  String description="Work";
  String facebookUrl;
  String instagramUrl;
  String youtubeUrl;
  String citizenshipFront;
  String citizenshipBack;
  String profileImg;

  bool auth;

  User({this.name, this.email, this.password, this.apiToken, this.deviceToken, this.phoneNumber, this.verifiedPhone, this.verificationId, this.address, this.bio,this.citizenshipBack,this.citizenshipFront});

  User.fromJson(Map<String, dynamic> json) {
    name = stringFromJson(json, 'name');
    email = stringFromJson(json, 'email');
    apiToken = stringFromJson(json, 'api_token');
    deviceToken = stringFromJson(json, 'device_token');
    citizenshipFront = stringFromJson(json['eProvider'], 'citizenship_front');
    citizenshipBack = stringFromJson(json['eProvider'], 'citizenship_back');
    facebookUrl = stringFromJson(json['eProvider'], 'facebook_url');
    youtubeUrl = stringFromJson(json['eProvider'], 'youtube_url');
    instagramUrl = stringFromJson(json['eProvider'], 'instagram_url');
    phoneNumber = stringFromJson(json, 'phone_number');
    verifiedPhone = boolFromJson(json, 'phone_verified_at');
    avatar = mediaFromJson(json, 'avatar');
    auth = boolFromJson(json, 'auth');
    try {
      address = json['custom_fields']['address']['view'];
    } catch (e) {
      address = stringFromJson(json, 'address');
    }
    try {
      bio = json['custom_fields']['bio']['view'];
    } catch (e) {
      bio = stringFromJson(json, 'bio');
    }
    super.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['description'] = this.description;
    data['youtube_url'] = this.youtubeUrl;
    data['facebook_url'] = this.facebookUrl;
    data['instagram_url'] = this.instagramUrl;
    data['citizenship_front'] = this.citizenshipFront;
    data['citizenship_back'] = this.citizenshipBack;
    data['profileImg'] = this.profileImg;
    if (password != null && password != '') {
      data['password'] = this.password;
    }
    data['api_token'] = this.apiToken;
    if (deviceToken != null) {
      data["device_token"] = deviceToken;
    }
    data["phone_number"] = phoneNumber;
    if (verifiedPhone != null && verifiedPhone) {
      data["phone_verified_at"] = DateTime.now().toLocal().toString();
    }
    data["address"] = address;
    data["bio"] = bio;
    if (avatar != null) {
      data["media"] = [avatar.toJson()];
    }
    data['auth'] = this.auth;
    return data;
  }

  Map toRestrictMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["email"] = email;
    map["name"] = name;
    map["thumb"] = avatar.thumb;
    map["device_token"] = deviceToken;
    return map;
  }

  @override
  bool operator ==(Object other) =>
      super == other &&
      other is User &&
      runtimeType == other.runtimeType &&
      name == other.name &&
      email == other.email &&
      password == other.password &&
      avatar == other.avatar &&
      apiToken == other.apiToken &&
      deviceToken == other.deviceToken &&
      phoneNumber == other.phoneNumber &&
      verifiedPhone == other.verifiedPhone &&
      verificationId == other.verificationId &&
      address == other.address &&
      bio == other.bio &&
      auth == other.auth;

  @override
  int get hashCode =>
      super.hashCode ^
      name.hashCode ^
      email.hashCode ^
      password.hashCode ^
      avatar.hashCode ^
      apiToken.hashCode ^
      deviceToken.hashCode ^
      phoneNumber.hashCode ^
      verifiedPhone.hashCode ^
      verificationId.hashCode ^
      address.hashCode ^
      bio.hashCode ^
      auth.hashCode;
}
