class UserInfoModel {
  // final String? imageUrl;
  var name;
  var emailId;
  // final String? id;
  var tenantId;
  //late final String? displayName;
  var emailVerified;
  var phoneNumber;
  var photoURL;
  var refreshToken;
  var uid;
  UserInfoModel(
      {
      // this.imageUrl,
      this.name,
      this.emailId,
      // this.id,
      this.tenantId,
      // this.displayName,
      this.emailVerified,
      this.phoneNumber,
      this.photoURL,
      this.refreshToken,
      this.uid});
}
