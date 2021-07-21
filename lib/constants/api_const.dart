class APIConstance {
  APIConstance();

  String pathMapping(String api) {
    String? url;
    List<String> apiCheckAuth = [apiLogin,apiLogout];
    List<String> apiCheckUser = [apiUser,apiCreateAcc,apiUpdateProfile];
    List<String> apiCheckInterface = [apiLinkPatientProfile,apiConfirmPatientProfile,apiListAppointment,apiListDoctorByDepartment,apiListDepartment,apiDoctorById,apiListPromotion,apiPromotionDetail,apiListNews,apiNewsDetail,apiHealthTipDetail,apiListHealthTip];
    for (var data in apiCheckAuth) {
      url = api.contains(data) ? _apiBaseUrlAuth : url;
      if (url != null) break;
    }

    for (var data in apiCheckUser) {
      url = api.contains(data) ? _apiBaseUrlUser : url;
      if (url != null) break;
    }

    for (var data in apiCheckInterface) {
      url = api.contains(data) ? _apiBaseUrlInterface : url;
      if (url != null) break;
    }

    return url ?? _apiBaseUrlToken;
  }

  static String baseURLOnly = "https://book.fintechinno.com/mobile/";
  static String baseURL = "https://book.fintechinno.com/oauth/api/auth/";
  final String _apiBaseUrlToken = baseURLOnly + "api/mobile/v1/";
  final String _apiBaseUrlAuth = baseURL + "v2/";
  final String _apiBaseUrlUser = baseURLOnly + "api/auth/v2/" ;
  final String _apiBaseUrlInterface = baseURLOnly + "/api/mobile/v2/";
  String get apiRefreshTokenPath => _apiBaseUrlAuth + "refreshToken";
  String get urlRefreshToken => apiRefreshTokenPath;


  //// [HB]
  final String apiListPromotion = "privilegeand-news";
  final String apiPromotionDetail = "privilegeand-news";
  final String apiListNews = "privilegeand-news";
  final String apiNewsDetail = "privilegeand-news";
  final String apiHealthTipDetail = "privilegeand-news";
  final String apiListHealthTip = "privilegeand-news";
  final String apiLogin = "login";
  final String apiUser = "user_info";
  final String apiCreateAcc = "create_account";
  final String apiReqOTP = "requestOTP";
  final String apiCheckOTP = "checkOTP";
  final String apiListAppointment = "listAppointment";
  final String apiListDoctor = "listDoctor";
  final String apiListEmergency = "listEmergency";
  final String apiLinkPatientProfile = "linkProfilePatient";
  final String apiConfirmPatientProfile = "confirmProfilePatient";
  final String apiRefreshToken = "refreshToken";
  final String apiUpdateProfile = "update_user";
  final String apiListDoctorByDepartment = "listDoctor";
  final String apiListDepartment = "listDepartmentDoctor";
  final String apiDoctorById = "doctorByID";
  final String apiLogout = "logout";

}
