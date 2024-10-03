
import 'package:database_with_flutter/data/local/db_helper.dart';
import 'package:database_with_flutter/db_provider.dart';
import 'package:database_with_flutter/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_note_page.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
// List<Map<String, dynamic>> allNotes=[]; // blank list to get all the notes
  // DBHelper? dbRef; //dbRef: A reference to the database helper instance for performing database operations
  @override
  void initState() {
    super.initState();
    context.read<DBProvider>().getInitialNotes();
    // dbRef=  DBHelper.getInstance; //It initializes the dbRef with a singleton instance of DBHelper
    // getNotes(); // to fetch existing notes from the database
  }

  // to get the notes using function because many times it will be required to get the notes
  //  void getNotes() async{ //An asynchronous method that retrieves all notes using dbRef and updates allNotes.
  //    allNotes = await  dbRef!.getAllNotes();
  //    setState(() { //After fetching notes, it calls setState() to rebuild the UI with the new data.
  //    });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes', style: TextStyle(fontWeight: FontWeight.bold),),
      actions: [
        PopupMenuButton(itemBuilder: (_){
          return [
            PopupMenuItem(child: Row(
              children: [
                Icon(Icons.mode_night_outlined),
                SizedBox(width: 11,),
                Text("Settings")
              ],
            ),
              onTap:(){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Settings(),));
    },)
          ];
        }
          
        )
      ],
      ),
      // all notes will be viewed
      body: Consumer<DBProvider>(builder: (ctx, provider, __) {
        List<Map<String, dynamic>> allNotes = provider.getNotes();
        return allNotes.isNotEmpty ? ListView.builder(
            itemCount: allNotes.length,
            itemBuilder: (_, index) {
              return ListTile(
                leading: Text('${index + 1}'),
                title: Text(allNotes[index][DBHelper.COLUMN_NOTE_TITLE]),
                subtitle: Text(allNotes[index][DBHelper.COLUMN_NOTE_DESC]),
                trailing: SizedBox(
                  width: 50,
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) =>
                                AddNotePage(isUpdate: true,
                                  title: allNotes[index][DBHelper
                                      .COLUMN_NOTE_TITLE],
                                  desc: allNotes[index][DBHelper
                                      .COLUMN_NOTE_DESC],
                                  sno: allNotes[index][DBHelper
                                      .COLUMN_NOTE_SNO],
                                ),));
                            //
                            //
                            //                  // showModalBottomSheet(context: context, builder:(context){ //context because it will be rebuild, it is a anonymous or high order function that is function inside function
                            //                  //   titleController.text= allNotes[index][DBHelper.COLUMN_NOTE_TITLE]; //.text is setter function, when function like .text is used before = then it is setter function and when its after it acts as getter function
                            //                  //   descController.text= allNotes[index][DBHelper.COLUMN_NOTE_DESC];
                            //                  //   return getBottomSheetWidget(isUpdate: true, sno: allNotes[index][DBHelper.COLUMN_NOTE_SNO]);
                            //                  // });
                          },
                          child: Icon(Icons.edit)),
                      InkWell(
                          onTap: () async {
                            final bool? confirmDelete = await showDialog<bool>(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Confirm Deletion"),
                                  content: Text("Are you sure you want to delete this note?"),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text("Cancel"),
                                      onPressed: () {
                                        Navigator.of(context).pop(false);
                                      },
                                    ),
                                    TextButton(
                                      child: Text("Delete"),
                                      onPressed: () {
                                        Navigator.of(context).pop(true);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );

                            if (confirmDelete == true) {
                              // Call the deleteNote method from DBProvider
                              context.read<DBProvider>().deleteNote(allNotes[index][DBHelper.COLUMN_NOTE_SNO]);
                            }
                          },
                          child: Icon(Icons.delete, color: Colors.red,))
                    ],
                  ),
                ),
              );
            }) : Center(
          child: Text('No Notes yet'),
        );
      }),


      floatingActionButton: FloatingActionButton(

          onPressed: () async {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddNotePage(),)
              //notes to be added here

              //user input of notes

              // showModalBottomSheet(context: context, builder:(context){ //context because it will be rebuild, it is a anonymous or high order function that is function inside function
              // titleController.clear();
              // descController.clear();
              // return getBottomSheetWidget();
            );

            //   bool check=await dbRef!.addNote(mTitle: 'Favourite Notes', mDesc: 'Alhamdulillah Learning Flutter by the will of Allah swt');
            // {
            //   if(check) {
            //     getNotes();
            //   }
            // }
          },
          child: Icon(Icons.add)),
    );
  }
}





