public class BlueKeyData {
	
	public String key { get; set; }
	public String value { get; set; }
	public Boolean endTD { get; set; }
	public Boolean eoc { get; set; }
	
	public BlueKeyData(String k, String v, Boolean b, Boolean c) {
		key = k;
		value = v;
		endTD = b;
		eoc = c;
	}

}
