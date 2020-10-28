<%@ taglib uri="/WEB-INF/customtags/task06_tags.tld" prefix="task06"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%
	/*
	    Реализовать внешние и вложенные теги. 
	    Внешним тегом при помощи атрибута задается идентификатор базы данных.
		Внутренние – это теги добавления, удаления и выборки, причем информацию брать из тела.
	*/
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
	} catch (ClassNotFoundException e) {
		// TODO Auto-generated catch block
		throw new  JspException(e.toString());
	}
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Task 06</title>
<style>
body{
	max-width: 1200px;
	margin: 0 auto;
}
 .border{
	border: solid 2px black;
}
</style>
</head>
<body>	
	<div>
		<form method="post">
			<div >
				<div >
					Select: where ( MarkMath+  MarkLiterature+  MarkEnglish+  MarkProgramming)/ 4 > 4  <br> <input name="type" type="radio" value="select"
						checked="checked">
						<hr>
				</div>
				<div >
					Insert: VALUES (12,"Супер Ммооар",123,6,10,6,4) <br> <input name="type" type="radio" value="insert">
					<hr>
				</div>
				<div >
					Delete: where id = 2 <br><input name="type" type="radio" value="delete">
					<hr>
				</div>
				<div >
					<textarea name="query" rows="10" cols="50">where ( MarkMath+  MarkLiterature+  MarkEnglish+  MarkProgramming)/ 4 > 4</textarea>					
				</div>
				<div>
					<button type="submit">Send</button>
				</div>
			</div>
		</form>
	</div>
	<div>
	<br>
		<task06:connect dbName="java_test_db" tableName="students" user="root"
			password="">
			<task06:select><%=request.getParameter("type") + " * from %s " + request.getParameter("query")%></task06:select>
			<task06:insert><%=request.getParameter("type") + " into %s " + request.getParameter("query")%></task06:insert>
			<task06:delete><%=request.getParameter("type") + " from %s " + request.getParameter("query")%></task06:delete>
		</task06:connect>
	</div>
</body>
</html>