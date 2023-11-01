import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test_db_flutter/model/user_model.dart';
import 'package:test_db_flutter/screen/join_page.dart';
import 'package:dio/dio.dart';
import 'package:test_db_flutter/screen/member_update_page.dart';

final dio = Dio();
class LoginSuccessPage extends StatefulWidget {
  const LoginSuccessPage({super.key, required this.users});


  final UserModel users;

  @override
  State<LoginSuccessPage> createState() => _LoginSuccessPageState();
}

class _LoginSuccessPageState extends State<LoginSuccessPage> {
  static final storage = FlutterSecureStorage();
  dynamic userInfo = '';

  logout() async {
    await storage.delete(key: 'login');
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.users.memberName} 님 환영합니다.'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(12),
            padding: EdgeInsets.all(12),
            child: Column(
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent),
                        onPressed: () {
                          //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => MemberUpdatePage()), (route) => false);
                          Navigator.push(context, MaterialPageRoute(builder: (_) => MemberUpdatePage(users:  widget.users,)));

                        },
                        child: Text('회원 수정하기')),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>JoinPage()));
                        },
                        child: Text('회원 탈퇴하기'))
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
                TextButton(onPressed: (){
                    logout();
                }, child: Text('로그아웃하기'))

              ],
            ),
          ),
        ),
      ),
    );
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
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('로그인 정보가 잘못 되었습니다.'))
      );
      //  print(e);

    }



    // print(d_data['member_id']);



  }
}
