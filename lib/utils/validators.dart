String? genericValidator(String? text){
    if (text!.isEmpty) {
      return 'Input cannot be empty';
    }
    return null; // Return null if the input is valid.
  }

String? emailValidator(String? text){
  if(!text!.contains(RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$'))){
    return "Invalid format. Please enter a valid email address";
  }
  return null;
}