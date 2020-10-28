package database;

import java.lang.reflect.InvocationTargetException;
import java.sql.Array;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.Tag;
import javax.servlet.jsp.tagext.TagSupport;

/**
 * use database from part_four.task_one.database.Database
 */
public class Database {	
	
	private Connection connection;
	private Statement statement;
	private String url = "jdbc:mysql://127.0.0.1/java_test_db?serverTimezone=Europe/Moscow&useSSL=false&autoReconnect=true";
	public Database(String dbName , String user ,String password ,String tableName) throws JspException {		
		try {
			connection = DriverManager.getConnection(url, user, password);
			statement = connection.createStatement();
		} catch (SQLException e) {
			throw new JspException(e.toString());
		}			
	}
	public void closeConnection() throws JspException {
		if(connection != null) {
			try {
				connection.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				throw new JspException(e.toString());
			}
		}
	}
	
	public List selectQuery(String query) throws JspException{
		List<String[]> arResult = new ArrayList<>(); 
		List<String> header = new ArrayList<>();
		try {
			ResultSet selectResult = statement.executeQuery(query);
			ResultSetMetaData dbResultMeta = selectResult.getMetaData();			
			while(selectResult.next()) {
				List<String> row = new ArrayList<>();
				for (int i = 1; i <= dbResultMeta.getColumnCount(); i++) {			
					if(header.size() < dbResultMeta.getColumnCount()) {
						header.add(dbResultMeta.getColumnName(i));
					}					
					row.add(selectResult.getObject(i).toString());
				}
				if (row.size() > 0) {
					String[] tmpRow = new String[row.size()];
					row.toArray(tmpRow);
					arResult.add(tmpRow);					
				}
			}
			if(arResult.size() > 0) {
				arResult.add(0, header.toArray(new String[header.size()]));
			}
			
		} catch (SQLException e) {
			throw new JspException(e.toString());
		}
		return arResult;
	}
	
	public String updateQuery(String query) {
		String result = "";
		try {
			result =  statement.executeUpdate(query) + " row is modified. " + query;
		} catch (SQLException e) {
			result = "error: " + query + ".\n " + e;
		}
		return result;
	}

}
