<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.io.*" import="java.util.*"%>
<%
	/**
	Есть 10 картинок (можно меньше, но обязательно больше трех). 
	3 из них предлагаются случайно для  формирования открытки. Также 
	должны присутствовать другие параметры для формирования открытки 
	(кому, подпись и т.п.). Открытку сформировать и показать.
	*/
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	String imageDir = "images";
	File images = new File(getServletContext().getRealPath(imageDir));
	String[] imagesList = images.list();
	String[] randomImagesList = new String[3];
	List<Integer> randomGenerated = new ArrayList<>();
	if (imagesList != null) {
		for (int i = 0; i < randomImagesList.length; i++) {
			int j = (int) (Math.random() * (imagesList.length));
			while (true) {
				if (!randomGenerated.contains(j)) {
					randomGenerated.add(j);
					break;
				}
				j = (int) (Math.random() * (imagesList.length));
			}
			randomImagesList[i] = imageDir + "/" + imagesList[j];
		}

	}

	String show = request.getParameter("show");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Task 01</title>
<style>
.image {
	float: left;
}

.image img {
	width: 400px;
}

.clear-both {
	clear: both;
}

.post-card {
	width: 1250px;
	background: azure;
	margin: 5px auto;
	min-height: 600px;
}

.post-card .post-images img {
	border: 2px solid red;
}

.post-card .post-images img:nth-child(1) {
	transform: rotate(-15deg);
	position: relative;
	top: 50px;
}

.post-card .post-images img:nth-child(3) {
	transform: rotate(15deg);
	position: relative;
	top: 50px;
}

.post-card .post-text {
	margin: 10px auto;
	width: fit-content;
}
</style>
</head>
<body>
	<%
		if (show != null && !show.trim().equals("")) {
			String[] imagesrc = request.getParameterValues("imagesrc");
			String message = request.getParameter("message");
			String from = request.getParameter("from");
			String to = request.getParameter("to");
	%>
	<div class="post-card">
		<div class="post-images">
			<%
				for (int i = 0; i < imagesrc.length; i++) {
			%>
			<img alt="<%=imagesrc[i]%>" src="<%=imagesrc[i]%>">
			<%
				}
			%>
		</div>
		<div class="post-text">
			<div class="text"><%=message%></div>
			<div class="from"><%=from%></div>
			<div class="to"><%=to%></div>
		</div>
	</div>

	<%
		} else {
	%>
	<div>
		<form action="" method="POST">
			<input type="hidden" name="show" value="Y">
			<%
				for (int i = 0; i < randomImagesList.length; i++) {
			%>
			<div class="image">
				<img src="<%=randomImagesList[i]%>" /> <input type="hidden"
					name="imagesrc" value="<%=randomImagesList[i]%>">
			</div>
			<%
				}
			%>

			<div class="clear-both"></div>
			<div>
				<textarea rows="5" cols="" name="message">Поздравляю!!</textarea>
			</div>
			<div>
				<input type="text" name="from" placeholder="From ">
			</div>
			<div>
				<input type="text" name="to" placeholder="To ">
			</div>
			<div>
				<button type="submit">Show post card</button>
			</div>
		</form>
	</div>
	<%
		}
	%>
</body>
</html>