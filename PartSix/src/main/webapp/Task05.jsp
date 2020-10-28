<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Enumeration"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.Locale"%>
<%
	/**
	5. Проанализировать, какой язык поддерживается клиентом (английский,белорусский или русский). 
	В зависимости от этого здороваться на соответствующем языке.
	*/

	Locale locale = request.getLocale();
	String language = locale.getLanguage();
	String country = locale.getCountry();

	Map<String, String> languages = new HashMap<>();
	languages.put("en", "Hello!");
	languages.put("ru", "Привет!");
	languages.put("be", "Прывет!");

	String text = languages.get("ru");
	if (languages.containsKey(language)) {
		text = languages.get(language);
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>Task 05</title>
</head>
<body>
	<p>
		<%=text%>
	</p>
</body>
</html>