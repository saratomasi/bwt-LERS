import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:project/models/distance.dart';
import 'package:project/models/resting_hr.dart';
import 'package:project/models/steps.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:project/models/heartrate.dart';

class Impact {
  static String baseUrl = 'https://impact.dei.unipd.it/bwthw/';
  static String pingEndpoint = 'gate/v1/ping/';
  static String tokenEndpoint = 'gate/v1/token/';
  static String refreshEndpoint = 'gate/v1/refresh/';

  static String username = '2VM2HKMb35';
  static String password = '12345678!';
  static String patientUsername = 'Jpefaq6m58';

  //This method allows to check if the IMPACT backend is up
  Future<bool> isImpactUp() async {
    //Create the request
    final url = Impact.baseUrl + Impact.pingEndpoint;

    //Get the response
    print('Calling: $url');
    final response = await http.get(Uri.parse(url));

    //Just return if the status code is OK
    return response.statusCode == 200;
  } //_isImpactUp

  //This method allows to obtain the JWT token pair from IMPACT and store it in SharedPreferences
  Future<int> getAndStoreTokens(String username, String password) async {
    //Create the request
    final url = Impact.baseUrl + Impact.tokenEndpoint;
    final body = {'username': username, 'password': password};

    //Get the response
    print('Calling: $url');
    final response = await http.post(Uri.parse(url), body: body);

    //If response is OK, decode it and store the tokens. Otherwise do nothing.
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      final sp = await SharedPreferences.getInstance();
      await sp.setString('access', decodedResponse['access']);
      await sp.setString('refresh', decodedResponse['refresh']);
    } //if

