// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zamger_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$ZamgerAPIService extends ZamgerAPIService {
  _$ZamgerAPIService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ZamgerAPIService;

  @override
  Future<Response<dynamic>> currentPerson() {
    final $url = '/person';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getPersonById(int id) {
    final $url = '/person/$id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> findPersonBySearch(String name) {
    final $url = '/person/search';
    final $params = <String, dynamic>{'query': name};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getExtendedPersonById(int id) {
    final $url = '/extendedPerson/$id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getRecentRecievedMessages(int limit) {
    final $url = '/inbox';
    final $params = <String, dynamic>{'messages': limit};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getRecentSentMessages(int limit) {
    final $url = '/inbox/outbox';
    final $params = <String, dynamic>{'messages': limit};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getCountOfMessagesInInbox() {
    final $url = 'inbox/count';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getUnreadMessages() {
    final $url = 'inbox/unread';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getMessageById(int messageId) {
    final $url = 'inbox/$messageId';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getInboxAnnouncements(int limit) {
    final $url = 'inbox/announcements';
    final $params = <String, dynamic>{'messages': limit};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getMyCurrentCourses(int id) {
    final $url =
        '/course/student/$id&resolve[]=CourseOffering&resolve[]=CourseUnit';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getCourseDetailsForStudent(
      int course, int student) {
    final $url = 'course/$course/student/$student';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getLatestGradesForStudent(int student, int limit) {
    final $url =
        'course/latestGrades/$student&resolve[]=CourseOffering&resolve[]=CourseUnit';
    final $params = <String, dynamic>{'limit': limit};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getAttendanceOnCourse(
      int course, int student, int year) {
    final $url =
        'class/course/$course/student/$student&resolve[]=ZClass&resolve[]=Person';
    final $params = <String, dynamic>{'year': year};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getLatestExamResults(int student, int limit) {
    final $url = 'exam/latest/$student';
    final $params = <String, dynamic>{'limit': limit};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getUpcomingHomeworkDeadlines(int student) {
    final $url = 'homework/latest/$student';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getFileByHomeworkId(
      int homeworkId, int asgn, int student) {
    final $url = 'homework/$homeworkId/$asgn/student/$student/file';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getStatusOfSubmittedHomeworkById(
      int homeworkId, int asgn, int student) {
    final $url = 'homework/$homeworkId/$asgn/student/$student';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getStatusesOfHomeworksOnCourse(
      int course, int student) {
    final $url = 'homework/course/$course/student/$student';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getUpcomingEvents(int student) {
    final $url = 'event/upcoming/$student';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getRegisteredEvents(int student) {
    final $url = 'event/registered/$student';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getInfoAboutMyProgrammeAndSemester(int student) {
    final $url = 'enrollment/current/$student';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getInfoAboutAllSemestersOfStudent(int student) {
    final $url = 'enrollment/all/$student';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
