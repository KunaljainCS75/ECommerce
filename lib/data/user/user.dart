import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commercial_app/utils/formatters/formatter.dart';

class UserModel{

  final String id;
  String firstName;
  String lastName;
  final String username;
  final String email;
  String phoneNumber;
  String profilePicture;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.phoneNumber,
    required this.email,
    required this.profilePicture,

  });

  /// Helper function to get the full name.
  String get fullName => '$firstName $lastName';

  /// Helper function to format phoneNo.
  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

  /// Static function to split full name
  static List <String> nameParts(fullName) => fullName.split(" ");

  /// Static function to generate username from full name
  static String generateUsername(fullName) {
    List <String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUsername = '$firstName$lastName';
    String usernameWithPrefix = 'cwt_$camelCaseUsername';
    return usernameWithPrefix;
  }

  /// Static function to create an empty user model.
  static UserModel empty() => UserModel(id: '', firstName: '', lastName: '', username: '', phoneNumber: '', email: '', profilePicture: '');

  /// Convert Model to JSON Structure for storing data in Firebase.
  Map <String, dynamic> toJson(){
    return {
      'FirstName' : firstName,
      'LastName' : lastName,
      'Username' : username,
      'Email' : email,
      'PhoneNumber' : phoneNumber,
      'ProfilePicture' : profilePicture,
    };
  }

  /// Factory Method to create a UserModel from a Firebase document snapshot.
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){

    if (document.data() != null){
      final data = document.data()!;
      return UserModel(
          id: document.id,
          firstName: data['FirstName'] ?? '',
          lastName: data['LastName'] ?? '',
          username: data['Username'] ?? '',
          phoneNumber: data['PhoneNumber'] ?? '',
          email: data['Email'] ?? '',
          profilePicture: data['ProfilePicture'] ?? '',
      );
    }
    throw Exception("No such User Found");
  }
}