import 'package:database_with_flutter/db_provider.dart';
import 'package:database_with_flutter/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/local/db_helper.dart';

class AddNotePage extends StatelessWidget
{
 bool isUpdate;
String title;
String desc;
int sno;
 TextEditingController titleController = TextEditingController();
 TextEditingController descController = TextEditingController();
 //DBHelper? dbRef= DBHelper.getInstance; //initializing the database
 AddNotePage({ this.isUpdate=false, this.sno=0, this.title="", this.desc=""});// this will bring value
 @override
  Widget build(BuildContext context){
   if(isUpdate==true){
     titleController.text=title;
     descController.text= desc;
   }
  return Scaffold(
    appBar: AppBar(title:  Text(isUpdate ? 'Update Note':'Add Note', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, ), ),
    ),
    body:  Container(

        height: MediaQuery.of(context).size.height*0.5+ MediaQuery.of(context).viewInsets.bottom,
        width: double.infinity,
        padding: EdgeInsets.only(top: 11, bottom: 11+ MediaQuery.of(context).viewInsets.bottom, left: 11, right: 11),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 25,
            ),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                  hintText: "Enter title here",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  )
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: descController,
              decoration: InputDecoration(
                  hintMaxLines: 4,
                  hintText: "Enter your Description",
                  label: Text('Desrciption'),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  )
              ),
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 80, 151, 210),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(width: 4),
                            borderRadius: BorderRadius.all(Radius.circular(15.0))
                        )),
                    onPressed: () async {
                      var title = titleController.text;
                      var desc = descController.text;
                      if(title.isNotEmpty && desc.isNotEmpty)
                      {
                        if(isUpdate){
                          context.read<DBProvider>().updateNote(title, desc, sno);
                        }
                        else
                          {
                            context.read<DBProvider>().addNote(title, desc);
                          }
                        Navigator.pop(context);
                        //bool check = await dbRef!.addNote(mTitle: title, mDesc: desc);
                        // bool check = isUpdate
                        //     ? await dbRef!.updateNote(mTitle: title, mDesc: desc, sno: sno)
                        //     : await dbRef!.addNote(mTitle: title, mDesc: desc);
                        // if(check)
                        // {
                        // Navigator.pop(context);
                        // }

                      } else
                      {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill all the blanks")));
                        // errorMsg="Please fill the required details";
                      }
                      titleController.clear();
                      descController.clear();

                    }, child: Text(isUpdate ? 'Update Note' : 'Add Notes',  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),))),

                const SizedBox(width: 10,),

                Expanded(child: OutlinedButton(
                    style: OutlinedButton.styleFrom(backgroundColor: Color.fromARGB(
                        255, 80, 151, 210),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(15)),
                            side: BorderSide(
                                width: 4,
                                color: Colors.black
                            )
                        )
                    ),
                    onPressed: (){
                      Navigator.pop(context); // when cancel is pressed bottom sheet will be closed
                    }, child: Text('Cancel', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),))),

              ],
            )

          ],
        ),
    ),

  );
}

}