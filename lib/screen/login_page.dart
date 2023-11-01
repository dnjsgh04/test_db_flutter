import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test_db_flutter/model/user_model.dart';
import 'package:test_db_flutter/screen/join_page.dart';
import 'package:dio/dio.dart';
import 'package:test_db_flutter/screen/login_success_page.dart';

final dio = Dio();
class ExLoginPage extends StatefulWidget {
  const ExLoginPage({super.key});

  @override
  State<ExLoginPage> createState() => _ExLoginPageState();
}

class _ExLoginPageState extends State<ExLoginPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 비동기로 flutter secure storage 정보를 불러오는 작업
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _readLoginInfo();
    });


  }

  TextEditingController emailCon = TextEditingController();
  TextEditingController pwCon = TextEditingController();

  static final storage = FlutterSecureStorage(); // FlutterSecureStorage를 storage로 저장
  dynamic userInfo = ''; // storage에 있는 유저 정보를 저장

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('로그인 페이지'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(12),
            padding: EdgeInsets.all(12),
            child: Column(
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
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                      decoration: InputDecoration(
                        label: Row(
                          children: [
                            Icon(Icons.key),
                            Text("pw 입력 "),
                          ],
                        ),
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent),
                        onPressed: () {
                          //emailCon.text
                          //pwCon.text
                          selectId('test', '12345',context);
                        },
                        child: Text('로그인하기')),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>JoinPage()));
                        },
                        child: Text('회원가입하기'))
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  color: Colors.grey[200],
                  width: double.infinity,
                  height: 2,
                ),
                SizedBox(
                  height: 40,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  _readLoginInfo() async {
    // read 함수로 key값에 맞는 정보를 불러오고 데이터타입은 String 타입
    // 데이터가 없을때는 null을 반환
    userInfo = await storage.read(key:'login');
    var user = userModelFromJson(userInfo);
    // user의 정보가 있다면 로그인 후 들어가는 첫 페이지로 넘어가게 합니다.
    if (userInfo != null) {
      Navigator.push(context, MaterialPageRoute(builder: (_)=> LoginSuccessPage(users: user[0],)));
    } else {
      print('로그인이 필요합니다');
    }
  }

  void selectId(id,pw, context) async{

    //본인 url 작성
    String url = '';
    Response res = await dio.get(
        url,
        queryParameters: {'id' :id,
          'pw' :pw,
        }

    );
    print(res.realUri); // 쿼리문까지 적용된 주소 출력해보기

   // Map<String, dynamic> d_data = jsonDecode(res.data)[0];
    // List<UserModel> user = (res.data).map<UserModel>((json){
    //   return UserModel.fromJson(json);
    // }).toList();


    try{
      var user = userModelFromJson(res.data);
      print(user[0]);
      await storage.write(key: 'login', value: res.data);
      //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> LoginSuccessPage()), (route) => false);
      Navigator.push(context, MaterialPageRoute(builder: (_)=> LoginSuccessPage(users: user[0],)));
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('로그인 정보가 잘못 되었습니다.'))
      );
    //  print(e);

    }



   // print(d_data['member_id']);



  }
}


