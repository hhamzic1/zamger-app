import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:zamgerapp/ZamgerAPI/secure_storage.dart';
import 'package:zamgerapp/main.dart';
import 'package:zamgerapp/models/certificate.dart';
import 'package:zamgerapp/models/index.dart';

class ZamgerAPIService {
  static Dio client;

  ZamgerAPIService() {
    client = new Dio(BaseOptions(
      baseUrl: 'https://zamger.etf.unsa.ba/api_v6',
    ));
    client.interceptors.add(ZamgerAuthInterceptor());
  }

  static Future<Response<dynamic>> currentPerson() {
    final $url = '/person&resolve[]=ExtendedPerson';
    return client.get($url);
  }

  static Future<Response<dynamic>> getPersonById(int id) {
    final $url = '/person/$id';
    return client.get($url);
  }

  static Future<Response<dynamic>> findPersonBySearch(String name) {
    final $url = '/person/search';
    final $params = <String, dynamic>{'query': name};
    return client.get($url, queryParameters: $params);
  }

  static Future<Response<dynamic>> getExtendedPersonById(int id) {
    final $url = '/extendedPerson/$id';
    return client.get($url);
  }

  static Future<Response<dynamic>> getRecentRecievedMessages(int limit) {
    final $url = '/inbox&resolve[]=Person';
    final $params = <String, dynamic>{'messages': limit};
    return client.get($url, queryParameters: $params);
  }

  static Future<Response<dynamic>> getRecentSentMessages(int limit) {
    final $url = '/inbox/outbox&resolve[]=Person';
    final $params = <String, dynamic>{'messages': limit};
    return client.get($url, queryParameters: $params);
  }

  static Future<Response<dynamic>> getCountOfMessagesInInbox() {
    final $url = '/inbox/count';
    return client.get($url);
  }

  static Future<Response<dynamic>> getUnreadMessages() {
    final $url = '/inbox/unread&resolve[]=Person';
    return client.get($url);
  }

  static Future<Response<dynamic>> getMessageById(int messageId) {
    final $url = '/inbox/$messageId';
    return client.get($url);
  }

  static Future<Response<dynamic>> getInboxAnnouncements(int limit) {
    final $url = '/inbox/announcements';
    final $params = <String, dynamic>{'messages': limit};
    return client.get($url, queryParameters: $params);
  }

  static Future<Response<dynamic>> sendMessage(Message message) {
    final $url = '/inbox';
    return client.post($url, data: message.toJson());
  }

  static Future<Response<dynamic>> getMyCurrentCourses(int id) {
    final $url =
        '/course/student/$id&resolve[]=CourseOffering&resolve[]=CourseUnit';
    return client.get($url);
  }

  static Future<Response<dynamic>> getCourseDetailsForStudent(
      int course, int student) {
    final $url = '/course/$course/student/$student';
    return client.get($url);
  }

  static Future<Response<dynamic>> getLatestGradesForStudent(
      int student, int limit) {
    final $url =
        '/course/latestGrades/$student&resolve[]=CourseOffering&resolve[]=CourseUnit';
    final $params = <String, dynamic>{'limit': limit};
    return client.get($url, queryParameters: $params);
  }

  static Future<Response<dynamic>> getMyStudy(int student) {
    final $url =
        '/course/student/$student&all=true&resolve[]=CourseOffering&resolve[]=CourseUnit&resolve[]=AcademicYear&score=true';
    return client.get($url);
  }

  static Future<Response<dynamic>> getMyEnrollmentInfo(int student) {
    final $url =
        '/enrollment/current/$student&resolve[]=Programme&resolve[]=EnrollmentType';
    return client.get($url);
  }

  static Future<Response<dynamic>> getDetailsOfCourse(
      int courseId, int student, int year) {
    final $url =
        '/course/$courseId/student/$student&year=$year&score=true&resolve[]=CourseActivity&details=true&resolve[]=ZClass&resolve[]=CourseUnit&resolve[]=AcademicYear&totalScore=true&resolve[]=Homework';
    return client.get($url);
  }

  static Future<Response<dynamic>> getAttendanceOnCourse(
      int course, int student, int year) {
    final $url =
        '/class/course/$course/student/$student&resolve[]=ZClass&resolve[]=Person';
    final $params = <String, dynamic>{'year': year};
    return client.get($url, queryParameters: $params);
  }

