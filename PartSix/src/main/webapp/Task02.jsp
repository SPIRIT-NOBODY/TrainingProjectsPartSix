<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.io.*" import="java.util.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	File filePrice = new File(application.getRealPath("price/price.txt"));
	/**
	В текстовом файле список товаров и цена в у.е. 
	Показать список по курсу в белорусских рублях. 
	Курс задается на форме.
	*/
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Task02</title>
</head>
<body>
	<ul>
		<%
			if (filePrice.exists()) {
				String course = request.getParameter("course");
				double doubleCourse = 0;
				if (course != null) {
					try {
						doubleCourse = Double.parseDouble(course);
					} catch (Exception e) {
		%>
		<li>Course must be is double type!</li>
		<%
			}
				}
				if (doubleCourse > 0) {
					out.print("<li>Current course is " + doubleCourse + "</li>");
				}

				try (BufferedReader rdFilePrice = new BufferedReader(new FileReader(filePrice))) {
					String line = rdFilePrice.readLine();
					while (line != null) {
						String[] arLine = line.split("\\|\\|");
						if (arLine.length == 2) {
		%>
		<li>Product: <%=arLine[0]%>. Price: <%=arLine[1]%>. <%
			if (doubleCourse > 0) {
								try {
									double usdPrice = Double.parseDouble(arLine[1]);
									double bynPrice = usdPrice * doubleCourse;
									out.print("Price in BYN: " + bynPrice);
								} catch (Exception e) {
									out.print("Price in BYN bust be double type");
								}
							}
		%>
		</li>
		<%
			}
						line = rdFilePrice.readLine();
					}
				} catch (Exception e) {
					out.print("<li>" + e.getMessage() + "</li>");
				}

			} else {
		%>
		<li>File with products not exist, check: price/price.txt</li>
		<%
			}
		%>
	</ul>
	<div>
		<form method="GET">
			<div>
				Course: <input name="course" type="number" step="0.01">
			</div>
			<div>
				<button type="submit">Set course</button>
			</div>
		</form>
	</div>
</body>
</html>