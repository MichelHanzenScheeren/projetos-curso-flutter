String usernameValidate(String text) {
  if (text.isEmpty) {
    return "Preenchimento obrigatório!";
  } else if (text.length < 6 || text.length > 15) {
    return "Seu username precisa ter entre 6 e 15 caracters";
  } else if (text.contains(" ")){
    return "O username não pode conter espaços em branco!";
  } else {
    return null;
  }
}