  static Future<Response<dynamic>> getLatestExamResults(
      int student, int limit) {
    final $url = '/exam/latest/$student';
    final $params = <String, dynamic>{'limit': limit};
    return client.get($url, queryParameters: $params);
  }

  static Future<Response<dynamic>> getUpcomingHomeworks(int student) {
    final $url = '/homework/latest/$student&resolve[]=CourseUnit';
    return client.get($url);
  }

  static Future<Response<dynamic>> getFileByHomeworkId(
      int homeworkId, int asgn, int student) {
    final $url = '/homework/$homeworkId/$asgn/student/$student/file';
    return client.get($url);
  }

  static Future<Response<dynamic>> getHomework(
      int homeworkId, int asgn, int courseId, int student) {
    final $url =
        '/homework/$homeworkId/$asgn/student/$student&resolve[]=Person&resolve[]=Homework&resolve[]=CourseUnit';
    return client.get($url);
  }

  static Future<Response<dynamic>> getStatusOfSubmittedHomeworkById(
      int homeworkId, int asgn, int student) {
    final $url = '/homework/$homeworkId/$asgn/student/$student';
    return client.get($url);
  }

  static Future<Response<dynamic>> getStatusesOfHomeworksOnCourse(
      int course, int student) {
    final $url = '/homework/course/$course/student/$student';
    return client.get($url);
  }

  static Future<Response<dynamic>> getUpcomingEvents(int student) {
    final $url = '/event/upcoming/$student&resolve[]=CourseUnit';
    return client.get($url);
  }

  static Future<Response<dynamic>> getRegisteredEvents(int student) {
    final $url = '/event/registered/$student';
    return client.get($url);
  }

  static Future<Response<dynamic>> registerForEvent(int eventId, int student) {
    final $url = '/event/$eventId/register/$student';
    return client.post($url);
  }

  static Future<Response<dynamic>> unregisterForEvent(
      int eventId, int student) {
    final $url = '/event/$eventId/register/$student';
    return client.delete($url);
  }

  static Future<Response<dynamic>> getInfoAboutMyProgrammeAndSemester(
      int student) {
    final $url = '/enrollment/current/$student';
    return client.get($url);
  }

  static Future<Response<dynamic>> getInfoAboutAllSemestersOfStudent(
      int student) {
    final $url = '/enrollment/all/$student';
    return client.get($url);
  }

  static Future<Response<dynamic>> getCertificatePurposeTypes() {
    final $url = '/certificate/purposesTypes';
    return client.get($url);
  }

  static Future<Response<dynamic>> getInfoAboutCertificate(int id) {
    final $url = '/certificate/$id';
    return client.get($url);
  }

  static Future<Response<dynamic>> getMyCertificates(int student) {
    final $url = '/certificate/student/$student';
    return client.get($url);
  }

  static Future<Response<dynamic>> cancelCertificateById(int id) {
    final $url = '/certificate/$id';
    return client.delete($url);
  }

  static Future<Response<dynamic>> sendCertificate(
      int student, Certificate cert) {
    final $url = '/certificate/student/$student';
    return client.post($url, data: cert.toJson());
  }
}

class ZamgerAuthInterceptor extends Interceptor {
  static final String BEARER = 'Bearer ';
  static final String AUTH = 'Authorization';

  @override
  Future onRequest(RequestOptions options) async {
    ZamgerAPIService.client.lock();
    String accessToken = await Credentials.getAccessToken();
    ZamgerAPIService.client.unlock();
    options.headers[AUTH] = BEARER + accessToken;
    return options;
  }

  @override
  Future onError(DioError error) async {
    //ako je pokušaj pao jer je istekao token
    if (error.type == DioErrorType.RESPONSE &&
        error.response.statusCode == 401) {
      ZamgerAPIService.client.lock();
      if (!await Credentials.refreshTokens()) {
        ZamgerAPIService.client.unlock();
        navigator.currentState
            .pushNamedAndRemoveUntil("/login", (Route<dynamic> route) => false);
        return error;
      }
      ZamgerAPIService.client.unlock();
      return _retryWithToken(error.request);
      //ako je ponovni pokušaj opet pao, morat će se redirectati na LoginPage
    } else {
      return error;
    }
  }

  Future<Response> _retryWithToken(RequestOptions originalRequest) async {
    originalRequest.headers[AUTH] = BEARER + await Credentials.getAccessToken();
    print("TOKEN JE REFRESHOVAN");
    return ZamgerAPIService.client
        .request(originalRequest.path, options: originalRequest);
  }
}
