package tags;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyContent;
import javax.servlet.jsp.tagext.BodyTagSupport;
import javax.servlet.jsp.tagext.TagSupport;

import database.Database;
import static helpers.QueryHelper.*;

public class DeleteTag extends BodyTagSupport {
	@Override
	public int doAfterBody() throws JspException {
		if (getParent() instanceof ConnectTag) {
			ConnectTag parent = (ConnectTag) getParent();
			Database db = parent.getDb();
			BodyContent body = getBodyContent();			
			String dbTableName = parent.getTableName();
			String query = String.format(body.getString(), dbTableName);
			String result = "";
			if(checkQuery(query,"delete")) {
				result = db.updateQuery(query);
			}
			JspWriter out = body.getEnclosingWriter();
			try {
				out.write(result);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				throw new JspException(e.toString());
			}
			
		}
		return EVAL_PAGE;
	}
}
