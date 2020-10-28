package helpers;

public final class QueryHelper {
	public static boolean checkQuery(String query,String type) {
		return query.toLowerCase().startsWith(type);
	}
}
