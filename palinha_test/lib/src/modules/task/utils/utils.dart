String translateOption(String option) {
  switch (option) {
    case "Baixa":
      return "low";
    case "Média":
      return "medium";
    case "Alta":
      return "high";
    case "Urgente":
      return "urgent";
  }
  return "";
}

String translatePriority(String priority) {
  switch (priority) {
    case "low":
      return "Baixa";
    case "medium":
      return "Média";
    case "high":
      return "Alta";
    case "urgent":
      return "Urgente";
  }
  return "";
}
