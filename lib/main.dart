import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_db_flutter/screen/join_page.dart';
import 'package:test_db_flutter/screen/login_page.dart';
import 'package:test_db_flutter/screen/login_success_page.dart';

final dio = Dio();
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ExGetPage(),
    );
  }
}




//하단 내용들은 간단 예제 내용들 입니다.
//실제 로그인 기능과는 무관합니다.


class ExGetPage extends StatefulWidget {
  const ExGetPage({super.key});

  @override
  State<ExGetPage> createState() => _ExGetPageState();
}

class _ExGetPageState extends State<ExGetPage> {

String str = '';
TextEditingController test_tec = TextEditingController();
  Widget makeWidget(String data){

    return Container(
      width: 200,
        height: 200,
        color: Colors.red,
        child: Text(data, style: TextStyle(color: Colors.red),));
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: [
                FutureBuilder(
                  future: getDataDio(),
                  builder: (context, snapshot) {
                    return Column(
                      children: [
                        TextField(
                          controller: test_tec,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              selectId(test_tec.text);
                              setState(() {

                                str = snapshot.data.toString();
                              });
                              // print(snapshot.data);
                              // Future<String> data = getData();
                              // print(data);
                            },
                            child: Text('데이터 받기')),
                      ],
                    );
                  }
                ),
                Text(str)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//전송하는 메소드들
void selectId(id) async{
  print(id);
  //본인 url 작성
  String url = '';
  Response res = await dio.get(
      url,
      queryParameters: {'id' :id}
  );
  print(res.statusCode);
}

// dio 라이브러리 get방식 통신 방법
Future<Response> getDataDio() async{

  final urlPath = '';

  var res = await dio.get(urlPath);
  print(res);
  print(res.statusCode);
  return res;
}

Future<String> getData() async {
  final urlPath = '';

  http.Response res = await http.get(Uri.parse(urlPath));

  if (res.statusCode == 200) {
    return res.body;
  } else {
    return '';
  }
}
