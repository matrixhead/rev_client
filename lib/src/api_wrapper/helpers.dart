import 'dart:convert';

Map<String,dynamic> parseJsonToMap(String json){
  return jsonDecode(json) as Map<String,dynamic>; 
}

List<dynamic> parseJsonToList(String json){
  return jsonDecode(json) as List<dynamic>;
}
