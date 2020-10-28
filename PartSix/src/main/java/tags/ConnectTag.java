package tags;

import java.sql.Connection;
import java.sql.Statement;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import database.Database;

public class ConnectTag extends TagSupport{
	
	private String dbName;
	private String tableName;
	private String user;
	private String password;
	private Database db;
	
	public String getDbName() {
		return dbName;
	}

	public void setDbName(String dbName) {
		this.dbName = dbName;
	}

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
	public Database getDb() {
		return db;
	}
	
	@Override
	public int doStartTag() throws JspException {		
		db = new Database(dbName , user , password ,tableName);
		return EVAL_PAGE;
	}

	@Override
	public int doEndTag() throws JspException {
		db.closeConnection();
		return EVAL_PAGE;
	}
	
}
