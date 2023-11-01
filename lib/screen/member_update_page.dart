import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:test_db_flutter/model/user_model.dart';


final dio = Dio();
class MemberUpdatePage extends StatelessWidget {
  const MemberUpdatePage({super.key, required this.users});
  final UserModel users;


  @override
  Widget build(BuildContext context) {
    TextEditingController input_id = TextEditingController(text: users.memberId); // controller이용해서 값 고정
    TextEditingController input_pw = TextEditingController();
    TextEditingController input_age = TextEditingController();
    TextEditingController input_name = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('회원수정 페이지'),
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
              readOnly: true,
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

            selectId(users.memberId, input_pw.text, int.parse(input_age.text), input_name.text, context);

          }, child: Text('회원 수정'))
        ],
      ),
    );
  }
}

void selectId(id,pw,age, name, context) async{

  //본인 url 작성
  String url = '';
  Response res = await dio.get(
      url,
      queryParameters: {'id' :id,
        'pw' :pw,
        'age' : age,
        'name' : name
      }
  );


  print(res.realUri);
  if(res.statusCode ==200){
    print(res);
    if(res.toString() == 'success'){
      Navigator.pop(context);
    }
  }

}