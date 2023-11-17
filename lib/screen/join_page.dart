import 'package:flutter/material.dart';
import 'package:dio/dio.dart';


final dio = Dio();
//그대로 카피해도 무관 (selectId 메소드만 생략)
class JoinPage extends StatelessWidget {
  const JoinPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController input_id = TextEditingController();
    TextEditingController input_pw = TextEditingController();
    TextEditingController input_age = TextEditingController();
    TextEditingController input_name = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입 페이지'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  label: Row(
                    children: [
                      Icon(Icons.account_circle),
                      Text("email 입력 "),
                    ],
                  ),
                  hintText: "example@example.com",
                  hintStyle: TextStyle(color: Colors.grey[300])),
              keyboardType: TextInputType.emailAddress,
              controller: input_id,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  label: Row(
                    children: [
                      Icon(Icons.key),
                      Text("비밀번호 입력 "),
                    ],
                  ),

              ),
              keyboardType: TextInputType.text,
              obscureText: true,
              controller: input_pw,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  label: Text("나이 입력 "),
                  hintText: "20",
                  hintStyle: TextStyle(color: Colors.grey[300])),
              keyboardType: TextInputType.number,
              controller: input_age,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  label: Text("이름 입력 "),
                  hintText: "플러터",
                  hintStyle: TextStyle(color: Colors.grey[300])),
              keyboardType: TextInputType.text,
              controller: input_name,
            ),
          ),
          
          ElevatedButton(onPressed: (){

            joinMember(input_id.text, input_pw.text, input_age.text, input_name.text, context);

          }, child: Text('회원 가입'))
         ],
      ),
    );
  }
}

void joinMember(id,pw,age, name, context) async{

  //본인 url 작성
  String url = 'http://172.30.1.46:8080/member/joinUser';

  Response res = await dio.get(
      url,
      queryParameters: {'id' :id,
      'pw' :pw,
        'age' : age,
        'name' : name
      }
  );

  print(res);
  // if(res.statusCode ==200){
  //   print(res);
  //   if(res.toString() == 'success'){
  //     Navigator.pop(context);
  //   }
  // }

}

