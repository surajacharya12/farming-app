import 'package:http/http.dart' as http;
import 'dart:convert';

String apiKey = "49650ecce0014e309da160454250705";

class WeatherApi {
  final String baseUrl = "http://api.weatherapi.com/v1/current.json";

  Future<ApiResponse> getCurrentWeather(String location) async {
    final url = "$baseUrl?key=$apiKey&q=$location";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return ApiResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load weather data: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to load weather: $e');
    }
  }
}

class ApiResponse {
  Location? location;
  Current? current;

  ApiResponse({this.location, this.current});

  ApiResponse.fromJson(Map<String, dynamic> json) {
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    current =
        json['current'] != null ? Current.fromJson(json['current']) : null;
  }

  Map<String, dynamic> toJson() => {
    'location': location?.toJson(),
    'current': current?.toJson(),
  };
}

class Location {
  String? name;
  String? country;
  String? localtime;

  Location({this.name, this.country, this.localtime});

  Location.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    country = json['country'];
    localtime = json['localtime'];
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'country': country,
    'localtime': localtime,
  };
}

class Current {
  double? tempC;
  Condition? condition;

  Current({this.tempC, this.condition});

  Current.fromJson(Map<String, dynamic> json) {
    tempC = (json['temp_c'] as num?)?.toDouble();
    condition =
        json['condition'] != null
            ? Condition.fromJson(json['condition'])
            : null;
  }

  Map<String, dynamic> toJson() => {
    'temp_c': tempC,
    'condition': condition?.toJson(),
  };
}

class Condition {
  String? text;
  String? icon;

  Condition({this.text, this.icon});

  Condition.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() => {'text': text, 'icon': icon};
}
