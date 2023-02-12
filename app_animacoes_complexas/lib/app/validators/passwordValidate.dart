String passwordValidate(String password) {
  bool hasUppercase = false;
  bool hasDigits = false;
  bool hasLower = false;
  var character = '';
  var i = 0;

  if (password.isEmpty) return "Preenchimento obrigatório!";
  if(password.length < 8 || password.length > 30)
    return "Sua senha precisa ter entre 8 e 30 caracteres";
  if (!password.contains(RegExp(r'[!_+;@#$%^&*(),.?:{}|<>]')))
    return ("Sua senha precisa ter pelo menos um caractere especial ([!@#\$%^&*(),.?:{}|<>])");

  while (i < password.length) {
    character = password.substring(i, i + 1);
    if(character == " ") return "Sua senha não pode conter espaços em branco!";
    if (isDigit(character, 0)) {
      hasDigits = true;
    } else if(!("[!_+;@#\$%^&*(),.?:{}|<>]".contains(character))) {
      if (character == character.toUpperCase()) hasUppercase = true;
      if (character == character.toLowerCase()) hasLower = true;
    }
    i++;
  }
  if(!hasDigits) return "Sua senha precisa ter pelo menos um número...";
  if(!hasUppercase) return "Sua senha deve ter pelo menos uma letra maiúscula...";
  if(!hasLower) return "Sua senha precisa ter pelo menos uma letra minúscula...";
  return null;
}

bool isDigit(String s, int idx) =>
    "0".compareTo(s[idx]) <= 0 && "9".compareTo(s[idx]) >= 0;
