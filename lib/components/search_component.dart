class SearchComponent {
  static dynamic search(
    var data,
    String search, [
    search_based_on = "firstName",
  ]) {
    var data_final = [];

    if (search_based_on == "firstName") {
      data = data.where((searching) {
        if (searching.firstName.toLowerCase().contains(search) ||
            searching.firstName.toUpperCase().contains(search)) {
          data_final.add(searching);
          return true;
        } else {
          return false;
        }
      }).toList();
    }
    if (search_based_on == "lastName") {
      data = data.where((searching) {
        if (searching.lastName.toLowerCase().contains(search) ||
            searching.lastName.toUpperCase().contains(search)) {
          data_final.add(searching);
          return true;
        } else {
          return false;
        }
      }).toList();
    }
    if (search_based_on == "companyCode") {
      data = data.where((searching) {
        if (searching.companyCode.toLowerCase().contains(search) ||
            searching.companyCode.toUpperCase().contains(search)) {
          data_final.add(searching);
          return true;
        } else {
          return false;
        }
      }).toList();
    }
    if (search == '') {
      return data;
    }
    return data_final;
  }
}


class Search {
  static dynamic search(var list, String s, [search_based_on = "user"]) {
    var list2 = [];

    if (search_based_on == "firstName_lastName_companyCode") {
      list = list.where((e) {
        if (e.firstName.contains(s) ||
            e.lastName.contains(s) ||
            e.companyCode.contains(s) ) {
          print("1");
          list2.add(e);
          return true;
        } else {
          print("1");
          return false;
        }
      }).toList();
    } 
    // else if (search_based_on ==
    //     "task_and_nazer_and_masool_and_tarifkonandaTask") {
    //   list2 = [];
    //   print('x');
    //   for (var i = 0; i < list.length; i++) {
    //     var roles = list[i].roles;
    //     var title = list[i].title;
    //     var status = list[i].status;
    //     for (var j = 0; j < roles.length; j++) {
    //       var x = roles[j].user;
    //       if ((x.contains(s) && s != "") ||
    //           title.contains(s) ||
    //           status.title.contains(s)) {
    //         list2.add(list[i]);
    //         break;
    //       }
    //     }
    //   }
    // }
    if (s == '') {
      return list;
    }
    return list2;
  }
}
