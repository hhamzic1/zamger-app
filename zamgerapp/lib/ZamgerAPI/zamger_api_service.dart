import 'package:chopper/chopper.dart';
part 'zamger_api_service.chopper.dart';

@ChopperApi()
abstract class ZamgerAPIService extends ChopperService {
  //ovdje se sada pišu metode za čitav zamger api

  //PERSON
  @Get(path: '/person')
  Future<Response> currentPerson();

  @Get(path: '/person/{id}')
  Future<Response> getPersonById(@Path('id') int id);

  @Get(path: '/person/search')
  Future<Response> findPersonBySearch(@Query('query') String name);

  @Get(path: '/extendedPerson/{id}')
  Future<Response> getExtendedPersonById(@Path('id') int id);

  //INBOX/OUTBOX
  @Get(path: '/inbox')
  Future<Response> getRecentRecievedMessages(@Query('messages') int limit);

  @Get(path: '/inbox/outbox')
  Future<Response> getRecentSentMessages(@Query('messages') int limit);

  @Get(path: 'inbox/count')
  Future<Response> getCountOfMessagesInInbox();

  @Get(path: 'inbox/unread')
  Future<Response> getUnreadMessages();

  @Get(path: 'inbox/{id}')
  Future<Response> getMessageById(@Path('id') int messageId);

  @Get(path: 'inbox/announcements')
  Future<Response> getInboxAnnouncements(@Query('messages') int limit);

  //POST metoda za slanje poruke!

  //COURSE

  @Get(
      path:
          '/course/student/{id}&resolve[]=CourseOffering&resolve[]=CourseUnit')
  Future<Response> getMyCurrentCourses(@Path('id') int id);

  @Get(path: 'course/{course}/student/{student}')
  Future<Response> getCourseDetailsForStudent(
      @Path('course') int course, @Path('student') int student);

  @Get(
      path:
          'course/latestGrades/{student}&resolve[]=CourseOffering&resolve[]=CourseUnit')
  Future<Response> getLatestGradesForStudent(
      @Path('student') int student, @Query('limit') int limit);

  @Get(
      path:
          'class/course/{course}/student/{student}&resolve[]=ZClass&resolve[]=Person')
  Future<Response> getAttendanceOnCourse(@Path('course') int course,
      @Path('student') int student, @Query('year') int year);

  //EXAM
  @Get(path: 'exam/latest/{student}')
  Future<Response> getLatestExamResults(
      @Path('student') int student, @Query('limit') int limit);

  // metodu prijave na ispit testirati - kao i odjave sa istog

  //HOMEWORK
  @Get(path: 'homework/latest/{student}')
  Future<Response> getUpcomingHomeworkDeadlines(@Path('student') int student);

  @Get(
      path:
          'homework/{id}/{asgn}/student/{student}/file') //provjeriti sta ovo asgn znači -- skidanje poslanog fajla po id-u zadaće
  Future<Response> getFileByHomeworkId(@Path('id') int homeworkId,
      @Path('asgn') int asgn, @Path('student') int student);

  @Get(path: 'homework/{id}/{asgn}/student/{student}') //status poslanih zadaća
  Future<Response> getStatusOfSubmittedHomeworkById(@Path('id') int homeworkId,
      @Path('asgn') int asgn, @Path('student') int student);

  @Get(
      path:
          'homework/course/{course}/student/{student}') //status svih zadaća na kursu
  Future<Response> getStatusesOfHomeworksOnCourse(
      @Path('course') int course, @Path('student') int student);

  //POST metodu zadaće istestirati

  //EVENT
  @Get(path: 'event/upcoming/{student}')
  Future<Response> getUpcomingEvents(@Path('student') int student);

  @Get(path: 'event/registered/{student}')
  Future<Response> getRegisteredEvents(@Path('student') int student);

  /*


      Certifikati -- za uraditi

      Slanje zahtjeva za potvrdu, provjera statusa potvrde, poništavanje zahtjeva za potvrdu itd...



  */

  //ENROLLMENT
  @Get(path: 'enrollment/current/{student}')
  Future<Response> getInfoAboutMyProgrammeAndSemester(
      @Path('student') int student);

  @Get(path: 'enrollment/all/{student}')
  Future<Response> getInfoAboutAllSemestersOfStudent(
      @Path('student') int student);

  //zamger api client

  static ZamgerAPIService create() {
    final client = ChopperClient(
        baseUrl: 'https://zamger.etf.unsa.ba/api_v6',
        services: [
          _$ZamgerAPIService(),
        ],
        converter: JsonConverter());
    return _$ZamgerAPIService(client);
  }
}
