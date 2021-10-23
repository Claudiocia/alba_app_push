import 'package:alba_app/helpers/usuario_helper.dart';
import 'package:alba_app/models/usuario_model.dart';

class BuscaUser {
  BuscaUser();

  UsuarioModel user = UsuarioModel();
  UsuarioHelper helper = UsuarioHelper();
  bool isLoading = false;

  // ignore: missing_return
  Future<UsuarioModel> userExist() async{
    isLoading = true;

    await helper.getUser().then((value){
      if(value != null){
        user = value;

        return user;
      }else{

        return null;
      }
    });
  }


}