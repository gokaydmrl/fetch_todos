import 'dart:convert';

void main() {
  const jsonArray = '''
  [{"text": "foo", "value": 1, "status": true},
   {"text": "bar", "value": 2, "status": false}]
''';
  final List<dynamic> dynamicList = jsonDecode(jsonArray);
  print(" this is dynamic list $dynamicList  ,, ${dynamicList.runtimeType} ");

  final List<Map<String, dynamic>> fooData =
      List.from(dynamicList.where((x) => x is Map && x['text'] == 'foo'));
  print(fooData.runtimeType);
}
