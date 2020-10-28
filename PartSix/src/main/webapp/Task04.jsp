<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="ex" uri="/WEB-INF/customtags/ResultTag.tld"%>

<%
	/**
Собственный тег. В файле хранятся результаты лотереи (6 чисел). 
Атрибут — список чисел. 
Тег выдает количество совпавших чисел. Список задавать на форме.
*/
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Task 04</title>
</head>
<%
	String[] numbers = request.getParameterValues("numbers");
pageContext.setAttribute("numbers", numbers);

String fileUrl = getServletContext().getRealPath("files/results.txt");
%>
<body>
	<div>
		coincidences numbers:
		<ex:result numbers="${numbers}" file="<%= fileUrl %>" />
	</div>
	<div>
		<form method="POST">
			<div>
				Input number 1: <input name="numbers">
			</div>
			<div>
				Input number 2: <input name="numbers">
			</div>
			<div>
				Input number 3: <input name="numbers">
			</div>
			<div>
				Input number 4: <input name="numbers">
			</div>
			<div>
				Input number 5: <input name="numbers">
			</div>
			<div>
				Input number 6: <input name="numbers">
			</div>
			<div>
				<button type="submit">Send numbers</button>
			</div>
		</form>
	</div>
</body>
</html>