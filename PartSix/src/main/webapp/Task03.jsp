<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	/**
Использование Java Beans. Рассчитать подоходный налог по доходу и базовой величине 
(см. соответствующую реализацию). Эти параметры задается на форме.  

0 — 240 базовых величин — 9%
240 — 600 базовых величин — 15%
600 — 840 базовых величин — 20%
840 — 1080 базовых величин — 25%
свыше 1080 базовых величин — 30%
Использовать массив (рекомендую с пятью элементами).
Предположим, человек заработал 650 б.в. (но Вы будете считать в рублях). 
Заработок разбивается на соответствующие группы согласно таблице:
650 = 240+360+50. С 240 берется 9%, с 360 — 15% и с 50 — 20% и суммируется. 
Это и есть подоходный налог согласно законодательству РБ.
Тесты: при базовой величине 19375
С 14567990— 2053348;
С 28012580— 5683524;
С 2800000 — 252000   
*/
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Task 03</title>
</head>
<body>

	<jsp:useBean id="tax" class="beans.TaxBean" scope="request">
		<jsp:setProperty name="tax" property="moneySumString" param="money" />
		<jsp:setProperty name="tax" property="baseValueString"
			param="baseValue" />
	</jsp:useBean>

	<p>
		Tax value:
		<jsp:getProperty name="tax" property="taxValue" /></p>
	<p>
		Money sum:
		<jsp:getProperty name="tax" property="moneySumString" /></p>
	<p>
		Base value:
		<jsp:getProperty name="tax" property="baseValueString" /></p>
	<div>
		<form method="POST" action="">
			<div>
				Base : <input name="baseValue" value="19375">
			</div>
			<div>
				Money: <input name="money">
			</div>
			<div>
				<button type="submit">Calculate</button>
			</div>
		</form>
	</div>
</body>
</html>