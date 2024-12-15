import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commercial_app/utils/formatters/formatter.dart';

class AddressModel {
  String id;
  final String name;
  final String phoneNumber;
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final DateTime? dateTime;
  bool selectedAddress;

  AddressModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.street,
    required this.state,
    required this.postalCode,
    required this.city,
    required this.country,
    this.selectedAddress = true,
    this.dateTime,
  });

  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

  static AddressModel empty() => AddressModel(id: "", name: "", phoneNumber: "", street: "", state: "", city: "", postalCode: "", country: "");

  Map<String, dynamic> toJson(){
    return {
      'Id' : id,
      'Name' : name,
      'PhoneNumber' : phoneNumber,
      'Street' : street,
      'City' : city,
      'State' : state,
      'PostalCode' : postalCode,
      'Country' : country,
      'DateTime' : DateTime.now(),
      'SelectedAddress' : selectedAddress,
    };
  }

  factory AddressModel.fromSnapshot(Map<String, dynamic> data) {
    return AddressModel(
      id: data['Id'] as String,
      name: data['Name'] as String,
      phoneNumber: data['PhoneNumber'] as String,
      street: data['Street'] as String,
      city: data['City'] as String,
      state: data['State'] as String,
      country: data['Country'] as String,
      postalCode: data['PostalCode'] as String,
      dateTime: (data['DateTime'] as Timestamp).toDate(),
      selectedAddress: data['SelectedAddress'] as bool,
    );
  }

  /// Factory Constructor to create an AddressModel from a JSON Document Snapshot
  factory AddressModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return AddressModel(
      id: snapshot.id,
      name: data['Name'] ?? '',
      phoneNumber: data['PhoneNumber'] ?? '',
      street: data['Street'] ?? '',
      city: data['City'] ?? '',
      state: data['State'] ?? '',
      country: data['Country'] ?? '',
      postalCode: data['PostalCode'] ?? '',
      dateTime: (data['DateTime'] as Timestamp).toDate(),
      selectedAddress: data['SelectedAddress'] as bool,
    );
  }

  @override
  String toString() {
    return "$street, $city, $state $postalCode, $country";
  }
}