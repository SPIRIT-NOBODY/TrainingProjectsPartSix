package tags;

import java.io.IOException;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.BodyContent;
import javax.servlet.jsp.tagext.BodyTagSupport;
import javax.servlet.jsp.tagext.TagSupport;

import database.Database;
import static helpers.QueryHelper.*;

public class SelectTag extends BodyTagSupport {	
	
	@Override
	public int doAfterBody() throws JspException {
		if (getParent() instanceof ConnectTag) {
			ConnectTag parent = (ConnectTag) getParent();
			Database db = parent.getDb();
			BodyContent body = getBodyContent();			
			String table = "";
			String dbTableName = parent.getTableName();
			String query = String.format(body.getString(), dbTableName);
			if(checkQuery(query,"select")) {				
				try {
					table = getTableResult(db.selectQuery(query),query);
				} catch (Exception e) {
					table = query;
					System.out.println(query);
				}
			}
			JspWriter out = body.getEnclosingWriter();
			try {				
				out.write(table);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				throw new JspException(e.toString());
			}
			
		}
		return EVAL_PAGE;
	}
	
	private String getTableResult(List<String[]> arResult,String query) {
		StringBuilder table = new StringBuilder();
		table.append("<table border=\"2\" style=\"min-width:65%;\">");
		table.append("<caption style=\border: solid 2px black;\">" + query + "</caption>");
		if(arResult.size() > 0 ) {	
			for (int i = 0; i < arResult.size(); i++) {
				table.append("<tr>");
				String[] row =  arResult.get(i);
				for (int j = 0; j < row.length; j++) {
					if( i == 0 ) {
						table.append("<th>" +row[j] + "</th>");
					}else {
						table.append("<td>" +row[j] + "</td>");
					}
				}
				table.append("<tr>");
			}
		}else {
			table.append("<tr><th>No result</th><tr>");
		}
		table.append("</table>");
		return table.toString();		
	}	
	
}
