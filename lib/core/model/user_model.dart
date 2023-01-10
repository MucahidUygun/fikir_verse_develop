class UserModel {
  final int? id;
  late final String? name;
  late final String? surname;
  late final String? email;
  late final String? password;
  late final DateTime? birthOfDate;
  late final String? phoneNumber;
  late final String? city;
  late final String? gender;
  late final String? maritalStatus;
  late final String? workingStatus;

  UserModel(this.id, this.name, this.surname, this.email, this.password, this.birthOfDate, this.phoneNumber, this.city, this.gender, this.maritalStatus, this.workingStatus);
}