    //Just return the status code
    return response.statusCode;
  } //_getAndStoreTokens

  //This method allows to refrsh the stored JWT in SharedPreferences
  Future<int> refreshTokens() async {
    //Create the request
    final url = Impact.baseUrl + Impact.refreshEndpoint;
    final sp = await SharedPreferences.getInstance();
    final refresh = sp.getString('refresh');
    if (refresh != null) {
      final body = {'refresh': refresh};

      //Get the response
      print('Calling: $url');
      final response = await http.post(Uri.parse(url), body: body);

      //If the response is OK, set the tokens in SharedPreferences to the new values
      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        final sp = await SharedPreferences.getInstance();
        await sp.setString('access', decodedResponse['access']);
        await sp.setString('refresh', decodedResponse['refresh']);
      } //if

      //Just return the status code
      return response.statusCode;
    }
    return 401;
  } //_refreshTokens

  //This method checks if the saved token is still valid
  Future<bool> checkSavedToken({bool refresh = false}) async {
    final sp = await SharedPreferences.getInstance();
    final token = sp.getString(refresh ? 'refresh' : 'access');

    //Check if there is a token
    if (token == null) {
      return false;
    }
    try {
      return Impact.checkToken(token);
    } catch (_) {
      return false;
    }
  }

  static bool checkToken(String token) {
    //Check if the token is expired
    if (JwtDecoder.isExpired(token)) {
      return false;
    }
    return true;
  } //checkToken

  //This method prepares the Bearer header for the calls
  Future<Map<String, String>> getBearer() async {
    if (!await checkSavedToken()) {
      await refreshTokens();
    }
    final sp = await SharedPreferences.getInstance();
    final token = sp.getString('access');

    return {'Authorization': 'Bearer $token'};
  }

  Future<void> getPatient() async {
    var header = await getBearer();
    final r = await http.get(
        Uri.parse('${Impact.baseUrl}study/v1/patients/active'),
        headers: header);

    final decodedResponse = jsonDecode(r.body);
    final sp = await SharedPreferences.getInstance();

    sp.setString('impactPatient', decodedResponse['data'][0]['username']);
  }

  Future<List<HR>> getHeartRate(DateTime startTime) async {
    //final sp = await SharedPreferences.getInstance();
    //String? user = sp.getString('impactPatient');
    var header = await getBearer();
    var end = DateFormat('y-M-d').format(startTime);
    var start =
        DateFormat('y-M-d').format(startTime.subtract(const Duration(days: 3)));
    var r = await http.get(
      //Uri.parse(
      //    '${Impact.baseUrl}data/v1/heart_rate/patients/$user/daterange/start_date/$start/end_date/$end/'),
      Uri.parse('https://impact.dei.unipd.it/bwthw/data/v1/heart_rate/patients/$patientUsername/daterange/start_date/$start/end_date/$end/'),
      headers: header,
    );
    if (r.statusCode != 200) return [];

    List<dynamic> data = jsonDecode(r.body)['data'];
    List<HR> hr = [];
    for (var daydata in data) {
      String day = daydata['date'];
      for (var dataday in daydata['data']) {
        String hour = dataday['time'];
        String datetime = '${day}T$hour';
        DateTime timestamp = _truncateSeconds(DateTime.parse(datetime));
        HR hrnew = HR(timestamp: timestamp, value: dataday['value']);
        if (!hr.any((e) => e.timestamp.isAtSameMomentAs(hrnew.timestamp))) {
          hr.add(hrnew);
        }
      }
    }
    var hrlist = hr.toList()
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));
    return hrlist;
  }

    Future<List<RHR>> getRestingHeartRate(DateTime startTime) async {
    //final sp = await SharedPreferences.getInstance();
    //String? user = sp.getString('impactPatient');
    var header = await getBearer();
    var end = DateFormat('y-M-d').format(startTime);
    var start =
        DateFormat('y-M-d').format(startTime.subtract(const Duration(days: 3)));
    var r = await http.get(
      //Uri.parse(
      //    '${Impact.baseUrl}data/v1/heart_rate/patients/$user/daterange/start_date/$start/end_date/$end/'),
      Uri.parse('https://impact.dei.unipd.it/bwthw/data/v1/resting_heart_rate/patients/$patientUsername/daterange/start_date/$start/end_date/$end/'),
      headers: header,
    );
    if (r.statusCode != 200) return [];

    List<dynamic> data = jsonDecode(r.body)['data'];
    List<RHR> rhr = [];
    for (var daydata in data) {
      String day = daydata['date'];
      Map<String,dynamic> dataday = daydata['data'] ; 
       String hour = dataday['time'];
        String datetime = '${day}T$hour';
         DateTime timestamp = _truncateSeconds(DateTime.parse(datetime));
           RHR rhrnew = RHR(timestamp: timestamp,value: dataday['value']);
           rhr.add(rhrnew) ;
         //if (!rhr.any((e) => e.timestamp.isAtSameMomentAs(rhrnew.timestamp))) {
         //  rhr.add(rhrnew);
        
         //}
       //}
     }
     var rhrlist = rhr.toList()
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));
     return rhrlist;
  }

  Future<List<Steps>> getSteps(DateTime startTime) async {
    //final sp = await SharedPreferences.getInstance();
    //String? user = sp.getString('impactPatient');
    var header = await getBearer();
    var end = DateFormat('y-M-d').format(startTime);
    var start =
        DateFormat('y-M-d').format(startTime.subtract(const Duration(days: 3)));
    var r = await http.get(
      //Uri.parse(
      //    '${Impact.baseUrl}data/v1/heart_rate/patients/$user/daterange/start_date/$start/end_date/$end/'),
      Uri.parse('https://impact.dei.unipd.it/bwthw/data/v1/steps/patients/$patientUsername/daterange/start_date/$start/end_date/$end/'),
      headers: header,
    );
    if (r.statusCode != 200) return [];

    List<dynamic> data = jsonDecode(r.body)['data'];
    List<Steps> steps = [];
    for (var daydata in data) {
      String day = daydata['date'];
      int  sum = 0 ;
      for (var dataday in daydata['data']) {
        //String hour = dataday['time'];
        //String datetime = '${day}T$hour';
        //DateTime timestamp = _truncateSeconds(DateTime.parse(datetime));
        String ans = dataday['value'].toString();
        sum = sum +int.parse(ans) ;
        // if (!steps.any((e) => e.timestamp.isAtSameMomentAs(stepsnew.timestamp))) {
        //   steps.add(stepsnew);
        // }
      }
    Steps stepsnew = Steps(timestamp: DateTime.parse(day), value: sum);
    steps.add(stepsnew) ;
    }
    var stepslist = steps.toList()
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));
    return stepslist;
  }

    Future<List<Distance>> getDistance(DateTime startTime) async {
    //final sp = await SharedPreferences.getInstance();
    //String? user = sp.getString('impactPatient');
    var header = await getBearer();
    var end = DateFormat('y-M-d').format(startTime);
    var start =
        DateFormat('y-M-d').format(startTime.subtract(const Duration(days: 3)));
    var r = await http.get(
      //Uri.parse(
      //    '${Impact.baseUrl}data/v1/heart_rate/patients/$user/daterange/start_date/$start/end_date/$end/'),
      Uri.parse('https://impact.dei.unipd.it/bwthw/data/v1/distance/patients/$patientUsername/daterange/start_date/$start/end_date/$end/'),
      headers: header,
    );
    if (r.statusCode != 200) return [];

    List<dynamic> data = jsonDecode(r.body)['data'];
    List<Distance> distance = [];
    for (var daydata in data) {
      String day = daydata['date'];
      int  sum = 0 ;
      for (var dataday in daydata['data']) {
        String ans = dataday['value'].toString();
        sum = sum +int.parse(ans) ;
       // String hour = dataday['time'];
       // String datetime = '${day}T$hour';
       // DateTime timestamp = _truncateSeconds(DateTime.parse(datetime));
       // Distance distancenew = Distance(timestamp: timestamp, value: dataday['value']);
       // if (!distance.any((e) => e.timestamp.isAtSameMomentAs(distancenew.timestamp))) {
       //   distance.add(distancenew);
        }
        Distance distancenew = Distance(timestamp: DateTime.parse(day), value: sum);
        distance.add(distancenew) ;
      }
      var distancelist = distance.toList()
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));
     return distancelist;
    }

  DateTime _truncateSeconds(DateTime input) {
    return DateTime(
        input.year, input.month, input.day, input.hour, input.minute);
  }

}//Impact