// Widget getBottomSheetWidget({bool isUpdate = false, int sno =0}){
//     return
    //   Container(
    //
    //     height: MediaQuery.of(context).size.height*0.5+ MediaQuery.of(context).viewInsets.bottom,
    //     width: double.infinity,
    //     padding: EdgeInsets.only(top: 11, bottom: 11+ MediaQuery.of(context).viewInsets.bottom, left: 11, right: 11),
    //     child: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         Text(isUpdate ? 'Update Note':'Add Note', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, ), ),
    //         SizedBox(
    //           height: 25,
    //         ),
    //         TextField(
    //           controller: titleController,
    //           decoration: InputDecoration(
    //               hintText: "Enter title here",
    //               focusedBorder: OutlineInputBorder(
    //                 borderRadius: BorderRadius.circular(15),
    //               ),
    //               enabledBorder: OutlineInputBorder(
    //                 borderRadius: BorderRadius.circular(15),
    //               )
    //           ),
    //         ),
    //         SizedBox(
    //           height: 20,
    //         ),
    //         TextField(
    //           controller: descController,
    //           decoration: InputDecoration(
    //               hintMaxLines: 4,
    //               hintText: "Enter your Description",
    //               label: Text('Desrciption'),
    //               enabledBorder: OutlineInputBorder(
    //                 borderRadius: BorderRadius.circular(15),
    //               ),
    //               focusedBorder: OutlineInputBorder(
    //                 borderRadius: BorderRadius.circular(15),
    //               )
    //           ),
    //         ),
    //         SizedBox(height: 10,),
    //         Row(
    //           children: [
    //             Expanded(child: OutlinedButton(
    //                 style: OutlinedButton.styleFrom(
    //                     backgroundColor: Color.fromARGB(255, 80, 151, 210),
    //                     shape: RoundedRectangleBorder(
    //                         side: BorderSide(width: 4),
    //                         borderRadius: BorderRadius.all(Radius.circular(15.0))
    //                     )),
    //                 onPressed: () async {
    //                   var title = titleController.text;
    //                   var desc = descController.text;
    //                   if(title.isNotEmpty && desc.isNotEmpty)
    //                   {
    //                     //bool check = await dbRef!.addNote(mTitle: title, mDesc: desc);
    //                     bool check = isUpdate
    //                         ? await dbRef!.updateNote(mTitle: title, mDesc: desc, sno: sno)
    //                         : await dbRef!.addNote(mTitle: title, mDesc: desc);
    //                     if(check)
    //                     {
    //                       getNotes();
    //                     }
    //
    //                   } else
    //                   {
    //                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill all the blanks")));
    //                     // errorMsg="Please fill the required details";
    //                   }
    //                   titleController.clear();
    //                   descController.clear();
    //                   Navigator.pop(context);
    //                 }, child: Text(isUpdate ? 'Update Note' : 'Add Notes',  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),))),
    //
    //             const SizedBox(width: 10,),
    //
    //             Expanded(child: OutlinedButton(
    //                 style: OutlinedButton.styleFrom(backgroundColor: Color.fromARGB(
    //                     255, 80, 151, 210),
    //                     shape: RoundedRectangleBorder(
    //                         borderRadius: BorderRadius.all(
    //                             Radius.circular(15)),
    //                         side: BorderSide(
    //                             width: 4,
    //                             color: Colors.black
    //                         )
    //                     )
    //                 ),
    //                 onPressed: (){
    //                   Navigator.pop(context); // when cancel is pressed bottom sheet will be closed
    //                 }, child: Text('Cancel', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),))),
    //
    //           ],
    //         )
    //
    //       ],
    //     )
    // );





